#!/bin/bash
# requires: createrepo reposync wget curl rsync
set -e
set -o pipefail

_here=`dirname $(realpath $0)`
yum_sync="${_here}/yum-sync.py"

BASE_PATH="${TUNASYNC_WORKING_DIR}"
BASE_URL="${TUNASYNC_UPSTREAM_URL:-"https://update.cs2c.com.cn"}"
export REPO_SIZE_FILE=/tmp/reposize.$RANDOM

YUM_PATH="${BASE_PATH}/NS"


# =================== YUM/DNF repos ==========================
COMPONENTS="V10SP3"
"$yum_sync" "${BASE_URL}/NS/@{os_ver}/@{comp}/os/adv/lic/base/@{arch}/" V10 "$COMPONENTS" x86_64,aarch64 "@{os_ver}/@{comp}/os/adv/lic/base/@{arch}/" "$YUM_PATH"
"$yum_sync" "${BASE_URL}/NS/@{os_ver}/@{comp}/os/adv/lic/base/@{arch}/debug/" V10 "$COMPONENTS" x86_64,aarch64 "@{os_ver}/@{comp}/os/adv/lic/base/@{arch}/debug/" "$YUM_PATH"
echo "YUM finished"

"${_here}/helpers/size-sum.sh" $REPO_SIZE_FILE --rm
