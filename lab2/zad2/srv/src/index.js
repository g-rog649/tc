const http = require("http");

http
  .createServer((req, res) => {
    const dateTime = new Date();
    const date = dateTime.toLocaleDateString();
    const time = dateTime.toLocaleTimeString();

    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(JSON.stringify({ date, time }));
    res.end();
  })
  .listen(8080);
