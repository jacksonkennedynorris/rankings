var link = "football/teams_2020.csv"
var year = link.substring(15,19)

var tableData = d3.csv(link)
  tableData.then(function(data){useData(data,year)},
  function(err){console.log(err)});

var useData = function(data,year){
    width = 500;
    height = 1000;

    /*var svg = d3.select('svg')
    .attr('width',width)
    .attr('height',height)
*/
  var myTab = d3.select('table.totalTable')

  var tableNames = ["Ranking","Name",/*"Region",*/"Rating",/*"Record"*/"Wins","Losses","Massey","Colley","Elo"];

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
    .attr('class', 'ranking')
    row.append('td')
    .text(function(d,i){
      /*return d.name })*/
      if(d.region == "NaN")
      {
        return d.name + " (N/A)"
      }
      else if (d.name == "Trinity (Louisville)") {
        return "Trinity (" + d.region + "A)"
      }
      else if (d.name == "Holy Cross (Louisville)"){
        return "Holy Cross - Louisville (" + d.region + "A)"
      }
      else if (d.name == "Holy Cross (Covington)"){
        return "Holy Cross - Covington (" + d.region + "A)"
      }
      else {
        return d.name + " (" + d.region + "A)"}
      })
    .attr('class','name')
    /*row.append('td')
    .text(function(d,i){return d.region})*/
    row.append('td')
    .text(function(d,i){return d.rating})
    .attr('class','rating')
    /*
    row.append('td')
    .text(function(d,i){return d.wins + " - " + d.losses})*/
    row.append('td')
    .text(function(d,i){return d.wins})
    .attr('class','wins')
    row.append('td')
    .text(function(d,i){return d.losses})
    .attr('class','losses')
    row.append('td')
    .text(function(d,i){return d.massey})
    .attr('class','massey')
    row.append('td')
    .text(function(d,i){return d.colley})
    .attr('class','colley')
    row.append('td')
    .text(function(d,i){return d.elo})
    .attr('class','elo')
    console.log(data)
}
