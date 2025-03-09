# Titanic Dashboard

## 🚀 Descripción del Proyecto

Este proyecto es un **dashboard interactivo** desarrollado con **Svelte y D3.js**, que permite analizar los datos de los pasajeros del Titanic de forma visual. Se incluyen gráficos interactivos y filtros para explorar la información de manera intuitiva.

## 📊 Tecnologías Utilizadas

- **Svelte** → Framework frontend para construir interfaces reactivas.
- **D3.js** → Librería para visualización de datos.
- **Docker** → Para empaquetar y desplegar el dashboard.
- **Vite** → Servidor de desarrollo rápido para Svelte.

## 🖼️ Gráficos Implementados

1. **Diagrama de Barras**&#x20;
2. **Gráfico de Dispersión**&#x20;
3. **Gráfico de Líneas**&#x20;
4. **Gráfico de Pastel**&#x20;

## 🎛️ Filtros Disponibles

- **Clase** (1ª, 2ª y 3ª).
- **Sexo** (Hombre/Mujer).
- **Supervivencia** (Sí/No).

## 🛠️ Instalación y Uso

### 🔹 1. Clonar el Repositorio

```bash
git clone https://github.com/crls01/titanic-dashboard.git
cd titanic-dashboard
```

### 🔹 2. Instalar Dependencias

```bash
npm install
```

### 🔹 3. Ejecutar en Modo Desarrollo

```bash
npm run dev
```

Acceder en el navegador: [**http://localhost:5173**](http://localhost:5173)

### 🔹 4. Construcción para Producción

```bash
npm run build
```

## 📦 Uso con Docker

### 🔹 1. Construir la Imagen Docker

```bash
docker build -t titanic-dashboard .
```

### 🔹 2. Ejecutar el Contenedor

```bash
docker run -d -p 5173:5173 --name titanic-container titanic-dashboard
```

Acceder en [**http://localhost:5173**](http://localhost:5173)

### 🔹 3. Detener y Eliminar el Contenedor

```bash
docker stop titanic-container

docker rm titanic-container
```


