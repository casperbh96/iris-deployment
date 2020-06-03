from flask import Flask, request
import pandas as pd
import joblib

app = Flask(__name__, static_url_path='/static')
model = joblib.load('trained_models/iris.pkl')

@app.route('/')
def root():
    return app.send_static_file('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    df = pd.DataFrame(data, index=[0])
    prediction = model.predict(df)
    return str(prediction[0])

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5000, debug=True)