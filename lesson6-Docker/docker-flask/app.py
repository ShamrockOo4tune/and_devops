import os
from flask import Flask
from socket import gethostname


app = Flask(__name__)

@app.route('/')
def index():
    hostname = gethostname()
    return f'This is the simple flask application identifying the hostname={hostname} of the node on which it is running'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)

