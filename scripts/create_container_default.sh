#!/bin/sh

DESCRIPTION="A container like the router firmware can create it"
CONTAINER_NAME="default_container"
ROOTFS_LIST="default.txt"

echo "This creates a default container similar to the one the router can create of its own."
echo ""
echo "It is necessary to build these Open Source projects in this order:"
echo "- Linux-PAM-1.2.1.sh"
echo "- busybox-1.24.2.sh"
echo "- finit-1.10.sh"
echo "- zlib-1.2.8.sh"
echo "- dropbear-2016.73.sh"
echo "- mcip.sh"
echo "- pcre-8.38.sh"
echo "- metalog-3.sh"
echo "- timezone2016e.sh"
echo " "
echo "These packages only have to be compiled once. After that you can package the container yourself with"
echo " # scripts/mk_container.sh -n ${CONTAINER_NAME} -l ${ROOTFS_LIST}"
echo " "
echo "Continue? <y/n>"

read text
! [ "${text}" = "y" ] && exit 0

SCRIPTSDIR="$(dirname $0)"
TOPDIR="$(realpath ${SCRIPTSDIR}/..)"
. ${TOPDIR}/scripts/common_settings.sh

# compile the needed packages
${OSS_PACKAGES_SCRIPTS}/Linux-PAM-1.2.1.sh all
${OSS_PACKAGES_SCRIPTS}/busybox-1.24.2.sh all
${OSS_PACKAGES_SCRIPTS}/finit-1.10.sh all
${OSS_PACKAGES_SCRIPTS}/zlib-1.2.8.sh all
${OSS_PACKAGES_SCRIPTS}/dropbear-2016.73.sh all
${OSS_PACKAGES_SCRIPTS}/mcip.sh all
${OSS_PACKAGES_SCRIPTS}/pcre-8.38.sh all
${OSS_PACKAGES_SCRIPTS}/metalog-3.sh all
${OSS_PACKAGES_SCRIPTS}/timezone2016e.sh all

# package container
echo " "
echo "Packaging the container"
${TOPDIR}/scripts/mk_container.sh -n "${CONTAINER_NAME}" -l "${ROOTFS_LIST}" -d "${DESCRIPTION}" -v "1.0"
