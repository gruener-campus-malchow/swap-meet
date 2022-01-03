'use strict';
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('name').addEventListener('click', categoryTable);
});

function categoryTable() {
    let xhr = new XMLHttpRequest();
    xhr.open("GET", "/api/category/", true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        title: 'dasdwada',
        description: 'category title'
    }));
    xhr.onload = function() {
        console.log(this);
        var data = JSON.parse(this.responseText);
        console.log(data);

        const elemdiv = document.createElement('div');
        elemdiv.setAttribute('id', 'test42');
        elemdiv.style.cssText = 'margin-left: 250px;';

        const addd = document.querySelector('#test5');
        addd.appendChild(elemdiv);

        var myTable = "<table id='categoryTable' class='w3-table w3-striped w3-bordered'><tr><th class='table-row'> Name </th><th class='table-row'> Anzahl der Inserate </th></tr><tr>";
        var perrow = 1;
        data.forEach((value, i) => {
            myTable += `<td class="w3-hover-blue" id="${value.id}" onClick="Itemlist(this.id)">${value.title}</td>`;
            myTable += `<td class="w3-hover-green" id="${value.id}" onClick="Itemlist(this.id)">${value.id}</td>`;
            var next = i + 1;
            if (next % perrow == 0 && next != data.length) {
                myTable += "</tr><tr>";
            }
        });
        myTable += "</tr></table>";
        document.getElementById("test42").innerHTML = myTable;
    }

};

function Itemlist(clicked_id) {
let xhr = new XMLHttpRequest();
    xhr.open("GET", `/api/category_has_item/category_id:${clicked_id}`, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        title: 'daswadawdasdwa',
        description: 'wdadwadawdasdwadsa title'
    }));
    xhr.onload = function() {
        console.log(this);
        var dataitemid = JSON.parse(this.responseText);
        console.log(dataitemid);

let xhr = new XMLHttpRequest();
    xhr.open("GET", `/api/item/`, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        title: 'daswadawdasdwa',
        description: 'wdadwadawdasdwadsa title'
    }));
    xhr.onload = function() {
        console.log(this);
        var dataitems = JSON.parse(this.responseText);
        console.log(dataitems);

// Array dataitemid mit array dataitems abgleichen und nur Items ausgeben, deren id in dataitemid vorhanden ist. 


        }
    }

};



// model category has items needed for column "Anzahl der Inserate"
// model messages not working(no access to data)
// somehow get id from row that was clicked on for Inserate list
// event load not working, "onload = ..." in Mockup_Kategorien
