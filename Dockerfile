FROM node:18-alpine AS builder
WORKDIR /app
RUN npm install -g pnpm
COPY package*.json ./
RUN pnpm install
COPY . .
RUN pnpm build

FROM node:18-alpine
RUN npm install -g serve
WORKDIR /app
COPY --from=builder /app/dist ./dist
RUN mkdir -p /app/data && chown -R node:node /app
USER node
EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
