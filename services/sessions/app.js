const express = require("express");

const app = express();

app.get("/meetings",(req,res)=>{
 res.json({
   service:"sessions",
   status:"running"
 });
});

app.listen(3000,()=>{
 console.log("Meeting service running");
});
