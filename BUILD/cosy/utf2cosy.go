package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	var line, cosy string
	var tail [20]byte
	initmaps()

	cosy = ""
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line = scanner.Text()
		if line == "*READ OLD" {
			break
		}
		cosy = makecosy(line + "\n")
		fmt.Print(cosy)
	}
	ss := []byte("*READ OLD")
	tail[9] = byte(0312)
	tail[10] = '\n'
	tail[11] = '\n'
	tail[12] = 0
	roldl := string(ss[0:9]) + string(tail[9:12])
	fmt.Print(roldl)
	ss = []byte("*END FILE ")
	tail[10] = byte(0311)
	tail[11] = '\n'
	tail[12] = 0

	endfl := string(ss[0:10]) + string(tail[10:12])
	fmt.Print(endfl)
}
