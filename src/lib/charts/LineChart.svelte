<script>
  import * as d3 from 'd3';
  export let data = [];

  let svgElem;
  const width = 600, height = 400, margin = { top: 20, right: 30, bottom: 40, left: 50 };
 
  $: if (data.length) {
    const svg = d3.select(svgElem)
      .attr('width', width)
      .attr('height', height);
    svg.selectAll('*').remove();

    // Calcular tasa de supervivencia por clase (1, 2, 3)
    const classes = [1, 2, 3];
    const survivalRates = classes.map(cls => {
      const subset = data.filter(d => +d.Pclass === cls);
      const total = subset.length;
      const survived = subset.filter(d => d.Survived === "1").length;
      const rate = total ? survived / total : 0;
      return { class: cls, rate: rate };  // fracción 0 a 1
    });

    // Escalas para eje X (clases 1-3) y eje Y (tasa 0 a 1)
    const xScale = d3.scaleLinear().domain([1, 3]).range([margin.left, width - margin.right]);
    const yScale = d3.scaleLinear().domain([0, 1]).range([height - margin.bottom, margin.top]);

    // Ejes
    const xAxis = d3.axisBottom(xScale).ticks(3).tickFormat(d => `Clase ${d}`);
    const yAxis = d3.axisLeft(yScale).tickFormat(d => `${d * 100}%`);
    svg.append('g')
      .attr('transform', `translate(0, ${height - margin.bottom})`)
      .call(xAxis);
    svg.append('g')
      .attr('transform', `translate(${margin.left}, 0)`)
      .call(yAxis);

    // Generador de línea
    const line = d3.line()
      .x(d => xScale(d.class))
      .y(d => yScale(d.rate));

    // Dibujar la línea conectando las tasas por clase
    svg.append('path')
      .datum(survivalRates)
      .attr('fill', 'none')
      .attr('stroke', 'steelblue')
      .attr('stroke-width', 2)
      .attr('d', line);

    // Marcar puntos de datos con círculos
    svg.selectAll('circle.datapoint')
      .data(survivalRates)
      .enter()
      .append('circle')
        .attr('class', 'datapoint')
        .attr('cx', d => xScale(d.class))
        .attr('cy', d => yScale(d.rate))
        .attr('r', 4)
        .attr('fill', 'steelblue');

    // Etiquetas de porcentaje junto a cada punto
    svg.selectAll('text.line-label')
      .data(survivalRates)
      .enter()
      .append('text')
        .attr('class', 'line-label')
        .attr('x', d => xScale(d.class))
        .attr('y', d => yScale(d.rate) - 10)
        .attr('text-anchor', 'middle')
        .text(d => `${(d.rate * 100).toFixed(1)}%`);
  }
</script>

<svg bind:this={svgElem}></svg>
