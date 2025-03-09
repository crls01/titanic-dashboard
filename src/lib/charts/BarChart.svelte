<script>
  export let data = [];
  console.log("Datos recibidos en este gráfico (BarChart):", data);

  import * as d3 from 'd3';

  let svgElem;
  const width = 600, height = 350, margin = { top: 20, right: 30, bottom: 40, left: 50 };

  $: if (data.length > 0) {
    const svg = d3.select(svgElem)
      .attr('width', width)
      .attr('height', height);
    svg.selectAll('*').remove();

    const survivedCount = data.filter(d => d.Survived === "1").length;
    const notSurvivedCount = data.filter(d => d.Survived === "0").length;
    const counts = [notSurvivedCount, survivedCount];
    const categories = ["No sobrevivió", "Sobrevivió"];

    const maxCount = d3.max(counts);
    const yScale = d3.scaleLinear().domain([0, maxCount]).range([height - margin.bottom, margin.top]);
    const xScale = d3.scaleBand().domain(categories).range([margin.left, width - margin.right]).padding(0.4);

    const xAxis = d3.axisBottom(xScale);
    svg.append('g')
      .attr('transform', `translate(0, ${height - margin.bottom})`)
      .call(xAxis);

    const yAxis = d3.axisLeft(yScale).ticks(5);
    svg.append('g')
      .attr('transform', `translate(${margin.left}, 0)`)
      .call(yAxis);

    svg.selectAll('rect.bar')
      .data(counts)
      .enter()
      .append('rect')
        .attr('class', 'bar')
        .attr('x', (d, i) => xScale(categories[i]))
        .attr('y', d => yScale(d))
        .attr('width', xScale.bandwidth())
        .attr('height', d => (height - margin.bottom) - yScale(d))
        .attr('fill', (d, i) => i === 1 ? 'steelblue' : 'orange');

    svg.selectAll('text.bar-label')
      .data(counts)
      .enter()
      .append('text')
        .attr('class', 'bar-label')
        .attr('x', (d, i) => xScale(categories[i]) + xScale.bandwidth() / 2)
        .attr('y', d => yScale(d) - 5)
        .attr('text-anchor', 'middle')
        .text(d => d);
  }
</script>

<svg bind:this={svgElem} width="100%" height="100%"></svg>
