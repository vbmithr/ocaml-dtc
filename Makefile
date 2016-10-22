PKG=dtc

all:
	./build

PHONY: clean

clean:
	rm -f $(PKG).install
	./build -clean
