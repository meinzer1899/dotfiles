#!/usr/bin/env bash

# [Returning a boolean from a Bash function](https://stackoverflow.com/questions/5431909/returning-a-boolean-from-a-bash-function/43840545?noredirect=1#comment79132096_5431932)

is_active() {
    [ "$1" == 'on' ] || [ "$1" == 'ok' ]
}

is_active_return() {
    if [ "$1" == 'on' ] || [ "$1" == 'ok' ]; then
        return
    fi
}

is_active_true() {
    if [ "$1" == 'on' ] || [ "$1" == 'ok' ]; then
        true
    else
        false
    fi
}

is_active_true2() {
    if [ "$1" == 'on' ] || [ "$1" == 'ok' ]; then
        true
    fi
    # returns false implicitly otherwise
}

var="ok"
if is_active "$var" ; then
    echo "true"
fi

if is_active_return "$var" ; then
    echo "true"
fi

if is_active_true "$var" ; then
    echo "true"
fi

if is_active_true2 "$var" ; then
    echo "true"
fi
