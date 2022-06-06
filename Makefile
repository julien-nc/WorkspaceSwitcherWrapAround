EXT_NAME = workspace-switch-wraparound
UUID = $(EXT_NAME)@theychx.org
BUNDLE = $(UUID).shell-extension.zip

all: pack

pack:
	@gnome-extensions pack --force src
	@echo extension packed!

install: pack
	@gnome-extensions install $(BUNDLE) --force
	@echo extension installed!

uninstall:
	@gnome-extensions uninstall $(UUID)
	@echo extension uninstalled!

enable:
	@gnome-extensions enable $(UUID)
	@echo extension enabled!

disable:
	@gnome-extensions disable $(UUID)
	@echo extension disbled!

test_wayland: install
	# https://wiki.gnome.org/Attic/GnomeShell/Extensions/Writing#Extension_Creation
	@dbus-run-session -- gnome-shell --nested --wayland

test: install enable

listen:
	journalctl -o cat -n 0 -f "$$(which gnome-shell)" | grep -v warning
