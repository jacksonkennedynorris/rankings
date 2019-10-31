var tableData = d3.csv('genFile.csv')

tableData.then(function(data){
  useData(data)
},
function(err){
  console.log(err)
});

var useData = function(data){
  width = 500;
  height = 300;

  var svg = d3.select('svg')
  .attr('width',width)
  .attr('height',height)

var myTab = d3.select('table.totalTable')

var tableNames = ["Ranking","Class","School","Rating","In-State Record","Out-of-State Record"];

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
.text(function(d,i){return d.Rank})
row.append('td')
.text(function(d,i){return d.Class})
row.append('td')
.text(function(d,i){return d.Name})
row.append('td')
.text(function(d,i){return d.Rating})
row.append('td')
.text(function(d,i){return d.InState})
row.append('td')
.text(function(d,i){return d.Total})

/*
var plot = svg.append('g')
.attr('width',width)
.attr('height',height)

plot.selectAll('text')
.data(data)
.enter()
.append('text')
.text(function(d,i){return d.Rank + '. '  + d.Class + 'A ' + d.Name + ' ' + d.Rating + ' ' + d.InState + ' ' + d.Total})
.attr('font-size',20)
.attr('x',20)
.attr('y',function(d,i){return 50 + 20*i})
.attr('fill','black')
*/
}
