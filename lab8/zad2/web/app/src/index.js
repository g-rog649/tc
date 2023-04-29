const { createClient } = require("redis");
const express = require("express");
const app = express();
const port = 3000;

const redisClient = createClient({
  url: "redis://redis_user:pass123@redis:6379",
});

redisClient.on("error", (error) =>
  console.error("Redis client error:\n", error)
);

redisClient.connect().then(() => console.log("Connected to Redis client"));

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.post("/messages/add", (req, res) => {
  const { title, message } = req.body;
  let error = {};

  if (!title) {
    error["title"] = "not provided";
  }

  if (!message) {
    error["message"] = "not provided";
  }

  for (const _ in error) {
    res.json({ status: "error", error }).status(400);
    return;
  }

  redisClient
    .hSet("messages", title, message)
    .then(() => {
      console.log(`Added message ${title}: "${message}"`);
      res.json({ status: "added" });
    })
    .catch((error) => {
      console.error("Redis error:\n", error);
      res.status(500).json({ status: "error" });
    });
});

app.get("/messages/get", (req, res) => {
  redisClient
    .hGetAll("messages")
    .then((messages) => {
      console.log("Get all messages");
      res.json({ status: "ok", messages });
    })
    .catch((error) => {
      console.error("Redis error:\n", error);
      res.status(500).json({ status: "error" });
    });
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
