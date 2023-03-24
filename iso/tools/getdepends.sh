#!/bin/bash
#原文链接：https://blog.csdn.net/qq_51470638/article/details/127136484
#$1 = pkg
get_all_depends()
{
        apt-cache depends --no-pre-depends --no-suggests --no-recommends \
                --no-conflicts --no-breaks --no-enhances\
                --no-replaces --recurse $1 | awk '{print $2}'| tr -d '<>' | sort --unique
}

mkdir packages-$1
cd packages-$1
for pkg in $*
do
        all_depends=$(get_all_depends $pkg)
        echo -e "所有依赖共计"$(echo $all_depends | wc -w)"个"
        echo $all_depends
        i=0
        for depend in $all_depends
        do
                i=$((i+1))
                echo -e "\033[1;32m正在下载第$i个依赖："$depend "\033[0m"
                apt-get download $depend
        done
done
