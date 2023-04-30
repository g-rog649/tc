const express = require("express");
const router = express.Router();
const { postgresClient, postgresError } = require("../db");
const { checkFields } = require("../errorHandling");

router.post("/add", (req, res) => {
  const [anyErrors, error] = checkFields(req.body, [
    "firstName",
    "lastName",
    "yearOfBirth",
  ]);

  if (anyErrors) {
    res.status(400).json({ status: "error", error, body: req.body });
    return;
  }

  const { firstName, lastName, yearOfBirth } = req.body;

  postgresClient
    .query(
      "INSERT INTO Users (firstName, lastName, yearOfBirth) VALUES ($1, $2, $3);",
      [firstName, lastName, yearOfBirth]
    )
    .then(() => {
      console.log(`Added user ${firstName} ${lastName}`);
      res.json({ status: "added" });
    })
    .catch((error) => {
      postgresError(error);
      res.status(500).json({ status: "error" });
    });
});

router.get("/get", (req, res) => {
  postgresClient
    .query("SELECT * FROM users;")
    .then((result) => res.json({ status: "ok", users: result.rows }))
    .catch((error) => {
      postgresError(error);
      res.status(500).json({ status: "error" });
    });
});

module.exports = router;
