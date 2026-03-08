const express = require("express");
const app = express();

app.get("/aahar", (req, res) => {
  res.send("aahar service is running 🚀");
});

app.listen(3000, () => {
  console.log("aahar service running on port 3000");
});