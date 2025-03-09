<script>
  export let themeName = "default";
</script>

<div class="titanic-theme {themeName}">
  <slot></slot>  <!-- Contenido insertado irá aquí -->
</div>

<style>
  /* Estilos generales para el tema Titanic */
  .titanic-theme.default {
    --bg-color: #f0f8ff;       /* color de fondo (azulado, evocando el mar) */
    --primary-color: #002147;  /* color primario (azul oscuro estilo uniforme naval) */
    --accent-color: #FDB813;   /* color acento (dorado, alusivo al Titanic) */;
    font-family: 'Segoe UI', sans-serif;
    background-color: var(--bg-color);
    color: #333;
    min-height: 100vh;
    padding: 1rem;
  }

  .titanic-theme.default h1 {
    text-align: center;
    margin-bottom: 1.5rem;
  }

  .titanic-theme.default .charts {
    display: grid;
    grid-template-columns: 1fr 1fr; /* dos columnas para gráficos */
    gap: 2rem;
  }

  .titanic-theme.default .filters {
    text-align: center;
    margin-bottom: 1rem;
  }

  .titanic-theme.default .filters label {
    margin: 0 1rem;
    font-weight: bold;
  }
</style>
