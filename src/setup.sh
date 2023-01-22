#!/bin/bash

PS4="+:\${0}:\${LINENO}: "
set -xeu -o pipefail

###
##
#

function assert_is_value {
    local -r value="${1}"
    if [[ "${value}" =~ --(.*)$ ]] || [ -z "${value}" ] ; then
        echo "ERROR:${0}:${LINENO}: CLI argument '${arg_name}' can not have value '${value}'." >&2
        exit 1
    fi
}

function do_install {
    set -e

    test -d "${DIR_ORIGIN}"

    if [ ! -d "${CHROOT}" ] ; then
        mkdir -p "${CHROOT}"
    fi

    if [ ! -d "${CHROOT}/usr/bin/" ] ; then
        install --directory --owner=root --group=root --mode=755 --verbose "${CHROOT}/usr/bin/"
    fi

    install --owner=root --group=root --mode=755 --verbose "${DIR_ORIGIN}/unison-this-with"  "${CHROOT}/usr/bin/unison-this-with"
}

function do_remove {
    set -e

    set +x
    echo "WARNING:${0}:${LINENO}: Unimplemented functionality call." >&2
    exit 1
}

###
##
#

while [ ${#} -gt 0 ] ; do
    arg_name="${1}"
    case "${arg_name}" in
        --install)  # Install.
            declare -r action=install
            ;;
        --uninstall)  # Uninstall.
            declare -r action=remove
            ;;
        --dir-origin)  # Sources location.
            arg_value="${2:-}"
            assert_is_value "${arg_value}"
            declare -r DIR_ORIGIN="${arg_value}"
            shift
            ;;
        --dir-destination)  # Destination ch.root directory.
            arg_value="${2:-}"
            assert_is_value "${arg_value}"
            declare -r DESTDIR="${arg_value}"
            declare -r CHROOT="${DESTDIR}"
            shift
            ;;
        *)
            echo "ERROR:${0}:${LINENO}: Unknown CLI argument '${arg_name}'." >&2
            exit 1
    esac
    shift
done


if [ "${action,,}" == "install" ] ; then
    do_install
elif [ "${action,,}" == "remove" ] ; then
    do_remove
fi

set +x
echo "+:${0}:${LINENO}: Job done." >&2
echo ""
