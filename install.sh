#!/bin/bash
git clone https://github.com/xoe-labs/odoo-patches.git
cd odoo-patches

# Persist patch folder in environment variable
echo "export odoo_patch_folder=$(pwd)/patches" >> ~/.bashrc \
# Ensure it's executable
&& chmod +x $(pwd)/gen-odoo-patch \
# Copy script into path
&& cp $(pwd)/gen-odoo-patch /usr/local/bin/ \
# Load newly persisted environment variable
&& bash


YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "To generate a patch, in you odoo workdir:

\t${YELLOW}gen-odoo-patch [<commit>] -- [<subpath of your workdir>]${NC}

It's a convenience wrapper around 'git diff'. See also: 

\t${YELLOW}https://git-scm.com/docs/git-diff${NC}\n\n"