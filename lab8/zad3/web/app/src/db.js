const { createClient } = require("redis");
const { Client: PostgresClient } = require("pg");
const { errorHandler } = require("./errorHandling");

const redisClient = createClient({
  url: "redis://redis_user:pass123@redis:6379",
});

redisClient.on("error", (error) =>
  console.error("Redis client error:\n", error)
);

redisClient.connect().then(() => console.log("Connected to Redis client"));

const redisError = errorHandler("Redis error");

const postgresClient = new PostgresClient({
  user: "docker",
  password: "pass456",
  host: "postgres",
  database: "docker",
});

postgresClient
  .connect()
  .then(() => console.log("Connected to Postgres client"))
  .catch((error) => console.error("Postgres client error:\n", error));

const postgresError = errorHandler("Postgres error");

module.exports = { redisClient, redisError, postgresClient, postgresError };
