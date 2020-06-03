from flask import Flask, request
app = Flask(__name__, static_url_path='/static')

import joblib

model = joblib.load('trained_models/iris.pkl')

@app.route('/')
def root():
    return app.send_static_file('index.html')

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5000, debug=True)