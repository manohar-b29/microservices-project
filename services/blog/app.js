const express = require("express");
const app = express();

app.get("/blog", (req, res) => {
  res.send("blog service is running 🚀");
});

app.listen(3000, () => {
  console.log("blog service running on port 3000");
});