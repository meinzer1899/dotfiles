all: update

# update linux
update: update/distro update/zi
	./scripts/update.sh

update/distro:
	sudo apt-get update && sudo apt-get upgrade -y

update/zi:
	# https://wiki.zshell.dev/docs/guides/commands
	zsh -ic "zi update --all --parallel --quiet"
	zsh -ic "zi self-update"
	zsh -ic "zi cclear"
