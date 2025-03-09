<script>
  import * as d3 from 'd3';
  export let data = [];

  let svgElem;
  const width = 450, height = 350, margin = { top: 20, right: 30, bottom: 40, left: 50 };

  const radius = Math.min(width, height) / 2;

  $: if (data.length) {
    const svg = d3.select(svgElem)
      .attr('width', width)
      .attr('height', height);
    svg.selectAll('*').remove();

    // Calcular sobrevivió/no sobrevivió
    const survivedCount = data.filter(d => d.Survived === "1").length;
    const notSurvivedCount = data.filter(d => d.Survived === "0").length;
    const dataset = [ { label: "No", value: notSurvivedCount }, { label: "Yes", value: survivedCount } ];

    // Generador de pie y de arcos
    const pie = d3.pie().value(d => d.value);
    const arcs = pie(dataset);
    const arcGenerator = d3.arc().innerRadius(0).outerRadius(radius);

    // Central la PIechart
    const g = svg.append('g')
      .attr('transform', `translate(${width/2}, ${height/2})`);

    // Segmentos del pastel
    g.selectAll('path.slice')
      .data(arcs)
      .enter()
      .append('path')
        .attr('class', 'slice')
        .attr('d', arcGenerator)
        .attr('fill', (d, i) => i === 1 ? 'steelblue' : 'orange');

    // Etiquetas de porcentaje
    g.selectAll('text.pie-label')
      .data(arcs)
      .enter()
      .append('text')
        .attr('class', 'pie-label')
        .attr('transform', d => `translate(${arcGenerator.centroid(d)})`)
        .attr('text-anchor', 'middle')
        .attr('dy', '0.35em')
        .text(d => {
          const percent = d.data.value / data.length * 100;
          return `${percent.toFixed(1)}%`;
        });
  }
</script>

<svg bind:this={svgElem}></svg>
