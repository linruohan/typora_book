# fork的仓库同步更新+自定义修改
有一个仓库，fork自 longbridge仓，有自己的修改，但是希望跟longbridge仓更新保持一致，怎么操作

```bash
git fetch long ;git checkout main;git rebase long/main
```


要将你 Fork 的仓库与上游（longbridge 原仓库）保持同步，同时保留自己的修改，可以按照以下步骤操作：
## 添加上游远程仓库
首先，将原仓库（longbridge）添加为你的远程仓库的 upstream：
```bash
git remote add upstream https://github.com/longbridge/仓库名.git

git remote -v
```
输出应类似：
```bash
origin    https://github.com/你的用户名/仓库名.git (fetch)
origin    https://github.com/你的用户名/仓库名.git (push)
upstream  https://github.com/longbridge/仓库名.git (fetch)
upstream  https://github.com/longbridge/仓库名.git (push)
```
## 获取上游最新变更
```bash
# 拉取 longbridge 原仓库的最新代码：
git fetch upstream
```
## 合并或变基（Rebase）
### 方法 1：合并（Merge）

git checkout main  # 切换到你的主分支（假设是 main）
git merge upstream/main  # 合并上游的更新

    适用场景：简单、直接，适合团队协作或历史记录不重要的情况。
    缺点：会产生额外的合并提交（Merge commit）。

### 方法 2：变基（Rebase，推荐）

git checkout main
git rebase upstream/main

    适用场景：希望提交历史更干净，避免不必要的合并提交。
    缺点：如果已经推送过代码到 origin，可能需要 --force 推送（慎用）。

## 处理冲突

如果合并/变基时出现冲突：

    手动修改冲突文件（查找 <<<<<<< 标记）。
    标记冲突已解决：

    git add <冲突文件>
    git rebase --continue  # 如果是 rebase
    # 或
    git merge --continue   # 如果是 merge

## 推送更新到你的 Fork 仓库

git push origin main

如果使用了 rebase 并已经推送过，可能需要强制推送：

git push --force-with-lease origin main  # 比 --force 更安全

⚠️ 强制推送风险：如果其他人基于你的分支开发，可能会影响他们的代码。
## 保持长期同步

建议定期执行以下操作：

git fetch upstream
git rebase upstream/main  # 或 git merge upstream/main
git push origin main

额外建议

    使用分支保护
        如果你的 main 分支是受保护的（GitHub/GitLab），确保你有权限 --force 推送。

    本地开发使用 Feature 分支
        避免直接在 main 上修改，而是：

        git checkout -b feature/xxx
        # 开发完成后：
        git rebase main  # 确保代码基于最新上游
        git push origin feature/xxx

    GitHub 网页端同步
        GitHub 提供了 "Fetch upstream" 按钮（在 Fork 仓库页面），可以一键同步，但可能仍需本地处理冲突。
## 合并操作

```bash
# 2. 拉取最新代码
git fetch upstream
# 3. 合并或变基
git checkout main
git rebase upstream/main  # 或 git merge upstream/main
# 4. 处理冲突（如果有）
git add .
git rebase --continue
# 5. 推送更新
git push origin main
```
