# ASCIIpOrtal main Makefile by zorun, inspired in part from kaw's one.
# This is in fact a placeholder, real compilation is done in Makefile.xxx

# See the common makefile for relevant options: 'Makefile.common'
# Also check the 'Makefile.example' file if you plan to port ASCIIpOrtal
# on another system/architecture.

# List of available ports
PORTS = mingw32 nosdl nosdl32 linux linux32

# standard build (should work on most unix if SDL is available)
# downloads and builds PDcurses against SDL for convenience.
# See 'linux' target if you already have PDCurses built against SDL.
default:
	$(MAKE) -f Makefile.$@ $@

# Other ports
$(PORTS):
	$(MAKE) -f Makefile.$@ $@

# Generate a tarball with the default setup. Not used for releases, see 'all'
dist:
	$(MAKE) -f Makefile.default $@

# Development target: doesn't clean anything
dev:
	$(MAKE) -f Makefile.dev $@

# Package the source
source:
	$(MAKE) -f Makefile.default $@

debian-source:
	$(MAKE) -f Makefile.default $@

# Release target: compile and pack everything.
# This assumes running on a 64 bits linux environment.
all: source
	$(foreach port,$(PORTS),$(MAKE) -k -f Makefile.$(port) all;)

install:
	$(MAKE) -f Makefile.default $@

# Additional specific cleanup is done in child Makefiles
clean:
	rm -f *.o
	$(MAKE) -f Makefile.default clean
	$(MAKE) -f Makefile.dev clean

execlean:
	$(MAKE) -f Makefile.default $@
	$(foreach port,$(PORTS),$(MAKE) -k -f Makefile.$(port) $@;)

# Remove any tarball generated
distclean:
	$(MAKE) -f Makefile.default distclean
	$(foreach port,$(PORTS),$(MAKE) -k -f Makefile.$(port) $@;)
