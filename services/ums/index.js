const express = require("express");
const app = express();

const PORT = 3000;

app.use(express.json());

/* Root endpoint */
app.get("/ums", (req, res) => {
  res.json({
    service: "UMS",
    message: "User Management Service working"
  });
});

/* Health check for ALB */
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(PORT, () => {
  console.log(`UMS service running on port ${PORT}`);
});