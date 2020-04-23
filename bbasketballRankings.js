var tableData = d3.csv("BBasketball/2020table.csv")
  tableData.then(function(data){useData(data)},
  function(err){console.log(err)});

var useData = function(data){
    width = 500;
    height = 700;

  var myTab = d3.select('table.totalTable')

  var tableNames = ["Ranking","School","Region","District","Record","Rating"];

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
      return d.Name})
    row.append('td')
    .text(function(d,i){
      if (d.Region == 1)
      {
        return d.Region + "st"
      }
      else if (d.Region == 2)
      {
        return d.Region + "nd"
      }
      else if (d.Region == 3)
      {
        return d.Region + "rd"
      }
      else
      {
        return d.Region + "th"
      }
    })
    row.append('td')
    .text(function(d,i){
      if (d.District == 1)
      {
        return d.District + "st"
      }
      else if (d.District == 2)
      {
        return d.District + "nd"
      }
      else if (d.District == 3)
      {
        return d.District + "rd"
      }
      else
      {
        return d.District + "th"
      }
    })
    row.append('td')
    .text(function(d,i){return d.Record})
    row.append('td')
    .text(function(d,i){return d.Rating})

    console.log(data)

    var firstRegion = d3.select("firstRButt")

}