const express = require("express");
const app = express();
const port = 3000;

const messageRoute = require("./routes/Message");
const userRoute = require("./routes/User");

app.use(express.json());
app.use("/messages", messageRoute);
app.use("/users", userRoute);

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
