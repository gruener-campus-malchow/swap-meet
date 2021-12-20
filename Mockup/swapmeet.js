'use strict';
//alert("hilfe");
document.addEventListener('DOMContentLoaded', function () 

	{ 
    // weiterleitung auf andere Views

    document.getElementById('name').addEventListener('click', test);
    document.getElementById('name').addEventListener('click', testtest);
}
);
function test()
{

let xhr = new XMLHttpRequest();
xhr.open("GET", "/api/item", true);
xhr.setRequestHeader('Content-Type', 'application/json');
xhr.send(JSON.stringify({
    title: 'testtitel',
    description: 'this is a helpful description'
}));
xhr.onload = function() {
  console.log(this);
  let data = JSON.parse(this.responseText);
  console.log(data);
}
};

function testtest()
{
//setup our table array
var tableArr = [
  ["row 1, cell 1", "row 1, cell 2"],
  ["row 2, cell 1", "row 2, cell 2"]
]//create a Table Object
let table = document.createElement('table');//iterate over every array(row) within tableArr
for (let row of tableArr) {//Insert a new row element into the table element
  table.insertRow();//Iterate over every index(cell) in each array(row)
  for (let cell of row) {//While iterating over the index(cell)
//insert a cell into the table element
    let newCell = table.rows[table.rows.length - 1].insertCell();//add text to the created cell element
    newCell.textContent = cell;
  }
}//append the compiled table to the DOM
document.body.appendChild(table);
};
