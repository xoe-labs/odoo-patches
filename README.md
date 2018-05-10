**A curated and organized collection of functional odoo patches.**
("Good bye [OCB](https://github.com/oca/ocb)")

# Quickstart
```
$ cd ~ && curl -fsSL https://git.io/vprGZ -o /tmp/install.sh

# Always read convenience scripts downloaded from the internet
$ sudo bash /tmp/install.sh
```

# Naming Convention

For this to work as intended, we rely on the following naming convention:

### Regex in pcre (php) flavor

[>> Regex101 Playground <<](https://regex101.com/r/kv21jD/2)

```regex
(?'id'\d\d\d\d)-(?:(?'deps'\[(?:\d\d\d\d,)*(?:\d\d\d\d)\])-|)(?'scope'list|of|odoo|modules|please insert the whole list)::(?'desc'[a-zA-Z-]*?)\.patch
```

### Examples
```bash
0001-odoo::This-should-be-a-really-long-and-comprehensive-naming-of-the-patch-to-save-on-OP-hoops.patch
0002-[0001]-odoo::This-patch-depends-on-0001-expressed-by-the-[0001]-before-the-module.patch
0003-hr_payroll::Oh-and-the-odoo-module-represents-a-global-scoped-patch-which-spans-more-than-one-module.patch
0004-[0003]-hr_payroll_account::This-might-be-a-sister-patch-which-only-can-be-applied-if-the-module-will-be-installed.patch
```

# Patch creation

**To generate a diff (in theory):**

https://wiki.postgresql.org/wiki/Creating_Clean_Patches
```
# Long version
git diff --patch --minimal --stat --no-renames --ignore-space-at-eol --ignore-blank-lines --ignore-space-change --ignore-all-space --ignore-submodules [<commit>] [<path>]

# Short version
git diff -p --minimal --stat --no-renames --ignore-space-at-eol --ignore-blank-lines -b -w --ignore-submodules [<commit>] [<path>]
```

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
payload="$(curl -sL https://raw.githubusercontent.com/xoes/odoo-patches/11.0/patches/####-module::Description.patch)"
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