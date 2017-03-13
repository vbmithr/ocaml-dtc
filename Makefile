PKG=dtc

all:
	./build ldb_browser.native hddownload.native

PHONY: clean

clean:
	rm -f $(PKG).install
	./build -clean
