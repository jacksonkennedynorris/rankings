var tableData = d3.csv('genFile.csv')


tableData.then(function(data){
  useData(data)
},
function(err){
  console.log(err)
});


var useData = function(data){
  width = 500;
  height = 4500;

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
.text(function(d,i){return d.Rank + '. '  + d.Class + 'A ' + d.Name + ' ' + d.Rating + ' ' + d.InState + ' ' + d.Total})
.attr('font-size',20)
.attr('x',20)
.attr('y',function(d,i){return 50 + 20*i})
.attr('fill','black')

var table = svg.append('tableName').selectAll('table')
.data(data)
.enter()
.append('table')

}
