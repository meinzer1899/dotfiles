#!/usr/bin/env bash

# [Returning a boolean from a Bash function](https://stackoverflow.com/questions/5431909/returning-a-boolean-from-a-bash-function/43840545?noredirect=1#comment79132096_5431932)
# [conditional execution](https://unix.stackexchange.com/a/22738)

to_lower_tr() {
    # b="$(echo $a | tr '[A-Z]' '[a-z]')"
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

to_lower_comma_operator() {
    echo "${1,,}"
}

##? Check whether a string represents "true" (1, y, yes, t, true, o, on).
# https://github.com/mattmc3/zdotdir/blob/85bdc0f22d250554b2295a8ae812ba4c7d749232/lib/archive/__init__.zsh#L70
# =~ is regex comparison
is_true() {
    [[ -n "$1" && "$1" =~ (1|y(es|)|t(rue|)|o(n|)) ]]
}

is_active_regex_lower_and_upper() {
    [[ "$1" =~ [oO]([nN]|[kK]) ]]
}

is_active_regex() {
    [[ "$1" =~ o(n|k) ]]
}

is_active_short() {
    [ "$1" == 'on' ] || [ "$1" == 'ok' ]
}

is_active_true() {
    if [ "$1" == 'on' ] || [ "$1" == 'ok' ]; then
        true
    else
        false
    fi
}

# returns true for "off" or "no"
# is_active_return() {
#     if [ "$1" == 'on' ] || [ "$1" == 'ok' ]; then
#         return
#     fi
# }

# returns true for "off" or "no"
# is_active_true_implicit() {
#     if [ "$1" == 'on' ] || [ "$1" == 'ok' ]; then
#         true
#     fi
#     # returns false implicitly otherwise
# }

ERROR=0

string_representing_true=(1 y yes t true o on)
for string in "${string_representing_true[@]}"; do
    if ! is_true "$string"; then
        echo "is_true returned \"false\" unexpectedly"
    fi
done

# Positive test cases
vars=("OK" "Ok" "ON" "On")
funcs=(to_lower_tr to_lower_comma_operator)
for f in "${funcs[@]}"; do
    for value in "${vars[@]}"; do
        lower=$($f "$value")
        if ! [[ $lower =~ o[kn] ]]; then
            echo "Function $f returned \"false\" for \"$value\" unexpectedly"
            ERROR=1
        fi
    done
done

# Test cases lowercase
varsPositive=("ok" "on")
funcs=(is_active_short is_active_regex is_active_true)
for e in "${funcs[@]}"; do
    for value in "${varsPositive[@]}"; do
        if ! $e "$value"; then
            echo "Function $e returned \"false\" for \"$value\" unexpectedly"
            ERROR=1
        fi
    done
done

# Test cases both uppercase and lowercase
varsPositive=("On" "ON" "Ok" "OK")
funcs=(is_active_regex_lower_and_upper)
for e in "${funcs[@]}"; do
    for value in "${varsPositive[@]}"; do
        if ! $e "$value"; then
            echo "Function $e returned \"false\" for \"$value\" unexpectedly"
            ERROR=1
        fi
    done
done

# Negative test cases
varsNegative=("off" "no" "asd")
for e in "${funcs[@]}"; do
    for value in "${varsNegative[@]}"; do
        if $e "$value"; then
            echo "Function $e returned \"true\" for \"$value\" unexpectedly"
            ERROR=1
        fi
    done
done

[[ $ERROR -ne 0 ]] && exit 1

echo "All tests passed"
