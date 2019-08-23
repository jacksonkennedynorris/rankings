var tableData = d3.csv('finalTable.csv')

tableData.then(function(data){
  useData(data)
},
function(err){
  console.log(err)
});


var useData = function(data){
  console.log(data)
  var svg = d3.select('svg')
  .attr('width',200)
  .attr('height',200)

var plot = svg.append('g')
.attr('width',200)
.attr('height',200)

plot.append('text')
.data(data)
.attr('x',20)
.attr('y',20)
.attr('fill','white')
.text(function(data){return data.AverName 
})


}
