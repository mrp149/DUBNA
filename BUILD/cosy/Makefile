# Make file for cosy 

cmn = cosy2iso.go
cosy2utf = cosy2utf.go
utf2cosy = utf2cosy.go
utf2iso  = utf2iso.go
test = cosytest.go
src = $(cosy2utf) $(utf2cosy) $(utf2iso) $(test) $(cmn)

all: cosy2utf utf2cosy utf2iso fmt

cosy2utf: $(cosy2utf) $(cmn)
	go build -o $@ $(cosy2utf) $(cmn)

utf2cosy: $(utf2cosy) $(cmn)
	go build -o $@ $(utf2cosy) $(cmn)

utf2iso: $(utf2iso) $(cmn)
	go build -o $@ $(utf2iso) $(cmn)

run:

test:  $(test) $(cmn)
	go run $(test) $(cmn) < /dev/null

fmt:  $(src)
	go fmt $(src)

