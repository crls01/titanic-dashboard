# Usa la imagen oficial de Node.js
FROM node:18-alpine

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY package.json package-lock.json ./
RUN npm install

# Copia el resto del código
COPY . .

# Expone el puerto 5173 (el puerto de Vite)
EXPOSE 5173

# Comando para iniciar la app
CMD ["npm", "run", "dev", "--", "--host"]
