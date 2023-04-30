const express = require("express");
const router = express.Router();
const { redisClient, redisError } = require("../db");
const { checkFields } = require("../errorHandling");

router.post("/add", (req, res) => {
  const [anyErrors, error] = checkFields(req.body, ["title", "message"]);
  if (anyErrors) {
    res.status(400).json({ status: "error", error });
    return;
  }

  const { title, message } = req.body;

  redisClient
    .hSet("messages", title, message)
    .then(() => {
      console.log(`Added message ${title}: "${message}"`);
      res.json({ status: "added" });
    })
    .catch((error) => {
      redisError(error);
      res.status(500).json({ status: "error" });
    });
});

router.get("/get", (req, res) => {
  redisClient
    .hGetAll("messages")
    .then((messages) => {
      console.log("Get all messages");
      res.json({ status: "ok", messages });
    })
    .catch((error) => {
      redisError(error);
      res.status(500).json({ status: "error" });
    });
});

module.exports = router;
