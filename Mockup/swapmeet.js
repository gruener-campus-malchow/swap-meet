'use strict';
//alert("hilfe");
document.addEventListener('DOMContentLoaded', function() {
    // weiterleitung auf andere Views
    document.getElementById('name').addEventListener('click', test);
    //document.getElementById('name').addEventListener('click', testtest);
});

function test() {
    let xhr = new XMLHttpRequest();
    xhr.open("GET", "/api/category", true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        title: 'testtitel',
        description: 'this is a helpful description'
    }));
    xhr.onload = function() {
        console.log(this);
        var data = JSON.parse(this.responseText);
        console.log(data);
		
	const elemdiv = document.createElement('div');
    elemdiv.setAttribute('id', 'test42');
    elemdiv.style.cssText = 'margin-left: 250px;';

    const body = document.querySelector('body');
    body.appendChild(elemdiv);

    //var data = ["doge", "cate", "birb", "doggo", "moon moon", "awkward seal"];

    var myTable = "<table class='table'><tr><th class='table-row'> Name </th><th class='table-row'> Anzahl der Inserate </th></tr><tr>";
    var perrow = 1; // x CELLS per Row
    data.forEach((value, i) => {
        myTable += `<td class="table-row-left">${value.title}</td>`;
		myTable += `<td class="table-row-right">${value.id}</td>`;
        var next = i + 1;
        if (next % perrow == 0 && next != data.length) {
            myTable += "</tr><tr>";
        }
    });
    myTable += "</tr></table>";
    document.getElementById("test42").innerHTML = myTable;
    }

};
