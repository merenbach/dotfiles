# dotfiles

My home and work dotfiles.

## Setup

For macOS, install Homebrew and then run the following:

    brew install git emacs coreutils ripgrep fd font-config shellcheck markdown

Next run the `setup` script to symlink/copy only universal (common) files, or `setup home`/`setup work` to copy both common and local files.

For GoLang defs in emacs:

    go get golang.org/x/tools/cmd/guru

For formatting:

    go get golang.org/x/tools/cmd/goimports

For syntax checks:

    go get -u gopkg.in/alecthomas/gometalinter.v2
    gometalinter.v2 --install


## Todo

Copy backup.exclude for home.
