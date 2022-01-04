'use strict';
document.addEventListener('DOMContentLoaded', function() {
    //document.getElementById('name').addEventListener('click', categoryTable);
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
        //console.log(this);
        var data = JSON.parse(this.responseText);
        //console.log(data[]);

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
    xhr.open("GET", `/api/category_has_item/`, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        title: 'daswadawdasdwa',
        description: 'wdadwadawdasdwadsa title'
    }));
    xhr.onload = function() {
        //console.log(this);

        var dataitemid = JSON.parse(this.responseText);
        //console.log(dataitemid);
        var items = [];
        for (const elem of dataitemid) {
            if (elem.category_id == clicked_id) items.push(elem.item_id);
        };
        console.log(items);
        let xhr = new XMLHttpRequest();
        xhr.open("GET", `/api/item/`, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(JSON.stringify({
            title: 'daswadawdasdwa',
            description: 'wdadwadawdasdwadsa title'
        }));
        xhr.onload = function() {
            //console.log(this);
            var dataitems = JSON.parse(this.responseText);
            let items1 = [];
            console.log(dataitems);
            for (const elem1 of dataitems) {
                if (items.includes(elem1.id)) {
                    items1.push(elem1);
                }
            };
            console.log(items1);
            let xhr = new XMLHttpRequest();
            xhr.open("GET", `/api/item_has_pictures/`, true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.send(JSON.stringify({
                title: 'daswadawdasdwa',
                description: 'wdadwadawdasdwadsa title'
            }));
            xhr.onload = function() {
                //console.log(this);

                var datapicture = JSON.parse(this.responseText);
                console.log(datapicture);
                var pictures = [];
                for (const elem2 of datapicture) {
                    if (items.includes(elem2.item_id)) {
                        pictures.push(elem2.pictures_id);
                    }
                };
                console.log(pictures);
                let xhr = new XMLHttpRequest();
                xhr.open("GET", `/api/pictures/`, true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.send(JSON.stringify({
                    title: 'daswadawdasdwa',
                    description: 'wdadwadawdasdwadsa title'
                }));
                xhr.onload = function() {
                    //console.log(this);

                    var datapicture1 = JSON.parse(this.responseText);
                	for (const elem3 of datapicture1) {
                    if (pictures.includes(elem3.id)) {
                        items1.push(elem3.url);
                    }
                };
                console.log(items1);
					
                    var myTable = "<table id='categoryTable' class='w3-table w3-striped w3-bordered'><tr><th class='table-row'> Titel </th><th class='table-row'> Beschreibung </th><th class='table-row'>Bild</th></tr><tr>";
                    var perrow = 1;
                    items1.forEach((value1, i) => {
                        myTable += `<td class="w3-hover-blue" id="${value1.id}" >${value1.title}</td>`;
                        myTable += `<td class="w3-hover-green" id="${value1.id}">${value1.description}</td>`;
                        var next = i + 1;
                        if (next % perrow == 0 && next != items1.length) {
                            myTable += "</tr><tr>";
                        }
                    });
					
                    myTable += "</tr></table>";
                    document.getElementById("test42").innerHTML = myTable;
                }
            }
        }
    }
};
// model category has items needed for column "Anzahl der Inserate"
// model messages not working(no access to data)
// event load not working, "onload = ..." in Mockup_Kategorien