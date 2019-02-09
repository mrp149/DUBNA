package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	var line, cosy string
	var tail [4]byte
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
	tail[0] = byte(0312)
	tail[1] = '\n'
	tail[2] = '\n'
	tail[3] = 0
	roldl := string(ss[0:9]) + string(tail[0:3])
	fmt.Print(roldl)
	ss = []byte("*END FILE ")
	tail[0] = byte(0311)
	tail[1] = '\n'
	tail[2] = 0

	endfl := string(ss[0:10]) + string(tail[0:2])
	fmt.Print(endfl)
}
