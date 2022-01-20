#!/bin/bash
# Modified from https://github.com/JuliaCI/install-julia/blob/master/install-julia.sh
VERSION="$1"

case "$VERSION" in
  [0-9]*.[0-9]*.[0-9]*)
    BASEURL="https://julialang-s3.julialang.org/bin"
    SHORTVERSION="$(echo "$VERSION" | grep -Eo '^[0-9]+\.[0-9]+')"
    JULIANAME="$SHORTVERSION/julia-$VERSION"
    ;;
  [0-9]*.[0-9])
    BASEURL="https://julialang-s3.julialang.org/bin"
    SHORTVERSION="$(echo "$VERSION" | grep -Eo '^[0-9]+\.[0-9]+')"
    JULIANAME="$SHORTVERSION/julia-$VERSION-latest"
    ;;
  *)
    echo "Unrecognized VERSION=$VERSION, exiting"
    exit 1
    ;;
esac

case $(uname -m) in
    x86_64)
        ARCH="x64"
        SUFFIX="linux-x86_64"
        ;;
    i386 | i486 | i586 | i686)
        ARCH="x86"
        SUFFIX="linux-i686"
        ;;
    aarch64)
        ARCH="aarch64"
        SUFFIX="linux-aarch64"
        ;;
    *)
        echo "Do not have Julia binaries for this architecture, exiting"
        exit 1
        ;;
esac
echo "$BASEURL/linux/$ARCH/$JULIANAME-$SUFFIX.tar.gz"
curl -L "$BASEURL/linux/$ARCH/$JULIANAME-$SUFFIX.tar.gz" | tar -xz
ln -s $PWD/julia-*/bin/julia /usr/local/bin/julia