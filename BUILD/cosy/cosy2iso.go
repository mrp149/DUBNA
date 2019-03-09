package main

import (
	"fmt"
	"os"
	"strings"
)

const iso string = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЫЬЭЮЯ"
const asc string = "abwgdevzijklmnoprstufhc~{}yx|`q"
const gst string = "aБbГДeЖЗИЙkЛmhoПpctyФxЦЧШЩЫЬЭЮЯ"

var iso_r []rune = []rune(iso)
var asc_r []rune = []rune(asc)
var gst_r []rune = []rune(gst)

var i2u = make(map[rune]rune, 100)
var u2i = make(map[rune]rune, 100)
var g2u = make(map[rune]rune, 100)

func initmaps() {
	if len(asc_r) != len(iso_r) {
		fmt.Fprint(os.Stderr, "something is fundamentally wrong\n")
	}
	for i := 0; i < len(asc_r); i++ {
		i2u[asc_r[i]] = iso_r[i]
		u2i[iso_r[i]] = asc_r[i]
		g2u[iso_r[i]] = gst_r[i]
	}
}

func iso2utf(r rune) rune {
	tr := i2u[r]
	if tr == rune(0) {
		fmt.Fprintf(os.Stderr, "unknown ISO symbol: %03o -> %03o\n", r, tr)
		return '*'
	}
	return tr
}

func gst2iso(r rune) rune {
	tr := g2u[r]
	if tr == rune(0) {
		fmt.Fprintf(os.Stderr, "unknown ISO symbol: %03o -> %03o\n", r, tr)
		return '*'
	}
	return tr
}

func convgost(inp string) string {
	var i int
	str := []rune(inp)

	for i = 0; i < len(str); i++ {
		if g2u[str[i]] != 0 {
			str[i] = g2u[str[i]]
		}
	}

	return strings.ToUpper(string(str))
}

func test_i2u() {
	initmaps()
	fmt.Println("UTF-ISO mapping")
	for i := 0; i < len(asc_r); i++ {
		fmt.Printf("%o %s %s %s  %s  %s %s %s\n", asc_r[i],
			string(asc_r[i]), "=", string(i2u[asc_r[i]]), "	",
			string(iso_r[i]), "=", string(u2i[iso_r[i]]))
	}

}

func makecosy(inp string) string {
	var out [200]byte
	var i, k, fl int
	k = 0
	fl = 0
	//fmt.Println(cosy)
	str := []rune(strings.ToUpper(inp))

	for i = 0; i < len(str); i++ {
		if str[i] > 0177 {
			str[i] = u2i[str[i]]
		}
		if str[i] == ' ' {
			// compress spaces
			fl++
			continue
		}

		if fl != 0 {

			if fl == 1 {
				out[k] = byte(0201) // ' ' is packed in ISOTCOSY
			} else {
				out[k] = byte(0200 + fl)
			}
			fl = 0
			k++

		}
		if str[i] != 012 {
			out[k] = byte(str[i])
			k++
		} else {
			break
		}

	}
	// it needs to be exactly 14 words
	if i < 83 {
		fl = 83 - i
		if fl == 1 {
			out[k] = ' '
		} else {
			out[k] = byte(0200 + fl)
		}
		fl = 0
		k++
	}
	out[k] = 012
	k++

	switch k % 6 {
	case 1:
		out[k] = 040
		k++
		fallthrough
	case 2:
		out[k] = 040
		k++
		fallthrough
	case 3:
		out[k] = 040
		k++
		fallthrough
	case 4:
		out[k] = 040
		k++
		fallthrough
	case 5:
		out[k] = 012
		k++
	case 0:
	}

	return string(out[0:k])
}

func expandcosy(cosy string) string {
	var out [200]rune
	k := 0
	//fmt.Println(cosy)

	str := []byte(cosy)
	for i := 0; i < len(str); i++ {
		if str[i] > 0177 {
			// do not expand spaces if the next symbol is NL
			// so not trailing spaces at the end of the line
			if str[i+1] == 012 {
				out[k] = 012
				k++
				break
			}
			for j := int(str[i] - 0200); j > 0; j-- {
				out[k] = ' '
				k++
			}
		} else {
			if str[i] > 0137 {
				out[k] = i2u[rune(str[i])]
			} else {
				out[k] = rune(str[i])
			}
			k++
		}
		if str[i] == 012 {
			break
		}
	}
	out[k] = '0'
	return string(out[0:k])
}

func prtbyte(st string) {
	var str []byte = []byte(st)
	for i := 0; i < len(str); i++ {
		if str[i] >= 040 && str[i] < 0200 {
			fmt.Printf("%c %03o", str[i], str[i])
		} else {
			fmt.Printf("%c %03o", '!', str[i])
		}
		fmt.Println(" ", i)
	}
}

func test_cosy() {

	initmaps()
	test_i2u()

	fmt.Println("Testing encoding/decoding")

	abc := []byte{'a', 'b', 0200, 'c', 0201, 'd', 0202, 'e', 0203, '*', 0204, 'I', 'R', 'V', '~', '`', '\n'}
	cabc := string(abc)
	eabc := expandcosy(cabc)
	nabc := makecosy(eabc)
	ru := iso2utf('\r')
	if ru != '*' {
		fmt.Println("The Magic of conversion!", string(ru))
	}
	fmt.Println(abc)
	prtbyte(cabc)
	fmt.Print("str=", eabc)
	if cabc != nabc {
		eabc1 := expandcosy(nabc)
		if eabc != eabc1 {
			fmt.Println("!!! lost in conversion")
			fmt.Print(eabc1)
		}
		prtbyte(cabc)
		fmt.Println("!!! cosy does not match")
		prtbyte(nabc)
	}
	fmt.Println("end of encoding/decoding")
}

func consistency() {
	cstr := ""
	wc := 0
	eof := 0
	for {
		word := make([]byte, 6)
		n, err := os.Stdin.Read(word) // read a six-bytes-word
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
			break
		}
		if n != 6 {
			fmt.Fprintln(os.Stderr, "bad input file")
			break
		}
		cstr += string(word)
		wc++
		if word[5] == 012 {
			//prtbyte(cstr)
			estr := expandcosy(cstr)
			if estr == "*READ OLD\n" {
				eof++
			}
			fmt.Print(estr)
			estrl := strings.ToLower(estr)
			fmt.Print(estrl)

			cstr1 := makecosy(estrl)
			if cstr != cstr1 {
				estr1 := expandcosy(cstr1)
				if estr != estr1 {
					fmt.Println("!!!!lost in conversion")
					fmt.Print(estr1)
				}
				prtbyte(cstr)
				fmt.Println("cosy does not match")
				prtbyte(cstr1)
			}

			cstr = ""
			wc = 0
		}
		if wc > 20 || eof != 0 {
			break
		}
	}
}
