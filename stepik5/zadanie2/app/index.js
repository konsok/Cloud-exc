const express = require("express");
const app = express();
const port = process.env.PORT || 8080;

app.get("/", (req, res) => {
  const date = new Date().toISOString().replace(/\..+/, "");
  res.json(date);
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
