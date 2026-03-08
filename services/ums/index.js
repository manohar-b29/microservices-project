const express = require("express");
const app = express();

app.use(express.json());

// root
app.get("/", (req, res) => {
  res.send("UMS Service Running 🚀");
});

// ingress route
app.get("/ums", (req, res) => {
  res.json({
    service: "UMS",
    message: "User Management Service working",
  });
});

// example API
app.get("/ums/users", (req, res) => {
  const users = [
    { id: 1, name: "Manohar", role: "Admin" },
    { id: 2, name: "DevOpsUser", role: "Developer" }
  ];

  res.json(users);
});

// health check
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`UMS service running on port ${PORT}`);
});