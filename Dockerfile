# 使用Node.js 20版本替代18版本
FROM node:20-alpine AS builder
WORKDIR /app
RUN npm install -g pnpm
COPY package*.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM node:20-alpine
RUN npm install -g serve && apk add --no-cache wget
WORKDIR /app
COPY --from=builder /app/dist ./dist
RUN mkdir -p /app/data && chown -R node:node /app
USER node
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1
CMD ["serve", "-s", "dist", "-l", "3000"]
