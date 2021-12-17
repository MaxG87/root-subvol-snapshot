# root-subvol-snapshot
Script to snapshot all top level subvolumes on an BtrFS

## Installation

Either `sudo install snapshot /usr/local/bin` or `install snapshot ~/.local/bin`.


## Usage
This section assumes that the script is available via `$PATH` under the name
`snapshot`.

* There is a help message available via `snapshot --help`.
* For normal usage, `snapshot` is sufficient. It will create snapshots and
  delete these older than 60 days.
* Running `snapshot --max-age N` allows to set the maximum age in days
  explicitly. This is very helpful if one runs out of disk space.
* It is not possible to use this script to remove old snapshots without
  creating a new one. Since snapshots do not consume space, this feature does
  not seem to be desirable.
* It is safe to run this script on non-BtrFS devices. It will print a brief
  message and exit with exit code 0.

The default value of 60 days was chosen as good-fit for the author of this
script.



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
right there. However it is a folder, not a subvolume. If `@snapshots` were a
subvolume `snapshot` would still work, but some additional empty folders would
be created which might be irritating.

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

## TODO

* [Rewrite in Rust](https://github.com/ansuz/RIIR)
* Currently snapshots are grouped by date. Maybe a grouping by device can be
  provided additionally. Given how fast snapshots can be created and how few
  disk space they use, one could have both groupings simultaneously.
