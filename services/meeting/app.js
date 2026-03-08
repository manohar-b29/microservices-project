const express = require("express");
const app = express();

app.get("/meeting", (req, res) => {
  res.send("Meeting service is running 🚀");
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(3000, () => {
  console.log("Meeting service running on port 3000");
});