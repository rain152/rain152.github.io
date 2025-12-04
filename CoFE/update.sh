#!/bin/bash

# 🔄 项目更新部署脚本
# 用于快速更新已发布的GitHub Pages项目

# 配置信息
GITHUB_USERNAME="rain152"
MAIN_REPO="rain152.github.io"
PROJECT_NAME="CoFE"

echo "🔄 开始更新项目..."

# 检查是否有未提交的更改
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "📝 发现本地更改，正在提交..."
    
    # 显示更改的文件
    echo "📋 更改的文件："
    git status --porcelain
    
    # 添加所有更改
    git add .
    
    # 获取提交信息
    read -p "📝 请输入提交信息 (回车使用默认信息): " commit_msg
    if [ -z "$commit_msg" ]; then
        commit_msg="Update project content - $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    
    # 提交更改
    git commit -m "$commit_msg"
    echo "✅ 本地更改已提交"
else
    echo "ℹ️  没有发现本地更改"
fi

echo "🚀 开始部署到GitHub Pages..."

# 临时克隆主仓库
TEMP_DIR="../temp_main_repo"
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

echo "📥 克隆主仓库..."
git clone git@github.com:${GITHUB_USERNAME}/${MAIN_REPO}.git "$TEMP_DIR"

# 创建或更新子目录
echo "📁 更新子目录..."
rm -rf "${TEMP_DIR}/${PROJECT_NAME}"
mkdir -p "${TEMP_DIR}/${PROJECT_NAME}"

# 复制当前项目文件（排除不需要的文件）
echo "📋 复制项目文件..."
cp -r --exclude='.git' --exclude='*.sh' --exclude='DEPLOYMENT_GUIDE.md' * "${TEMP_DIR}/${PROJECT_NAME}/" 2>/dev/null || {
    # 如果cp不支持--exclude，使用rsync
    rsync -av --exclude='.git' --exclude='*.sh' --exclude='DEPLOYMENT_GUIDE.md' . "${TEMP_DIR}/${PROJECT_NAME}/"
}

# 进入主仓库目录并提交
cd "$TEMP_DIR"
git add .

# 检查是否有变化需要提交
if git diff --cached --quiet; then
    echo "ℹ️  没有发现需要部署的变化"
    cd ..
    rm -rf "$TEMP_DIR"
    echo "✨ 项目已是最新状态！"
    echo "🌐 访问你的网站：https://${GITHUB_USERNAME}.github.io/${PROJECT_NAME}/"
    exit 0
fi

git commit -m "Update ${PROJECT_NAME} project - $(date '+%Y-%m-%d %H:%M:%S')"

echo "📤 推送到GitHub..."
git push origin main

# 清理临时目录
cd ..
rm -rf "$TEMP_DIR"

echo "✨ 更新部署完成！"
echo "🌐 你的网站将在几分钟后更新："
echo "   https://${GITHUB_USERNAME}.github.io/${PROJECT_NAME}/"
echo ""
echo "💡 提示："
echo "   - 通常需要等待 2-5 分钟才能看到更新"
echo "   - 如果更新没有显示，可以尝试强制刷新页面 (Ctrl+F5)"
