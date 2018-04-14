#!/bin/sh

export LFS=/mnt/lfs

mkdir -v pkg

#http://www.linuxfromscratch.org/lfs/view/stable/wget-list
curl -o wget-list $1

#http://www.linuxfromscratch.org/lfs/view/stable/md5sums
curl -o md5sums $2

mv wget-list md5sums pkg

cd pkg

pkgs=`cat md5sums`
