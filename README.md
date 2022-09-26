# root-subvol-snapshot

Script to snapshot all top level subvolumes on an BtrFS

## Installation

Either `sudo install snapshot /usr/local/bin` or `install snapshot ~/.local/bin`.

## Usage

This section will cover how to use the program. First it will be explained what
to expect when interacting manually with the program, then some suggestions for
automated usage will be given.

[![asciicast](https://asciinema.org/a/523387.svg)](https://asciinema.org/a/523387)

### Manual Interaction

This section assumes that the script is available via `$PATH` under the name
`snapshot`.

- There is a help message available via `snapshot --help`.
- For normal usage, `snapshot` is sufficient. It will create snapshots and
  delete these older than 60 days.
- Running `snapshot --max-age N` allows to set the maximum age in days
  explicitly. This is very helpful if one runs out of disk space.
- It is not possible to use this script to remove old snapshots without
  creating a new one. Since snapshots do not consume space, this feature does
  not seem to be worth the effort.
- It is safe to run this script on non-BtrFS devices. It will print a brief
  message and exit with exit code 0.

The default value of 60 days was chosen as good-fit for the author of this
script.

### Embedding to Automated Workflows

The author configured CRON to create a snapshot at every boot. For this, the
script was installed to `/usr/local/bin`, so it is available at boot for the
root user. Then, the line `@reboot snapshot` was added to the root user's CRON
file by running `sudo crontab -e`.

## Directory layout

Recall that the root of a BtrFS is not necessarily the `/` of the running
system. The root of a BtrFS is the subvolume with ID 0.

This script assumes that all subvolumes to snapshot are located directly at the
root of your BtrFS file system. Lets say your device is `$DEVICE`. Then the
following commands should produce the following output:

```bash
$ sudo mount -o subvolid=0 "$DEVICE" /mnt
$ ls /mnt
@ @home @snapshots shared
```

Here, the entries `@`, `@home` and `shared` are independent subvolumes which
shall be snapshotted into `@snapshots`.

Please note that `@snapshots` is listed here because `snapshot` would create it
right there. It is a subvolume itself. Some additional logic prevents that
`snapshot` would try to create a snapshot of `@snapshots`. See
[here](#restoring-from-snapshots) on the benefits of that.

The content of `@snapshots` will look similar to the following example:

```bash
$ sudo mount -o subvolid=0 "$DEVICE" /mnt
$ tree -L2 /mnt/@snapshots
/mnt/@snapshots
├── 2021-10-14_14:38:04
│  ├── @
│  ├── @home
│  └── shared
├── 2021-10-14_14:38:28
│  ├── @
│  ├── @home
│  └── shared
├── 2021-10-15_08:46:58
│  ├── @
│  ├── @home
│  └── shared
└── 2021-12-13_10:31:52
   ├── @
   ├── @home
   └── shared
```

Here, `@`, `@home` and `shared` are read-only subvolumes which were created as
snapshots of their respective top level correspondents. The parent folder name
states when the snapshot was created.

## Restoring from snapshots

### Undoing accidental deletes

In order to recover lost files, one can mount the snapshots subvolume to access
them there. Mounting them can be done via

```shell
sudo mount -o subvol=@snapshots $DEVICE_OF_ROOT /mnt
```

Now the snapshots are available at `/mnt`. They are grouped in subdirectories
with their creation times. One can simply `cd` into these and copy the lost
files or directories somewhere else.

Since the snapshots are created read-only, it should be impossible to alter
them.

### Restoring an old version of the subvolumes

Sometimes recovering files that were accidentally deleted is not enough. If it
is unclear what has to be undone to get rid of an undesired effect, it might be
helpful to restore a previous state completely. One example probably everyone
has experienced once would be calling `rm -rf /` in the wrong location. Another
example experienced by the author was that after experienting with GPU driver
configurations the graphical display did not work anymore.

It is easiest to restore subvolumes using a live system. Some subvolumes might
be recoverable from the running system too, but this guide does not cover that.

From inside the live system, first the root subvolume must be mounted:

```shell
DEVICE_OF_ROOT=/dev/mapper/ssd-root  # insert your device here
sudo mount -o subvolid=0 "$DEVICE_OF_ROOT" /mnt
```

Then all subvolumes are available under `/mnt`. For all subsequent commands it
is assumed that they are run from inside the mount directory.

```shell
cd /mnt
```

First the subvolume must be removed:

```shell
SUBVOLUME=@  # insert your subvolume here
sudo btrfs subvolume delete "$SUBVOLUME"
```

Then the desired snapshot must be snapshotted into the old location:

```shell
TIMESTAMP="2021-11-14_10:59:11"  # insert your timestamp here
SNAPSHOT="@snapshots/$TIMESTAMP/$SUBVOLUME
sudo btrfs subvolume snapshot "$SNAPSHOT" "$SUBVOLUME"
```

In case the subvolume that contains `/` is restored, the default subvolume must
be set, so it will be mounted automatically by Grub.

```shell
sudo btrfs subvolume show "$SUBVOLUME"
# read the subvolume id from the output
SUBVOLUME_ID=7331  # insert the correct value here
sudo btrfs subvolume set-default "$SUBVOLUME_ID" .
```

## TODO

- [Rewrite in Rust](https://github.com/ansuz/RIIR)
- Currently snapshots are grouped by date. Maybe a grouping by device can be
  provided additionally. Given how fast snapshots can be created and how few
  disk space they use, one could have both groupings simultaneously.
