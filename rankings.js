var tableData = d3.csv('finalTable.csv')

tableData.then(function(data){
  useData(data)
},
function(err){
  console.log(err)
});


var useData = function(data){
  width = 400;
  height = 3000;

console.log(data)
  var svg = d3.select('svg')
  .attr('width',width)
  .attr('height',height)

var plot = svg.append('g')
.attr('width',width)
.attr('height',height)

plot.selectAll('text')
.data(data)
.enter()
.append('text')
.text(function(d,i){return d.rank + '. ' + d.AverName + ' ' + d.Aver})
.attr('font-size',12)
.attr('x',20)
.attr('y',function(d,i){return 20 + 13*i})
.attr('fill','black')

var table = svg.append('tableName').selectAll('table')
.data(data)
.enter()
.append('table')

}
