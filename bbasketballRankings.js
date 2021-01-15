var my_string = "BBasketball/teams_"
var csv_end = ".csv"
var year; 
var myarray = []; 
var button_list = [] 

latest_year = 2020

for (year = latest_year; year>=2000; year--){

  var btn = document.createElement("BUTTON");   // Create a <button> element
  btn.setAttribute("id", "button" + year.toString())
  btn.setAttribute("year", year)
  if (year >= 2000){
    short = (year % 2000).toString()
    if (year < 2010){
      short = "0" + short
    }
  }
  else{
    short = (year%1900).toString()
  }
  btn.innerHTML = year.toString();                   // Insert text
  document.getElementById("button_div").appendChild(btn);               // Append <button> to <body>
  button_list.push(btn)
  var get_promise = d3.csv(my_string + String(year) + csv_end)
  var dict = {
    year : year,
    promise: get_promise
  }
  myarray.push(dict)
}

// Create buttons and once clicked send them to the promise
for (i = 0; i<button_list.length; i++){
    button_list[i].addEventListener ("click", function() {
      for (j = 0; j<myarray.length; j++)
      {
        if (myarray[j].year == this.innerHTML){
          push_to_function(myarray[j],false)
        }
      }
    });
  }
var end = myarray[0]
push_to_function(end,true)

// This function pushes to the use data function 
function push_to_function(year_dict,is_first_year) {
  if (!is_first_year){
      d3.select('h2').remove()
      d3.select('totalTable').remove()
  }
  var promise = year_dict.promise
  var year = year_dict.year
  promise.then(function(data){useData(data,year)})

}


var useData = function(data,year){

    width = 500;
    height = 1000;
    var my_year = document.createElement("h2") 
    var create_table = document.createElement("totalTable")
    if (year >= 2000){
      short = year % 2000
      if (year < 2010){
        short = "0" + short
      }
    }
    else{
      short = year%1900
    }
    my_year.innerHTML = "Year: " + (year-1).toString() + "-" + short;
    document.getElementById("year").appendChild(my_year);
    document.getElementById("tableDiv").appendChild(create_table)

  var myTab = d3.select('totalTable')

  var tableNames = ["Ranking","Name (Class)",/*"Region",*/"Rating",/*"Record"*/"Wins","Losses","Massey","Colley","Elo"];

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
      var suffix = ""
      if (d.region === "1"){suffix = "st"}
      else if (d.region === "2"){suffix = "nd"}
      else if (d.region === "3"){suffix = "rd"}
      else if (d.region === "NaN"){suffix = ""}
      else {suffix = "th"}


      if(d.region == "NaN")
      {
        return d.name + " (N/A)"
      }
      else if (d.name == "Trinity (Louisville)") {
        return "Trinity (" + d.region + suffix + ")"
      }
      else if (d.name == "Holy Cross (Louisville)"){
        return "Holy Cross - Louisville (" + d.region + suffix + ")"
      }
      else if (d.name == "Holy Cross (Covington)"){
        return "Holy Cross - Covington (" + d.region + suffix + ")"
      }
      else {
        return d.name + " (" + d.region + suffix + ")"}
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

}

