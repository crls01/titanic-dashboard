# Etapa de construcción
FROM node:18-alpine AS builder
WORKDIR /app

# Copiar dependencias y construir la app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa de producción
FROM node:18-alpine
WORKDIR /app

# Copiar el resultado del build
COPY --from=builder /app/build /app/build
COPY --from=builder /app/package.json /app/package.json
COPY --from=builder /app/node_modules /app/node_modules

# Exponer el puerto 3000 (puedes cambiarlo si lo necesitas)
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "build"]
