#!/bin/bash

PRIMARY_C='\033[0;36m'
SECONDARY_C='\033[1;33m'


pushd ./apps/cli > /dev/null 2>&1
VERSION=$(head lib/cli.ex | egrep -o "@cli_version.*" | egrep -o "(\d{1,3}\.\d{1,3}\.\d{1,3})")
echo
echo -e "${PRIMARY_C}Building CLI Version ${SECONDARY_C}$VERSION"
echo
echo -e "${PRIMARY_C}Cleaning Project"
mix clean
echo -e "${PRIMARY_C}Building Project"
mix escript.build
echo -e "${PRIMARY_C}Done."
echo
echo -e "${PRIMARY_C}Generating Package."
mv cli ../../_build/codelation
popd > /dev/null 2>&1
pushd ./_build > /dev/null 2>&1
tar -czf "../codelation-$VERSION.tar.gz" codelation
popd > /dev/null 2>&1
echo -e "${PRIMARY_C}Package built to ./_build/codelation"
SHA=$(shasum -a 256 "codelation-$VERSION.tar.gz" | grep -o ".*\s")
echo
echo -e "${PRIMARY_C}CLI Version ${SECONDARY_C}$VERSION${PRIMARY_C} package checksum: ${SECONDARY_C}$SHA"
echo
