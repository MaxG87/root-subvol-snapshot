#!/usr/bin/env zsh

source ~/.zshrc

function pseudotype() {
    local MIN_SLEEP_MS=75
    local MAX_SLEEP_MS=150
    string=$1
    for ((i = 0; i < ${#string}; i++)); do
        # while read -r -n1 character; do
        echo -n "${string:$i:1}"
        sleep_ms=$((RANDOM % (MAX_SLEEP_MS - MIN_SLEEP_MS) + MIN_SLEEP_MS))
        sleep_arg="$(printf ".%03ds" $sleep_ms)"
        sleep "$sleep_arg"
    done
    echo
}

LONG_WAIT=3s
SHORT_WAIT=1s

pseudotype "# Let's create a snapshot!"

echo
sleep "$SHORT_WAIT"
pseudotype snapshot
snapshot

echo
sleep $LONG_WAIT
pseudotype '# As you noticed, the tool will ask for sudo permissions itself, so you do not have to prepend sudo all the time.'
pseudotype '# If you enabled the sudo credentials caching, a second invocation will run without interruptions.'

echo
sleep $SHORT_WAIT
pseudotype snapshot
snapshot

echo
pseudotype "# So, let's restore some files. Let's assume I removed a precious file."
# sleep $LONG_WAIT

# echo
pseudotype 'date | tee precious-file'
# date | tee precious-file
# sleep $SHORT_WAIT
pseudotype 'sha256sum precious-file | tee /tmp/SHA256SUMS'
# sha256sum precious-file | tee /tmp/SHA256SUMS
# sleep $SHORT_WAIT
pseudotype 'rm precious-file'
# rm precious-file
# sleep $SHORT_WAIT

# echo
pseudotype "# First, we need to mount the snapshots subvolume."
# sleep 1s

# echo
pseudotype 'sudo mount -o subvol=@snapshots /dev/mapper/ssd-root /mnt'
# sudo mount -o subvol=@snapshots /dev/mapper/ssd-root /mnt
# sleep $SHORT_WAIT

# echo
pseudotype "# Now we can try to find to the most recent snapshot ..."
# sleep 1s

# echo
pseudotype 'ls /mnt'
# sleep $SHORT_WAIT
# ls /mnt
# sleep $SHORT_WAIT

# latest_snapshot=$(find /mnt -maxdepth 1 -mindepth 1 -type d | sort)

# echo
pseudotype "# ... and restore the file."
# sleep 1s

pseudotype "cp $latest_snapshot/@home/\$USER/precious-file ."
# sleep $SHORT_WAIT
# cp "$latest_snapshot/@home/$USER/precious-file" .

# echo
pseudotype "# Let's verify that everything is okay again."
# sleep 1s

# echo
pseudotype "sha256sum -c /tmp/SHA256SUMS"
# sleep $SHORT_WAIT
# sha256sum -c /tmp/SHA256SUMS
# sleep $SHORT_WAIT
pseudotype "bat precious-file"
# sleep $SHORT_WAIT
# bat precious-file
# sleep $SHORT_WAIT
