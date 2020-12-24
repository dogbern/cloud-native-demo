from flask import Flask, jsonify
import time
app = Flask(__name__)

msg = {
  'message': 'Automate all the things!',
  'timestamp': int(time.time())
}

@app.route('/')
def home():
  return '''
  <h1> Demo API to showcase Cloud Native Experience</h1>
  '''

@app.route('/api/v1/msg')
def automate_msg():
  return jsonify(msg)

if __name__ == '__main__':
  app.run(host='0.0.0.0')