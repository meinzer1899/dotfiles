# https://bytes.usc.edu/cs104/wiki/makefile
# https://github.com/search?q=MAKEFLAGS+language%3AMakefile&type=code

# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
# If mentioned as a target with no prerequisites, .SILENT says not to print any recipes before executing them.
# You may also use more selective ways to silence specific recipe command lines.See Recipe Echoing.  If you
# want to silence all recipes for a particular run of make, use the ‘-s’ or‘--silent’ option (see Summary of
# Options).
.SILENT :=
.DEFAULT := all

# Recommended flags
# https://github.com/lgersman/make-recipes-in-different-scripting-languages-demo#some-more-helpful-make-settings
# --no-builtin-variables: tells make to not create out of the box variables like (CC), (YACC) and stuff
# --no-builtin-rules: tells make to not create c/c++ standard rules for targeting yacc/c/cc++ files
MAKEFLAGS +=	--silent \
		--no-print-directory \
		--warn-undefined-variables \
		--no-builtin-variables \
		--no-builtin-rules

# SHELL = /bin/bash
# prefer using a shell script when calling multiple (complex) command and set shellflags there
# .SHELLFLAGS = -o pipefail -o nounset
# setting shellflags in a target is as easy as set -e; command | cat
SUDO := $(shell which sudo)

.PHONY: help
help: ## Show this help.
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk -F':.*?##' '{printf "%-30s %s\n", $$1, $$2}'

.PHONY: all
all: update ## Updates all the things.

.PHONY: update
update: apt-update ## Updates all the things.
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
	# zsh -ic "zi self-update" # don't activate because of security reasons
	# zsh -ic "zi cclear -q"

.PHONY: docker
docker: ## Install docker.
	-$(SUDO) apt remove docker docker-engine docker.io containerd runc
	$(SUDO) apt update
	-$(SUDO) apt install -y uidmap
	curl -fsSL https://get.docker.com | sh
