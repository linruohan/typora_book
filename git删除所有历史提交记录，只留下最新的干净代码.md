git 删除所有历史提交记录，只留下最新的干净代码

```bash
git checkout --orphan latest_branch;git add -A; git commit -am "first add"; git branch -D master; git branch -m master; git push -f origin master
```

```
1.Checkout

   git checkout --orphan latest_branch

2. Add all the files

   git add -A

3. Commit the changes

   git commit -am "commit message"


4. Delete the branch

   git branch -D master

5.Rename the current branch to master

   git branch -m master

6.Finally, force update your repository

   git push -f origin master
```