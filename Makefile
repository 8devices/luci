LUAC = luac
LUAC_OPTIONS = -s

FILES = ffluci/config.lua

CFILES = ffluci/util.lua ffluci/http.lua \
ffluci/fs.lua ffluci/i18n.lua ffluci/model/uci.lua \
ffluci/template.lua ffluci/dispatcher.lua ffluci/menu.lua ffluci/init.lua

DIRECTORIES = dist/ffluci/model dist/ffluci/controller/public dist/ffluci/controller/admin dist/ffluci/i18n dist/ffluci/view

INFILES = $(CFILES:%=src/%)
OUTFILE = ffluci/init.lua

.PHONY: all dist-compile dist-source examples-compile examples-source dist examples compile source clean

all: compile

dist-compile: compile dist
dist-source: source dist

examples-compile: compile examples
examples-source: source examples


dist:
	cp src/ffluci/controller/public/* dist/ffluci/controller/public/
	cp src/ffluci/controller/admin/* dist/ffluci/controller/admin/
	cp src/ffluci/i18n/* dist/ffluci/i18n/
	cp src/ffluci/view/* dist/ffluci/view/ -R
	
examples:
	cp examples/* dist/ -R

compile:
	mkdir -p $(DIRECTORIES)
	$(LUAC) $(LUAC_OPTIONS) -o dist/$(OUTFILE) $(INFILES)
	for i in $(CFILES); do [ -f dist/$$i ] || ln -s `dirname $$i | cut -s -d / -f 2- | sed -e 's/[^/]*\/*/..\//g'``basename $(OUTFILE)` dist/$$i; done
	for i in $(FILES); do cp src/$$i dist/$$i; done

source:
	mkdir -p $(DIRECTORIES)
	for i in $(CFILES); do cp src/$$i dist/$$i; done
	for i in $(FILES); do cp src/$$i dist/$$i; done
	
clean:
	rm dist -rf
