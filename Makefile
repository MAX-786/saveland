# Makefile for Saveland package

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# Main executable
BIN = saveland

install:
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m 755 $(BIN) $(DESTDIR)$(BINDIR)/$(BIN)

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(BIN)

.PHONY: install uninstall