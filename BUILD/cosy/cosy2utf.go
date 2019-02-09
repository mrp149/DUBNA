package main

import (
	"fmt"
	"os"
)

func main() {
	var eof = 0

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
				eof++
			}
			fmt.Print(estr)
			cstr = ""
			wc = 0
		}
		if wc > 20 || eof != 0 {
			break
		}
	}
}
