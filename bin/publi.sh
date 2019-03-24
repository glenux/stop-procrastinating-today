#!/bin/sh
# change the branch names appropriately
set -x
set -u
set -e

HTML_BRANCH=master
CODE_BRANCH=develop

# Cleanup
git worktree remove -f _site || true
rm -rf _site/ || true

# Link to branch
git worktree add -B "$HTML_BRANCH" _site "origin/$HTML_BRANCH" || true

# Build
JEKYLL_ENV=production jekyll build

# Commit new changes
cd _site
git add --all
git commit -m "`date`"
git push origin "$HTML_BRANCH"
cd ..


