const mongoose = require("mongoose");

mongoose
  .connect("mongodb://db:27017/db", {
    authSource: "admin",
    user: "root",
    pass: "pass123",
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
      console.log("Get users");
      res.json({ status: "ok", users });
    })
    .catch((error) => res.status(400).json({ status: "error", error }));
});

app.post("/users", (req, res) => {
  console.log(req.body);
  User.create(req.body)
    .then(() => {
      console.log("Add user");
      res.json({ status: "added" });
    })
    .catch((error) => res.status(400).json({ status: "error", error }));
});

app.put("/users", (req, res) => {
  User.findOneAndUpdate(req.body.user, req.body.update)
    .then(() => {
      console.log("Update user");
      res.json({ status: "updated" });
    })
    .catch((error) => res.status(400).json({ status: "error", error }));
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
