# 检查 NVM_DIR 环境变量是否存在，如果不存在就设置一个默认值
export NVM_DIR="$HOME/.nvm" 

# 加载 nvm.sh 脚本，让 nvm 命令可用
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  

# 检查项目根目录下是否有 .nvmrc 文件，如果有就自动切换
# 这是最佳实践！
if [ -f ".nvmrc" ]; then
  nvm use
fi

#!/bin/bash
# deploy.sh
mkdir -p data
docker compose up -d --build
echo "🎉 部署完成！访问: http://localhost:5173"
