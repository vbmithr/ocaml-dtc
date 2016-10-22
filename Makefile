PKG=dtc

all:
	./build ldb_browser.native

PHONY: clean

clean:
	rm -f $(PKG).install
	./build -clean
