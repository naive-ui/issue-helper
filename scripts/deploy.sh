#!/usr/bin/env sh

set -e

npm run build

cd dist

git remote add upstream https://github.com/naive-ui/issue-helper.git
git add -A
git commit -m 'feat: deploy'

git push -f git@github.com:naive-ui/issue-helper.git gh-pages

# 部署到码云
# git push -f git@gitee.com:naive-ui/issue-helper.git main

cd -