from flask import Flask, jsonify
import time
app = Flask(__name__)

@app.route('/')
def home():
  return '''
  <h1>Demo API to showcase Cloud Native Experience - v3</h1>
  '''

@app.route('/msg')
def automate_msg():
  timestamp = int(time.time())
  msg = {
    'message': 'Automate all the things!',
    'timestamp': timestamp
  }
  return jsonify(msg)

if __name__ == '__main__':
  app.run(host='0.0.0.0')