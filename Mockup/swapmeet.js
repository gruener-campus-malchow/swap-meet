'use strict';
//alert("hilfe");
document.addEventListener('DOMContentLoaded', function () 

	{ 
    // weiterleitung auf andere Views

    document.getElementById('name').addEventListener('click', test);
}
);
function test()
{

var xhr = new XMLHttpRequest();
xhr.open("POST", "api/item/", true);
xhr.setRequestHeader('Content-Type', 'application/json');
xhr.send(JSON.stringify({
    title: 'testtitel',
    description: 'this is a helpful description'
}));
xhr.onload = function() {
  console.log(this.responseText);
  var data = JSON.parse(this.responseText);
  console.log(data);
  return value;
}
}
