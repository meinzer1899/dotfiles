# https://bytes.usc.edu/cs104/wiki/makefile
# https://github.com/search?q=MAKEFLAGS+language%3AMakefile&type=code

# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
# these rules do not correspont to a specific file
.PHONY:
# If mentioned as a target with no prerequisites, .SILENT saysnot to print any recipes before executing them.
# You may also use moreselective ways to silence specific recipe command lines.See Recipe Echoing.  If you
# want to silence all recipes for a particular run of make, use the ‘-s’ or‘--silent’ option (see Summary of
# Options).
.SILENT:

MAKEFLAGS += --silent \
	     --warn-undefined-variables \
             --no-print-directory
# SHELL = /bin/bash
# prefer using a shell script when calling multiple (complex) command and set shellflags there
# .SHELLFLAGS = -o pipefail -o nounset
# setting shellflags in a target is as easy as set -e; command | cat
SUDO := $(shell which sudo)

.PHONY: help
help: ## Show this help.
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk -F':.*?##' '{printf "%-30s %s\n", $$1, $$2}'

.PHONY: all
all: update

.PHONY: update
update: apt-update
	./scripts/update.sh

.PHONY: apt-update
# when finished, closes shell w/ root privileges
apt-update: ## Update distro.
	$(SUDO) apt-get update && sudo apt-get upgrade -y

# https://wiki.zshell.dev/docs/guides/commands
# no_hup does not send the hup signal to running jobs, they therefore don't get killed when the parent job
# finishes (e.g. via zi update command).
# If .ONESHELL is mentioned as a target, then when a target is built all lines of the recipe will be given to
# a single invocation of the shell rather than each line being invoked separately. See Recipe Execution.
.ONESHELL: zi
.PHONY: zi
zi: ## Update zi plugins and zi itself.
	zsh -ic "setopt no_hup && zi update --all --parallel --quiet"
	zsh -ic "zi self-update"
	zsh -ic "zi cclear -q"

.PHONY: docker
docker: ## Install docker.
	-$(SUDO) apt remove docker docker-engine docker.io containerd runc
	$(SUDO) apt update
	-$(SUDO) apt install -y uidmap
	curl -fsSL https://get.docker.com | sh
