var link = "football/teams_2020.csv"

var my_string = "football/teams_"
var csv_end = ".csv"
var year; 
var myarray = []; 


var button_list = [] 
for (year = 2005; year<=2020; year++){

  var btn = document.createElement("BUTTON");   // Create a <button> element
  btn.setAttribute("id", "button" + year.toString())
  btn.innerHTML = year.toString();                   // Insert text
  document.getElementById("button_div").appendChild(btn);               // Append <button> to <body>
  button_list.push(btn)
  var letstry = d3.csv(my_string + String(year) + csv_end)
  var dict = {
    year : year,
    promise: letstry
  }
  myarray.push(dict)
}
console.log(button_list)
for (i = 0; i<button_list.length; i++){
  button_list[i].onclick = function(){
    console.log(button_list[i])
  }
}
push_latest(myarray)
function push_latest(myarray) {
  var latest_promise = myarray[myarray.length-1].promise
  var latest_year = myarray[myarray.length-1].year
  latest_promise.then(function(data){useData(data,latest_year,myarray)})
}
push_button(myarray,2010)

function push_button(myarray,year) {
  var i; 
  for (i = 0; i<myarray.length; i++){

    if (year == myarray[i].year){
      console.log(year)
    }
  }
}

var year = link.substring(15,19)

var useData = function(data,year,myarray){
    var my_buttons = d3.selectAll('button')
    console.log(my_buttons)
    width = 500;
    height = 1000;
    var my_year = document.createElement("h2") 
    my_year.innerHTML = "Year: " + year.toString();
    document.getElementById("year").appendChild(my_year);

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
