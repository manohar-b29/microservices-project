const express = require("express");
const app = express();

app.get("/sessions", (req, res) => {
  res.send("sessions service is running 🚀");
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(3000, () => {
  console.log("sessions service running on port 3000");
});