from flask import Flask, render_template
from flask_cors import CORS
import os
import random

app = Flask(__name__)
CORS(app, origins=["http://localhost:5000", "https://zettademo1.azurewebsites.net"])

@app.route("/")
def home():
    image_files = [f for f in os.listdir("static") if f.lower().endswith((".png", ".jpg", ".jpeg", ".gif"))]
    chosen_image = random.choice(image_files) if image_files else None
    return render_template("index.html", image_file=chosen_image)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
