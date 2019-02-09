package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	var eof = 0
	test_cosy()
	initmaps()
	cstr := ""
	wc := 0
	for {
		word := make([]byte, 6)
		n, err := os.Stdin.Read(word) // read a word
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
			estr := expandcosy(cstr)
			if estr == "*READ OLD\n" {
				//				eof++
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
