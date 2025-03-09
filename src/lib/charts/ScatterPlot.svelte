<script>
  import * as d3 from 'd3';
  export let data = [];

  let svgElem;
  const width = 550, height = 400, margin = { top: 20, right: 30, bottom: 40, left: 50 };

$: if (data.length) {
    const svg = d3.select(svgElem)
      .attr('width', width)
      .attr('height', height);
    svg.selectAll('*').remove();

    // Filtrar datos válidos (edad y tarifa no vacíos) y convertir a números
    const points = data
  .filter(d => d.Age !== "" && d.Fare !== "" && !isNaN(d.Age) && !isNaN(d.Fare))
  .map(d => ({
    age: +d.Age,
    fare: +d.Fare,
    survived: d.Survived
  }));


    if (points.length > 0) {
      // Definir escalas para ejes
      const xExtent = d3.extent(points, d => d.age);
      const yExtent = d3.extent(points, d => d.fare);
      const xScale = d3.scaleLinear().domain(xExtent).nice().range([margin.left, width - margin.right]);
      const yScale = d3.scaleLinear().domain(yExtent).nice().range([height - margin.bottom, margin.top]);

      // Ejes
      const xAxis = d3.axisBottom(xScale).ticks(5).tickFormat(d => d);
      const yAxis = d3.axisLeft(yScale).ticks(5);
      svg.append('g')
        .attr('transform', `translate(0, ${height - margin.bottom})`)
        .call(xAxis);
      svg.append('g')
        .attr('transform', `translate(${margin.left}, 0)`)
        .call(yAxis);

      // Dibujar puntos
      svg.selectAll('circle.point')
        .data(points)
        .enter()
        .append('circle')
          .attr('class', 'point')
          .attr('cx', d => xScale(d.age))
          .attr('cy', d => yScale(d.fare))
          .attr('r', 3.5)
          .attr('fill', d => d.survived === "1" ? 'steelblue' : 'orange')
          .attr('opacity', 0.7);
    }
}

</script>

<svg bind:this={svgElem}></svg>
