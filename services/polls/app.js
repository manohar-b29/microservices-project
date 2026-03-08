const express = require("express");
const app = express();

app.get("/polls", (req, res) => {
  res.send("polls service is running 🚀");
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(3000, () => {
  console.log("polls service running on port 3000");
});