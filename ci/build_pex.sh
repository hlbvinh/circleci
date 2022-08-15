#!/bin/bash
set -e

# update build dependencies inside docker only
if [ -f /.dockerenv ]; then
    sudo pip install $(cat requirements.txt | grep 'pex==')
    sudo pip install future-annotations
fi

sudo pip install --upgrade pip

echo "### 1 ###"
TORCH_VERSION=`cat requirements.txt | grep -Po '(?<=torch==).*'`

echo "### 1 ###"
PYTHON_VERSION=`cat tox.ini | grep -Po '(?<=basepython = python)[0-9]\.[0-9]' | tr -d .`

echo "### 1 ###"
sed -e "/ambi_utils/c\ambi_utils" \
    -e "/torch==/c$(echo https://download.pytorch.org/whl/cpu/torch-${TORCH_VERSION}%2Bcpu-cp${PYTHON_VERSION}-cp${PYTHON_VERSION}m-linux_x86_64.whl)" \
    requirements.txt > /tmp/requirements.txt

echo "### 1 ###"

cat subdependencies_requirements >> /tmp/requirements.txt

#echo "### PEX BUILD DIR BEFORE BUILD ###"
#touch ~/.pex/build
#ls -lah ~/.pex/build || true



# cache for max 1 year
# TODO once we have a lock file for the dependencies and subdependencies
# we could use the --intransitive option
echo "###pex build###"
pex -vvvv -r ./ambi_utils/requirements.txt -c skynet -o python.pex

echo "### 2 ###"
PEX_NAME="$(bash ci/get_pex_name.sh get_pex_name)"

echo "copying python.pex to $PEX_NAME"
mkdir -p ~/artifacts
cp python.pex ~/artifacts/$PEX_NAME

#echo "### PEX BUILD DIR AFTER BUILD ###"
#ls -lah ~/.pex/build || true
