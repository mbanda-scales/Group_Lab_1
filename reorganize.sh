#!/usr/bin/env bash
set -euo pipefail

if [[ -d "file_renaming" ]]; then
    cd "file_renaming"
fi

shopt -s nullglob

for filepath in Chapter*Data*Set*.sav; do
    filename=$(basename "$filepath")

    if [[ "$filename" =~ Chapter[[:space:]]*([0-9]+)[[:space:]]*Data[[:space:]]*Set[[:space:]]*([0-9]+)\.sav ]]; then
        chap="${BASH_REMATCH[1]}"
        ds="${BASH_REMATCH[2]}"

        target_dir="Chapter${chap}"
        mkdir -p "$target_dir"

        cp "$filepath" "${target_dir}/DataSet${ds}.sav"
        echo "Copied: $filename -> ${target_dir}/DataSet${ds}.sav"
    fi
done

echo "Completed reorganizing"