#!/bin/sh
# change the branch names appropriately
set -x
set -u
set -e

# Cleanup
git worktree remove -f _site || true
rm -rf _site/ || true

# Link to branch
git worktree add -B gh-pages _site origin/gh-pages || true

# Build
JEKYLL_ENV=production jekyll build

# Commit new changes
cd _site
git add --all
git commit -m "`date`"
git push origin gh-pages
cd ..


