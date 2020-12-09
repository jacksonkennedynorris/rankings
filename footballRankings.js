var tableData = d3.csv('football/teams_2020.csv')
  tableData.then(function(data){useData(data)},
  function(err){console.log(err)});

var useData = function(data){
    width = 500;
    height = 1000;

    var svg = d3.select('svg')
    .attr('width',width)
    .attr('height',height)

  var myTab = d3.select('table.totalTable')

  var tableNames = ["Ranking","Name","Rating","Wins","Losses","Massey","Colley","Elo"];

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
      return d.name })/*
      if(d.Region == "NaN")
      {
        return d.name + " (N/A)"
      }
      else if (d.name == "Trinity (Louisville)") {
        return "Trinity (" + d.Region + "A)"
      }
      else if (d.name == "Holy Cross (Louisville)"){
        return "Holy Cross - Louisville (" + d.Region + "A)"
      }
      else if (d.name == "Holy Cross (Covington)"){
        return "Holy Cross - Covington (" + d.Region + "A)"
      }
      else {
        return d.Name + " (" + d.Region + "A)"}
      })*/ 
    row.append('td')
    .text(function(d,i){return d.rating})
    row.append('td')
    .text(function(d,i){return d.wins})
    row.append('td')
    .text(function(d,i){return d.losses})
    row.append('td')
    .text(function(d,i){return d.massey})
    row.append('td')
    .text(function(d,i){return d.colley})
    row.append('td')
    .text(function(d,i){return d.elo})
    console.log(data)
}
