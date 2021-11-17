from flask import Flask, request, jsonify
import pickle
import numpy as np
import pandas as pd

yieldPredictionModel = pickle.load(open('yieldPredictor_decisionTreeReg.pkl', 'rb'))
cropRecommendationModel = pickle.load(open('cropRecommendor_RandomForest.pkl', 'rb'))

app = Flask(__name__)

@app.route('/')
def home():
    return "Farmezy ML predictions server"

@app.route('/predictYield', methods=['POST'])
def predictYield():
    rainfall_mm = request.form.get('rainfall_mm')
    state_name = request.form.get('State_Name')
    season = request.form.get('Season')
    crop = request.form.get('Crop')

    input_test = {'rainfall_mm': float(rainfall_mm), 'State_Name': state_name, 'Season': season, 'Crop': crop}

    df = pd.read_csv('minMaxRain.csv')
    max_rain = df['max_rain'][0]
    min_rain = df['min_rain'][0]

    test_data = pd.read_csv('testYield.csv')
    test_data['rainfall_mm'].iloc[0] = (input_test['rainfall_mm'] - min_rain) / (max_rain - min_rain)
    test_data['State_' + input_test['State_Name']].iloc[0] = 1
    test_data['Season_' + input_test['Season']].iloc[0] = 1
    test_data['Crop_' + input_test['Crop']].iloc[0] = 1

    input_query = np.array(test_data)
    result = yieldPredictionModel.predict(input_query)[0]

    return jsonify({'tonnes/hectare_yield': str(result)})

@app.route('/predictCrop', methods=['POST'])
def predictCrop():
    n = request.form.get('N')
    p = request.form.get('P')
    k = request.form.get('K')
    temperature = request.form.get('temperature')
    humidity = request.form.get('humidity')
    ph = request.form.get('ph')
    rainfall = request.form.get('rainfall')

    input_query = np.array([[n, p, k, temperature, humidity, ph, rainfall]])
    result = cropRecommendationModel.predict(input_query)[0]

    return jsonify({'Crop': str(result)})

if __name__ == '__main__':
    app.run(debug=True)