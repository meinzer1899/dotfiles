# https://bytes.usc.edu/cs104/wiki/makefile
# these rules do not correspont to a specific file
.PHONY:

all: update

# update linux
update: update/distro
	./scripts/update.sh

update/distro:
	sudo apt-get update && sudo apt-get upgrade -y

# https://wiki.zshell.dev/docs/guides/commands
# no_hup does not send the hup signal to running jobs, they therefore don't get killed when the parent job
# finishes (zi update command)
update/zi:
	zsh -ic "setopt no_hup && zi update --all --parallel --quiet"
	zsh -ic "zi self-update"
	zsh -ic "zi cclear -q"
