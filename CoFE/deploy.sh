#!/bin/bash

# GitHub Pages 部署脚本 - 子目录部署版本
# 将项目部署到 rain152.github.io/LFA-Video-Generation/

# 配置信息
GITHUB_USERNAME="rain152"
MAIN_REPO="rain152.github.io"
PROJECT_NAME="CoFE"

echo "🚀 开始部署到GitHub Pages子目录..."

# 临时克隆主仓库
TEMP_DIR="../temp_main_repo"
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

echo "🚀 克隆主仓库..."
git clone git@github.com:${GITHUB_USERNAME}/${MAIN_REPO}.git "$TEMP_DIR"

# 创建或更新子目录
echo "� 创建/更新子目录..."
rm -rf "${TEMP_DIR}/${PROJECT_NAME}"
mkdir -p "${TEMP_DIR}/${PROJECT_NAME}"

# 复制当前项目文件
echo "📋 复制项目文件..."
cp -r * "${TEMP_DIR}/${PROJECT_NAME}/"

# 进入主仓库目录并提交
cd "$TEMP_DIR"
git add .
git commit -m "Update ${PROJECT_NAME} project page"

echo "📤 推送到GitHub..."
git push origin main

# 清理临时目录
cd ..
rm -rf "$TEMP_DIR"

echo "✨ 部署完成！"
echo "🌐 你的网站将在几分钟后可以通过以下链接访问："
echo "   https://${GITHUB_USERNAME}.github.io/${PROJECT_NAME}/"
