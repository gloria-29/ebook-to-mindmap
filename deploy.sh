#!/bin/bash
# deploy.sh
mkdir -p data
docker-compose up -d --build
echo "🎉 部署完成！访问: http://localhost:5173"
