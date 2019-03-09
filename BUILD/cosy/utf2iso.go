package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	var line, out string
	initmaps()

	out = ""
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line = scanner.Text()
		out = convgost(line)
		fmt.Print(out, "\n")
	}
}
