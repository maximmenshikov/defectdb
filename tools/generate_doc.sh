#!/bin/bash
# Generate documents for the project
# Usage: generate_doc.sh
# Script is supposed to be run from main folder.

. $(cd "$(dirname "$(which "$0")")"/.. ; pwd -P)/tools/lib/core.sh

load_library docgen
load_library target
load_library site

# Local variables
build_folder=$(target_linux_def_build_folder)
include_html=y
include_pdf=y
site=public

while test -n "$1" ; do
    case $1 in
        --without-pdf)
            include_pdf=
            ;;
        --without-html)
            include_html=
            ;;
    esac
    shift 1
done

lib_load_site "${site}"

build_folder="$(make_absolute "${TOP_DIR}" "${build_folder}")"
mkdir -p "${build_folder}"
cleanup_docgen "${build_folder}"

pushd "${build_folder}" > /dev/null
    export REAL_THEME_PATH="${build_folder}/sphinx_theme"
    export THEME_PATH="${REAL_THEME_PATH}/themes"

    # Download theme
    theme_download "${REAL_THEME_PATH}"

    if [ -n "${include_doxyrest}" ] ; then
        # Build the documentation using Doxygen
        doxygen_build "${build_folder}"

    fi

popd > /dev/null


mkdir -p "${build_folder}/rst"

# Copy static materials
static_material_copy "${TOP_DIR}" "${build_folder}/rst"

# Build documentation using Sphinx
if [ -n "${include_html}" ] ; then
    sphinx_build "${build_folder}" html "${include_doxyrest:+dev}"
fi

if [ -n "${include_pdf}" ] ; then
    sphinx_build "${build_folder}" pdf "${include_doxyrest:+dev}"
fi