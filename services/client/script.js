async function loadDashboard(){

 const response = await fetch("http://localhost:3000/dashboard");

 const data = await response.json();

 document.getElementById("output").innerText =
 JSON.stringify(data,null,2);

}
