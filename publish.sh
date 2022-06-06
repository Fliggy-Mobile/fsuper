#! /bin/bash

dart pub publish --dry-run

echo ""
echo "\033[33m This package will publish after 10s. Please make sure everything is ok. \033[0m"

count=1
while(($count<10))
do
    echo "$count.."
    let "count++"
    sleep 1
done

dart pub publish --server=https://pub.dartlang.org
