from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def home():
    return "Hellp World!"

@app.route('/predictYield', methods=['POST'])
def predictYield():
    

if __name__ == '__main__':
    app.run(debug=True)