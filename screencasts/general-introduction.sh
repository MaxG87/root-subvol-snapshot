#!/usr/bin/env bash

LONG_WAIT=3s
SHORT_WAIT=1s
VERY_SHORT_WAIT=.5s

function pseudoprompt() {
    echo -en "\e[44m ~ \e[0m\e[34m\e[0m "
}

function pseudotype() {
    local MIN_SLEEP_MS=75
    local MAX_SLEEP_MS=150
    sleep .${MAX_SLEEP_MS}s
    string=${1:-}
    for ((i = 0; i < ${#string}; i++)); do
        printf "%s" "${string:$i:1}"
        sleep_ms=$((RANDOM % (MAX_SLEEP_MS - MIN_SLEEP_MS) + MIN_SLEEP_MS))
        sleep_arg="$(printf ".%03ds" $sleep_ms)"
        sleep "$sleep_arg"
    done
    echo
}

function info() {
    while [[ $# -gt 0 ]]; do
        echo -en "\e[1;30m"
        pseudotype "$1"
        echo -en "\e[0;0m"
        pseudoprompt
        shift
    done
    sleep "$SHORT_WAIT"
}

function print-and-exec() {
    local time_to_sleep="$2"
    pseudotype "$1"
    eval "$1"
    pseudoprompt
    sleep "$time_to_sleep"
}

pseudoprompt
sleep $SHORT_WAIT
info "# Let's create a snapshot!"
print-and-exec snapshot "$SHORT_WAIT"

info ""
info '# As you noticed, the tool will ask for sudo permissions itself, so you do not' \
    '# have to prepend sudo all the time. If you enabled sudo credentials caching, a' \
    '# second invocation will run without password prompt.'
print-and-exec snapshot "$SHORT_WAIT"

info ""
info "# So, let's create a precious file we can restore."
print-and-exec 'head -c 1024 /dev/urandom > precious-file' "$SHORT_WAIT"
print-and-exec 'sha256sum precious-file | tee /tmp/precious-file.shasum' "$SHORT_WAIT"
print-and-exec 'snapshot' "$VERY_SHORT_WAIT"
print-and-exec 'rm precious-file' "$VERY_SHORT_WAIT"

info ""
info "# In order to restore it, we first need to mount the snapshots subvolume."
print-and-exec 'sudo mount -o subvol=@snapshots /dev/mapper/ssd-root /mnt' "$VERY_SHORT_WAIT"
info "# Now we can find the most recent snapshot ..."
print-and-exec 'ls /mnt | tail | column -c 80' "$LONG_WAIT"
latest_snapshot=$(find /mnt -maxdepth 1 -mindepth 1 -type d | sort | tail -n1)
info "# ... and restore the file."
print-and-exec "cp $latest_snapshot/@home/\$USER/precious-file ." "$VERY_SHORT_WAIT"

info ""
info "# Let's verify that everything is okay again."
print-and-exec "sha256sum -c /tmp/precious-file.shasum" "$SHORT_WAIT"
