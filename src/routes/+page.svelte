<script>
  import { onMount } from 'svelte';
  import * as d3 from 'd3';
  import BarChart from '$lib/charts/BarChart.svelte';
  import ScatterPlot from '$lib/charts/ScatterPlot.svelte';
  import PieChart from '$lib/charts/PieChart.svelte';
  import LineChart from '$lib/charts/LineChart.svelte';
  import Filters from '$lib/Filters.svelte';

  let data = [];           
  let filteredData = [];   

  let selectedClass = "All";
  let selectedSex = "All";
  let selectedSurvived = "All";

  onMount(async () => {
    data = await d3.csv('/Titanic-Dataset.csv', d => ({
        Survived: d.Survived.trim(),  
        Pclass: +d.Pclass,  
        Sex: d.Sex.trim(),  
        Age: d.Age ? +d.Age : null,
        Fare: d.Fare ? +d.Fare : null
    }));
    console.log("Datos cargados:", data);
    filteredData = [...data];
  });

  $: filteredData = data.filter(d => {
    const matchClass = selectedClass === "All" || d.Pclass.toString() === selectedClass;
    const matchSex = selectedSex === "All" || d.Sex === selectedSex;
    const matchSurvived = selectedSurvived === "All" || d.Survived === selectedSurvived;
    return matchClass && matchSex && matchSurvived;
  });

</script>

<style>
/* Fondo página */
main {
  font-family: 'Segoe UI', sans-serif;
  background: url('/titanic-bg.png') no-repeat center center;
  background-size: cover;
  position: relative;
  padding: 20px;
  min-height: 100vh;
  color: white;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
}

/* Fondo oscuro transparecnte */
main::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.3);
  z-index: -1;
}

/*Titulo*/
h1 {
  text-align: center;
  font-size: 2.5rem;
  color: #FFD700;
  text-shadow: 3px 3px 6px rgba(0, 0, 0, 1);
}

/* COntenerdor de gráficos*/
.charts {
  display: grid;
  grid-template-columns: repeat(2, 1fr); 
  grid-template-rows: repeat(2, 1fr); 
  gap: 15px;
  justify-content: center;
  align-items: center;
  padding: 20px;
  max-width: 1100px;
  margin: 0 auto;
}

/* Caja de cada gráfico */
.chart-container {
  background: rgba(0, 0, 0, 0.5);
  padding: 15px;
  border-radius: 10px;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 400px; 
}

/* Filtros */
.filters {
  display: flex;
  justify-content: center;
  gap: 15px;
  margin-bottom: 15px;
}



</style>

<main>
  <h1>🎛️ Titanic Dashboard</h1>

  <!-- Contenedor de filtros -->
  <div class="filters">
    <Filters bind:selectedClass bind:selectedSex bind:selectedSurvived />
  </div>

  
  {#if filteredData.length > 0}
    <div class="charts">
      <div class="chart-container"><BarChart data={filteredData} /></div>
      <div class="chart-container"><PieChart data={filteredData} /></div>
      <div class="chart-container"><ScatterPlot data={filteredData} /></div>
      <div class="chart-container"><LineChart data={filteredData} /></div>
    </div>
  {:else}
    <p>No hay datos para mostrar</p>
  {/if}
</main>
