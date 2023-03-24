#!/bin/bash

# wersja linux
volumes=$(docker volume ls -q)

printf "%-20s %-15s\n" "Wolumin" "Zużycie [%]"

for volume in $volumes; do
    usage=$(docker run --rm -v $volume:/data busybox df -h /data | awk 'NR==2{print $5}' | cut -d'%' -f1)
    printf "%-20s %-15s\n" "$volume" "$usage%"
done


# wersja windows
volumes=$(docker volume ls --quiet)

for volume in $volumes
do
  used=$(docker run --rm -v $volume:/data alpine sh -c "df -h /data | awk 'NR==2{print \$5}'")
  echo "Volume $volume: uses $used"
done