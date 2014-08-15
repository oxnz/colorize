DESTDIR	:= /usr/local/bin
all: colorize

colorize: colorize.pl
	cp colorize.pl $@
	chmod +x $@
	pod2man $@ > $@.1

install: colorize colorize.1
	install -p -D -m 0755 $< ${DESTDIR}/colorize
	install -p -D -m 0744 $<.1 /usr/local/man/man1/colorize.1

clean:
	${RM} colorize
	${RM} colorize.1
