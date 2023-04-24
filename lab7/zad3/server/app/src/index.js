require("dotenv").config();

const mongoose = require("mongoose");

mongoose
  .connect(`mongodb://db:${process.env.MONGO_PORT}/db`, {
    authSource: "admin",
    user: process.env.MONGO_INITDB_ROOT_USERNAME,
    pass: process.env.MONGO_INITDB_ROOT_PASSWORD,
  })
  .then(
    () => console.log("Connected to the database"),
    (error) => console.log(error)
  );

const userSchema = new mongoose.Schema({
  firstName: { type: String },
  lastName: { type: String },
  yearOfBirth: { type: Number },
});

const User = mongoose.model("User", userSchema);

const express = require("express");
const app = express();
const port = 8080;

app.use(express.json());

app.get("/users", (req, res) => {
  User.find({})
    .exec()
    .then((users) => {
      console.log("Getting user data");
      res.json({ status: "ok", users });
    })
    .catch((error) => res.status(400).json({ status: "error", error }));
});

app.post("/users", (req, res) => {
  console.log(req.body);
  User.create(req.body)
    .then(() => res.json({ status: "added" }))
    .catch((error) => res.status(400).json({ status: "error", error }));
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
