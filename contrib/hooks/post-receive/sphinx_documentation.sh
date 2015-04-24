#!/bin/sh
export GIT_WORK_TREE=work_tree

umask 0022

project=$(git config --get redminegitolite.projectid)
identifier=$(git config --get redminegitolite.repositoryid)
source=$(git config --get documentation.source)

target="/var/www/doc/${project}/html"

if [ -n "${source}" ]; then
  if [ -n "${identifier}" ]; then
    echo "    Documentation is only supported in the main repository"
    exit 1
  fi

  mkdir -p "${GIT_WORK_TREE}"
  mkdir -p "${target}"

  git checkout -f master
  sphinx-build -b html "work_tree/${source}" "${target}"
fi
