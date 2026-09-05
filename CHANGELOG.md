# Changelog

## [0.3.0](https://github.com/MaxG87/root-subvol-snapshot/compare/v0.2.0...v0.3.0) (2026-09-05)


### Features

* Add systemd service to trigger execution at boot ([3bc3862](https://github.com/MaxG87/root-subvol-snapshot/commit/3bc3862ddf01f1df41b3189bd591d86d43fc4d77))
* Enable support for Python 3.12 ([642957b](https://github.com/MaxG87/root-subvol-snapshot/commit/642957bc6d865dc6de1cdc187f0595793829d300))
* Use /usr/bin for script location ([fda2b7d](https://github.com/MaxG87/root-subvol-snapshot/commit/fda2b7d5e55f812a6b522ad2b552276971973cfd))


### Bug Fixes

* Install script to /usr/local/bin ([6c8bb03](https://github.com/MaxG87/root-subvol-snapshot/commit/6c8bb0357e6bad55dda860a2069b0bb989db0172))
* Pass mountDir explicitly to remove_old_snapshots ([4d87780](https://github.com/MaxG87/root-subvol-snapshot/commit/4d877804a07b5b7f014a9ad7acc538ab00f5c028))


### Performance Improvements

* Avoid loop with per-element invocations ([2196b82](https://github.com/MaxG87/root-subvol-snapshot/commit/2196b821a96ceb228c3a43d52f70617ede7d0f6c))
* Improve performance by deleting en bloc ([c985012](https://github.com/MaxG87/root-subvol-snapshot/commit/c985012ba14f9623c0ff3d41a20c1d2020a52546))
* Improve snapshot deletion slightly ([b68317e](https://github.com/MaxG87/root-subvol-snapshot/commit/b68317e2ae0904b6c655ad9fdafbae344cfbfcd3))
* Replace dirname and basename with Bash string handling ([d2d8c4e](https://github.com/MaxG87/root-subvol-snapshot/commit/d2d8c4ede354af30081c8d4aa44eee12afa8a80e))
* Rewrite second loop too ([b9d38ea](https://github.com/MaxG87/root-subvol-snapshot/commit/b9d38ea6a767d0cd3c831ea6db94403ac90343d1))
* Rewrite snapshot creation to be pipe pased ([4fd45f8](https://github.com/MaxG87/root-subvol-snapshot/commit/4fd45f8812bde994b20e01008e5015dd4a8cbc3f))


### Documentation

* Explain why subvolumes including `/` are not snapshotted ([72bbc7b](https://github.com/MaxG87/root-subvol-snapshot/commit/72bbc7bb9ff0047e4767d533f364aee1776f5825))
* Improve message of `--help` ([4d31a14](https://github.com/MaxG87/root-subvol-snapshot/commit/4d31a146024c0325b7558521a5347f74a2c17a21))
* Switch documentation from Cron to systemd ([d826a5c](https://github.com/MaxG87/root-subvol-snapshot/commit/d826a5c905b909ee0ec7cde6fe5b908bc9b2b762))

## [0.2.0](https://github.com/MaxG87/root-subvol-snapshot/compare/v0.1.0...v0.2.0) (2023-09-12)


### Features

* Add command `snapshot` ([1e7c2a3](https://github.com/MaxG87/root-subvol-snapshot/commit/1e7c2a32d508cdeb12fcd0508b674b679e452906))
* Add py.typed marker file ([f708404](https://github.com/MaxG87/root-subvol-snapshot/commit/f708404bf28fc4495974fdf56d29e249152bce86))

## 0.1.0 (2023-08-30)


### ⚠ BREAKING CHANGES

* Dropped support for Python 3.8

### Features

* **cli:** Add first two CLI commands ([ba98a9e](https://github.com/MaxG87/root-subvol-snapshot/commit/ba98a9e7e9a08f9177244de009d16a73c3f3f85a))


### Bug Fixes

* **cicd:** Use correct project type in release-please ([2e5f5ce](https://github.com/MaxG87/root-subvol-snapshot/commit/2e5f5cea76d10758e2b3c85c2231206a04268a87))


### Documentation

* Add initial Changelog file ([8026b67](https://github.com/MaxG87/root-subvol-snapshot/commit/8026b6757a3f5984b679ec09742e356196b79b79))


### Miscellaneous Chores

* Dropped support for Python 3.8 ([689264d](https://github.com/MaxG87/root-subvol-snapshot/commit/689264db768c9aab408cf02a0f5eb1f6614e0598))

## 0.1.0

* initial release
