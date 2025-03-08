CUPLD := docker run -v ${PWD}:/work -e CHOWN=$(id -u ${USER}):$(id -g ${USER}) -it dinoboards/cpld-toolchain:1.0.0 cupld
WSL_WIN_BIN_PATH := Y:\\home\\dean\\dinoboards\\vga-for-rc\\bin\\

# Assuming we are running on WSL, then we can use the
# windows version of atfu
ATFU := atfu.exe

all: bin/u1.jed bin/u2.jed bin/u3.jed

bin/u1.jed: u1.pld
	@$(CUPLD) u1.pld

bin/u2.jed: u2.pld
	@$(CUPLD) u2.pld

bin/u3.jed: u3.pld
	@$(CUPLD) u3.pld

clean:
	@rm -rf bin

.PHONY: flash-u1
flash-u1: bin/u1.jed
	$(ATFU) erase --force
	$(ATFU) program $(WSL_WIN_BIN_PATH)u1.jed

.PHONY: flash-u2
flash-u2: bin/u2.jed
	$(ATFU) erase --force
	$(ATFU) program $(WSL_WIN_BIN_PATH)u2.jed

.PHONY: flash-u3
flash-u3: bin/u3.jed
	$(ATFU) erase --force
	$(ATFU) program $(WSL_WIN_BIN_PATH)u3.jed
