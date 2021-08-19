from flask import Flask, render_template, url_for, request, redirect, json
import os
import json

app = Flask(__name__)

# Create URL routes
@app.route("/")
def home():

    return render_template("home.html")

if __name__ == "__main__":
    # rid (port="5002") within run function
    app.run(debug=True)