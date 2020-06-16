# dotfiles

My home and work dotfiles.

## Setup

For macOS, install Homebrew and then run the following:

    brew install git emacs coreutils ripgrep fd
    brew install font-config
    brew install shellcheck markdown jq

Next run the `setup` script to symlink/copy only universal (common) files, or `setup home`/`setup work` to copy both common and local files.

Additional dependencies:

    go get -u golang.org/x/tools/cmd/guru
    go get -u github.com/fatih/gomodifytags
    go get -u github.com/cweill/gotests/...
    go get -u github.com/motemen/gore/cmd/gore
    go get -u github.com/mdempsky/gocode


For formatting:

    go get golang.org/x/tools/cmd/goimports

For syntax checks:

    go get -u gopkg.in/alecthomas/gometalinter.v2
    gometalinter.v2 --install


## Todo

Copy backup.exclude for home.
