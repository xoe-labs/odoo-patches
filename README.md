**A curated and organized collection of functional odoo patches.**
("Good bye [OCB](https://github.com/oca/ocb)")

# Quickstart
```
$ curl -fsSL https://git.io/vhRLh -o /tmp/install.sh

$ cd ~  # or to wherever you want this repo to live

# Always read convenience scripts downloaded from the internet
$ cat /tmp/install.sh

# All good?
$ bash /tmp/install.sh
```

# Naming Convention

For this to work as intended, we rely on the following naming convention:

### Regex in pcre (php) flavor

[>> Regex101 Playground <<](https://regex101.com/r/W8ETh3/5)

```regex
^((?:\d|F)\d\d\d)(?:(-\[(?:(?:|[a-zA-Z_]*?:)(?:\d|F)\d\d\d,)*(?:(?:|[a-zA-Z_]*?:)(?:\d|F)\d\d\d)\])|)::([a-zA-Z-_]*?)\.patch$
```

### Explanation

- The first token is made of 4 digits is a consecutive number within a given module scope or of a capital letter "F" followed by 3 digits within a global scope. "F" stands for "federated" and represents patches that span multiple modules.
- Dependencies are expressed by an optional `-[...]` after the first token. Normally, a dependency is indentified by it's first token (eg. `0001` or `F001`). If there is a dependency which reaches out to a patch in another module, prepend it with the module name: `[module_name/0001]` or `[module_name/F001]`

# Patch creation

**To generate a diff (in theory):**

https://wiki.postgresql.org/wiki/Creating_Clean_Patches
Just have a look at the gen-odoo-path script.

**To generate a diff (in practice):**
_Essentialy, this is what the quick-start script does._
```
cd ~
git clone git@github.com:xoes/odoo-patches.git
cd odoo-patches

# Do yourself a favour
echo "export odoo_patch_folder=$(pwd)/patches" >> ~/.bashrc \
&& chmod +x $(pwd)/gen-odoo-patch \
&& sudo ln -s $(pwd)/gen-odoo-patch /usr/local/bin/ \
&& bash
```

```
# Then, to generate your patch:
gen-odoo-patch [<commit>] [<subpath of your workdir>]
```

**Consider adding some useful description:**
```patch
This may be some useful description of this patch that
will be ignored by the diff/patch utility. USE IT!

--- a/foo  2002-02-21 23:30:39.942229878 -0800
+++ b/foo  2002-02-21 23:30:50.442260588 -0800
@@ -1,7 +1,6 @@
-The Way that can be told of is not the eternal Way;
-The name that can be named is not the eternal name.
The Nameless is the origin of Heaven and Earth;
-The Named is the mother of all things.
+The named is the mother of all things.
+
```

# Patch application
```
# Get the patch and try it
payload="$(curl -sL https://raw.githubusercontent.com/xoes/odoo-patches/11.0/patches/module_name/####::Description.patch)"
echo "${payload}" | patch -p1 --dry-run

# Happy?
echo "${payload"} | patch -p1
```


# Credits & License

Based on stewardship by:
 - [@yelizariev](https://github.com/yelizariev) ([IT-Projects LLC](https://it-projects.info))
 - [@blaggacao](https://github.com/blaggacao) ([XOE Solutions](https://xoe.solutions))

License: [LGPL-3](https://www.gnu.org/licenses/lgpl-3.0.en.html)


# TODOs

- Integrate with `hub` to fully automate initialization and patch-PRs
- PR-TEMPLATE -> `hub` - flow
- Do always try to pull before generating a patch & detect/imply next patch number
- Travis
  - Patches apply ceteris paribus cleanly in their order taking the database of last successful general run
  - Generate a new general run with the latest Odoo Upstream code - also - from time-to-time
  - Apply patch only with it's declared dependency tree -> Missing dependency