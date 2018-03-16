# dotfiles

My home and work dotfiles.


## Setup

Run `setup` to symlink/copy only universal files, or `setup home`/`setup work` to copy universal and local files.

For GoLang defs in emacs:

    go get golang.org/x/tools/cmd/guru

For formatting:

    go get golang.org/x/tools/cmd/goimports

For syntax checks:

    go get -u gopkg.in/alecthomas/gometalinter.v2
    gometalinter.v2 --install
