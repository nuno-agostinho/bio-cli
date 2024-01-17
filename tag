#!/bin/bash
lookup() {
  terms=${1}
  dir="/hps/nobackup/flicek/ensembl/variation/nuno"
  depth=3
  file=".tags"

  help() {
    echo "Usage: tag [term]      Search for tags in $dir"
    echo "       tag list        List all tags currently in use"
    echo "       tag files       List all tagged files"
  }

  if [ $# -eq 0 ]; then
    help
  elif [[ $terms == "files" ]]; then
    find $dir -maxdepth $depth -name $file
  elif [[ $terms == "cd" ]]; then
    terms=${2:?please give a tag}
    dir=$(dirname $(lookup -l $terms))
    cd "$dir" && echo $dir || echo "ERROR: issue when matching tag $terms"
  elif [[ $terms == "list" ]]; then
    lookup files | xargs cat | sort | uniq
  else
    lookup files | xargs ack -i $@ || echo "No results for '$@'"
  fi
}

lookup $@
