#!/usr/bin/env bash

# FILENAME: download-images.sh
# AUTHOR: Zachary Krepelka
# DATE: Friday, August 28th, 2026
# USAGE: bash download-images.sh family/portraits.tsv
# ORIGIN: https://github.com/zachary-krepelka/genealogy.git
# UPDATED: Friday, September 4th, 2026 at 8:58 PM

test $# -eq 1 && test -f "$1" || {
	echo "$0: error: exactly one file argument expected" >&2
	exit 1
}

while IFS=$'\t' read -r file url
do
	if test -s "$file"
	then continue
	fi

	ext_src="${url##*.}" ext_src="${ext_src/jpeg/jpg}"
	ext_dest="${file##*.}"

	if test "${ext_src,,}" = "${ext_dest,,}"
	then wget -O "$file" "$url"
	else wget -O- "$url" | magick "$ext_src":- "$file"
	fi

done < "$1"
