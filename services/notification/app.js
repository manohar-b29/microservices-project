const express = require("express");
const app = express();

app.get("/notification", (req, res) => {
  res.send("notification service is running 🚀");
});

app.listen(3000, () => {
  console.log("notification service running on port 3000");
});