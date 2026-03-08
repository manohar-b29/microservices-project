const express = require("express");
const app = express();

app.get("/analytics", (req, res) => {
  res.send("analytics service is running 🚀");
});

app.listen(3000, () => {
  console.log("analytics service running on port 3000");
});