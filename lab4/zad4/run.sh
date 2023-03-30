#!/bin/bash
volume_name="$1"
output_dir="$2"

if [ -z "$volume_name" ] || [ -z "$output_dir" ]; then
    echo "usage: ./run.sh *volume_name* *directory*"
    exit 1
fi

archive_name="$volume_name.tar"
volume_path=$(docker volume inspect --format "{{ .Mountpoint }}" $volume_name 2> /dev/null)

if [ $? -gt 0 ]; then
    echo "Wolumin nie istnieje"
    exit 1
fi

if [ ! -d "$output_dir" ]; then
    echo "Katalog docelowy nie istnieje"
    exit 1
fi

sudo tar czf "$output_dir/$archive_name" "$volume_path"

if [ $? -gt 0 ]; then
    echo "Nie ma uprawnień"
    exit 1
fi

gpg --symmetric --cipher-algo AES256 --output "$output_dir/$archive_name.gpg" "$output_dir/$archive_name"

if [ $? -gt 0 ]; then
    echo "Anulowano lub inny błąd"
    exit 1
fi

echo "Wolumin $volume_name zaszyfrowany w folderze $(realpath $output_dir)"
