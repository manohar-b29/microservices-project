const express = require("express");
const path = require("path");

const app = express();
const PORT = 3000;

/* Health endpoint for ALB */
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

/* Serve static files */
app.use(express.static(__dirname));

/* Root route */
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

app.listen(PORT, () => {
  console.log(`Client running on port ${PORT}`);
});