#!/bin/sh
set -e

DEV_TOOLS_VERSION=${1:-3.4.1}

wget https://github.com/phalcon/phalcon-devtools/archive/v${DEV_TOOLS_VERSION}.tar.gz -O - | tar -zx -C /usr/src
ln -s /usr/src/phalcon-devtools-${DEV_TOOLS_VERSION}/phalcon.php /usr/bin/phalcon