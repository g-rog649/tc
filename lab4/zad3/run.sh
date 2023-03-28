#!/bin/bash
if [[ $EUID > 0 ]]; then
    echo "Uruchom przez sudo (wymagany dostęp do /var/lib/docker/volumes)"
    exit 1
fi

volume_names=$(docker volume ls --format "{{ .Name }}")
volume_sizes=$(xargs -I{} -n1 sudo du -sb /var/lib/docker/volumes/{}/_data <<< "$volume_names" | cut -f1)
volume_size_sum=$(paste -sd+ <<< "$volume_sizes" | bc -l)
volume_sizes_percent=$((xargs -I{} -n1 echo "scale=2;{}*100/$volume_size_sum" | bc -l) <<< "$volume_sizes" | sed 's/$/%/')
paste <(echo "$volume_sizes_percent") <(echo "$volume_names") | sort -k1,1 -r
