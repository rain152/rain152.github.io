# 🚀 GitHub Pages 部署指南

## 📋 当前状态
- ✅ 本地Git仓库已初始化
- ✅ 项目文件已提交
- ✅ GitHub仓库 `rain152.github.io` 已创建
- 🎯 目标：部署到 `https://rain152.github.io/ConsisID/`

## 🔧 部署步骤

### 1. 确保GitHub Pages已启用
1. 前往：https://github.com/rain152/rain152.github.io/settings/pages
2. 在 "Source" 下选择 "Deploy from a branch"
3. 选择 "main" 分支
4. 选择 "/ (root)" 文件夹
5. 点击 "Save"

### 2. 运行部署脚本
```bash
./deploy.sh
```

### 3. 验证部署
- 等待5-10分钟后访问：https://rain152.github.io/ConsisID/
- 检查所有文件是否正确加载（图片、视频等）

## 🎯 方案二：独立仓库部署（备选）

如果你希望创建一个独立的仓库来管理这个项目：

1. 在GitHub创建新仓库：`ConsisID`
2. 修改 `deploy.sh` 中的配置：
   ```bash
   REPOSITORY_NAME="ConsisID"
   ```
3. 运行部署脚本

## 🐛 常见问题解决

### 问题1：视频文件过大无法上传
如果视频文件超过100MB，需要使用Git LFS：
```bash
git lfs install
git lfs track "*.mp4"
git add .gitattributes
git commit -m "Add Git LFS for video files"
```

### 问题2：GitHub认证问题
如果推送时遇到认证问题，使用Personal Access Token：
1. 前往：https://github.com/settings/tokens
2. 生成新的token
3. 使用token作为密码进行推送

### 问题3：静态资源路径问题
如果部署后资源加载失败，可能需要调整HTML中的路径为相对路径。

## 📞 需要帮助？
如果遇到任何问题，请检查：
1. GitHub仓库是否为Public
2. GitHub Pages是否已启用
3. 分支名是否为 `main`
4. 文件路径是否正确
