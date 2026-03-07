const express = require("express");
const axios = require("axios");

const app = express();

app.get("/dashboard", async (req,res)=>{

 const meeting = await axios.get("http://meeting-service:3000/meetings");

 res.json({
   message:"UMS service",
   meeting:meeting.data
 });

});

app.listen(3000,()=>{
 console.log("UMS service running");
});
