#!/usr/bin/env bash

set -e

CONFIG="install.conf.yaml"
DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"

# Remove dotbot if it exists
if [ -d "${DOTBOT_DIR}" ]; then
    echo "Removing existing dotbot..."
    git submodule deinit -f "${DOTBOT_DIR}" 2>/dev/null || true
    git rm -rf "${DOTBOT_DIR}" 2>/dev/null || true
    rm -rf ".git/modules/${DOTBOT_DIR}"
    rm -rf "${DOTBOT_DIR}"
fi

# Add dotbot as a submodule (using -f to override gitignore)
echo "Adding dotbot as a submodule..."
git submodule add -f https://github.com/anishathalye/dotbot "${DOTBOT_DIR}"
git submodule update --init --recursive

# Execute dotbot
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
