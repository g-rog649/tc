from flask import Flask
import sys

app = Flask(__name__)


@app.route("/")
def hello_world():
    return f"<h1>Hello from Flask!</h1>Python version: {sys.version}"
