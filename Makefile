PKG=dtc

all:
	./build lib-byte ldb_browser.byte

PHONY: clean

clean:
	rm -f $(PKG).install
	./build -clean
