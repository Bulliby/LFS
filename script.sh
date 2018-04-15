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
i=1
index=0

for pkg in $pkgs
do
    if [ `expr $i % 2` -eq 0 ]
    then
        ret[$index]="$pkg"
        index=`expr $index + 1`
    fi
    i=`expr $i + 1`
done

#Print parsed package
#i=0
#while [ "$i" -lt $index ]
#do
#    echo "${ret[$i]}"
#    i=`expr $i + 1`
#done
