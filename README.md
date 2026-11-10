# Vortex UI Home Assistant Add-on

This repository packages [Vortex UI](https://github.com/xSaleGG/vortex-ui) as a Home Assistant Supervisor add-on, available from the Home Assistant Add-on Store.

[![Add Vortex UI add-on repository](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FxSaleGG%2Faddon-vortex-ui)

Alternatively, add `https://github.com/xSaleGG/addon-vortex-ui` manually under **Settings → Add-ons → Add-on Store → ⋮ → Repositories**.

## Publishing

Publishing a release in the Vortex UI repository updates this repository and starts the add-on image build.

### One-time setup

In the `vortex-ui` repository, add an Actions repository secret named `ADDON_REPO_TOKEN`. The token must have Contents read/write access to this repository, and be permitted to push to `main`. The release workflow uses it to update `config.yaml` and `CHANGELOG.md` here. That push starts this repository's `publish.yml` workflow.

After the first successful publish, set the `addon-vortex-ui-*` package visibility to **public** in GitHub Packages so Home Assistant can pull the images.

### Each release

1. Merge the app changes and version update to `main` in `vortex-ui`.
2. Publish a GitHub Release whose tag matches the app version. Include release notes.
3. Check that the `Sync release to add-on` workflow in the app repository and the `Publish add-on images` workflow here both succeed. The add-on images are published for `amd64`, `aarch64`, and `armv7`.
4. Once the add-on workflow succeeds, update Vortex UI from the Home Assistant Add-on Store.

Changes limited to the add-on `Dockerfile` can be published by manually running the `Publish add-on images` workflow.
