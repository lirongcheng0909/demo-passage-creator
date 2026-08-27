/**
 * 环境变量配置
 * 由 env.example.ts 复制而来。
 * Docker 部署时使用相对路径 /api，由 Nginx 反向代理到后端（见 nginx.conf）。
 */

// API 基础地址
export const API_BASE_URL = '/api'
