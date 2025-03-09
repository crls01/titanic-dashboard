<script>
  // Recibimos del padre las variables vinculadas a cada filtro:
  export let selectedClass = "All";
  export let selectedSex = "All";
  export let selectedSurvived = "All";

  // Opciones disponibles para cada filtro:
  const classes = ["All", "1", "2", "3"];
  const sexes = ["All", "male", "female"];
  const survivalStates = ["All", "1", "0"]; // "1" = sobrevivió, "0" = no sobrevivió
</script>

<style>
  .filters {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 20px;
  }

  .filters select {
    padding: 8px;
    border: 2px solid #FFD700;
    border-radius: 5px;
    background: white;
    font-size: 1rem;
    color: black;
    font-weight: bold;
    cursor: pointer;
  }

  .filters label {
    font-weight: bold;
    color: white;
  }
</style>


<div class="filters">
  <label>
    Clase:
    <select bind:value={selectedClass}>
      <option value="All">All</option>
      <option value="1">1ra Clase</option>
      <option value="2">2da Clase</option>
      <option value="3">3ra Clase</option>
    </select>
  </label>

  <label>
    Sexo:
    <select bind:value={selectedSex}>
      <option value="All">All</option>
      <option value="male">Hombre</option>
      <option value="female">Mujer</option>
    </select>
  </label>

  <label>
    Supervivencia:
    <select bind:value={selectedSurvived}>
      <option value="All">All</option>
      <option value="1">Sobrevivió</option>
      <option value="0">No sobrevivió</option>
    </select>
  </label>
</div>

