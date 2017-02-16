#!/usr/bin/env bash
# To copy newest version of config files, compile notes and TEX templates

# the directory where configuration files are
DIR_FROM="${HOME}"

# the subdirectory they are sent to
SUBDIR=/configuration_files

# the destination they are copied to.
# `"$0"` is filename (with path) of this script.
DIR_REPO=$(dirname "$0")
DIR_TO=${DIR_REPO}${SUBDIR}

# To first copy (deleting old versions), then set them to read-only.
transfer() {
   local file_from="${DIR_FROM}/$1"
   local file_to="${DIR_TO}/$1"
   cp -f "${file_from}" "${file_to}"
   chmod 444 "${file_to}"
}

# list of filenames to be copied.
LIST_FILE=(
   .vimrc
   .bashrc
   .bash_profile
   .gitconfig
)

len_file=${#LIST_FILE[@]}

# Do for all files listed above:
for ((i=0; i<=${len_file}-1; i++))
do
   transfer "${LIST_FILE[i]}"
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To export notes as PDF.
DIR_NOTES=${DIR_REPO}/notes
DIR_SCRIPTS=${DIR_REPO}/scripts
RUN_PANDOC=${DIR_SCRIPTS}/run_pandoc.sh

rm -f ${DIR_NOTES}/*.pdf

for f in ${DIR_NOTES}/*.md;
do
   "${RUN_PANDOC}" "${f}"
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To delete auxiliary files of TeX templates.
DIR_TEMPLATES=${DIR_REPO}/tex_templates
for f in ${DIR_TEMPLATES}/*.{pdf,log,aux,gz};
do
   rm -f "${f}"
done

