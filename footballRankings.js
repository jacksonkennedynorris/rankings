var tableData = d3.csv('football/2019table.csv')
  tableData.then(function(data){useData(data)},
  function(err){console.log(err)});

var useData = function(data){
    width = 500;
    height = 1000;

    var svg = d3.select('svg')
    .attr('width',width)
    .attr('height',height)

  var myTab = d3.select('table.totalTable')

  var tableNames = ["Ranking","School","Rating","In-State Record","Total Record"];

  var header = myTab.append('thead')
    .selectAll('th')
    .data(tableNames)
    .enter()
    .append('th')
    .text(function(d){return d;})



  var tableBody = myTab.append('tbody')
  var row = tableBody.selectAll('tr')
    .data(data)
    .enter()
    .append('tr')
    row.append('td')
    .text(function(d,i){return i+1})
    row.append('td')
    .text(function(d,i){
      if(d.Region == "NaN")
      {
        return d.Name + " (N/A)"
      }
      else if (d.Name == "Trinity (Louisville)") {
        return "Trinity (" + d.Region + "A)"
      }
      else if (d.Name == "Holy Cross (Louisville)"){
        return "Holy Cross - Louisville (" + d.Region + "A)"
      }
      else if (d.Name == "Holy Cross (Covington)"){
        return "Holy Cross - Covington (" + d.Region + "A)"
      }
      else {
        return d.Name + " (" + d.Region + "A)"}
      })
    row.append('td')
    .text(function(d,i){return d.Rating})
    row.append('td')
    .text(function(d,i){return d.In_State_Record})
    row.append('td')
    .text(function(d,i){return d.Record})
    console.log(data)
}
