#!/bin/bash


set -e


PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"


check_command(){

    command -v $1 >/dev/null 2>&1 || {

        echo "ERROR: $1 not installed"

        exit 1

    }

}



banner(){

echo ""
echo "===================================="
echo "$1"
echo "===================================="
echo ""

}
