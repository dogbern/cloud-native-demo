from flask import Flask, jsonify
from datetime import datetime
app = Flask(__name__)

timestamp = int(datetime.now().timestamp())
msg = {
  'message': 'Automate all the things!',
  'timestamp': timestamp
}

@app.route('/')
def home():
  return '''
  <h1> Demo API to showcase Cloud Native Experience</h1>
  <p>version 1</p>
  '''

@app.route('/api/v1/msg')
def automate_msg():
  return jsonify(msg)

if __name__ == '__main__':
  app.run(host='0.0.0.0')