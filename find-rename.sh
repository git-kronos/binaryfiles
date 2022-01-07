#!/bin/bash

# read -p "type= " type
type=$1
name=$2
main() {
	pattern=${name// /*}
	find . -type $type -iname "*$pattern*"
	read opt
	if [ $opt -eq 1 ]; then
		mkdir "#$name"
		find . -type $type -iname "*$pattern*" -exec mv {} "#$name" \;
	fi
}

main 2>/dev/null
clear
