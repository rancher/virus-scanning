#!/bin/bash

docker build -t eicar -f $(dirname "$0")/Dockerfile.eicar $(dirname "$0")

mkdir ./eicar -p
rm -rf ./eicar/*
wget -P ./eicar https://www.eicar.org/download/eicar.com.txt
tar -cvf ./eicar/eicar-1.tar ./eicar/eicar.com.txt
rm ./eicar/eicar.com.txt
last=1
for i in {2..99}
do
    echo "Compression level $i"
    tar -cvf ./eicar/eicar-$i.tar ./eicar/eicar-$last.tar
    rm ./eicar/eicar-$last.tar
    last=$i
done

docker build -t eicar-99-tar -f $(dirname "$0")/Dockerfile.eicar-99-tar $(pwd)/eicar

tar -cvf ./eicar/eicar-100.tar ./eicar/eicar-99.tar
rm ./eicar/eicar-99.tar

docker build -t eicar-100-tar -f $(dirname "$0")/Dockerfile.eicar-100-tar $(pwd)/eicar

echo "eicar
eicar-99-tar
eicar-100-tar" > test-images.txt
