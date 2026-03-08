const express = require("express");
const app = express();

app.get("/aahar", (req, res) => {
  res.send("aahar service is running 🚀");
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(3000, () => {
  console.log("aahar service running on port 3000");
});