const express = require("express");
const app = express();

app.get("/meeting", (req, res) => {
  res.send("Meeting service is running 🚀");
});

app.listen(3000, () => {
  console.log("Meeting service running on port 3000");
});