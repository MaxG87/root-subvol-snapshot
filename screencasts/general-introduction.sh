#!/usr/bin/env bash

echo "# Let's create a snapshot!"
sleep 1s

echo
echo snapshot
snapshot

echo
echo '# As you noticed, the tool will ask for sudo permissions itself, so you do not have to prepend sudo all the time.'
sleep 3s
echo '# If you enabled the sudo credentials caching, a second invocation will run without interruptions.'
sleep 3s

echo
snapshot
echo snapshot

echo
echo "# So, let's restore some files. Let's assume I removed a precious file."
sleep 1s

echo
echo 'date | tee precious-file'
date | tee precious-file
sleep .5s
echo 'sha256sum precious-file | tee /tmp/SHA256SUMS'
sha256sum precious-file | tee /tmp/SHA256SUMS
sleep .5s
echo 'rm precious-file'
rm precious-file
sleep .5s

echo
echo "# First, we need to mount the snapshots subvolume."
sleep 1s

echo
echo 'sudo mount -o subvol=@snapshots /dev/mapper/ssd-root /mnt'
sudo mount -o subvol=@snapshots /dev/mapper/ssd-root /mnt
sleep .5s

echo
echo "# Now we can try to find to the most recent snapshot ..."
sleep 1s

echo
echo 'ls /mnt'
ls /mnt
sleep .5s

echo
echo "# ... and restore the file."
sleep 1s

# cp .../@home/$USER/precious-file .
#
#
# # Let's verify that everything is okay again.
#
# sha256sum -c /tmp/SHA256SUMS
# bat precious-file
