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
        #The pkgfile variable represent the shell file that will be excuted for the complile the files in the pkgtar archive
        pkgfile[$index]=`echo $pkg | sed 's/\(-\|\([0-9]\).\)\([0-9].\+\)\+\([a-z]\+\)\([a-zA-Z0-9].\+\)\(xz\|gz\|bz2\|bz\)//g'`
        pkgtar[$index]=$pkg
        index=`expr $index + 1`
    fi
    i=`expr $i + 1`
done

#Print parsed package
#i=0
#while [ "$i" -lt $index ]
#do
#    echo "${pkgfile[$i]}"
#    echo "${pkgtar[$i]}"
#    i=`expr $i + 1`
#done

searchIndex() {
    index=0
    packageFilename="${!1}"
    searchedFilename="${!2}"
    for pkg in ${packageFilename[@]}
    do
        if [ $2 == $pkg ]
        then
            return $index
        fi
    index=`expr $index + 1`
    done
    return -1
}

fileOrdered=(binutils gcc)

for f in ${fileOrdered[@]}
do
    searchIndex pkgfile[@] $f
    index=$?
    tar -xf "${pkgtar[$index]}"
    #sh pkgfile[$index]
done
