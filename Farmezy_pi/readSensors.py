import sys                      # Import sys module
from time import sleep          # Import sleep from time
import busio
import digitalio
import board
import adafruit_mcp3xxx.mcp3008 as MCP
from adafruit_mcp3xxx.analog_in import AnalogIn
import RPi.GPIO as GPIO    # Import Raspberry Pi GPIO library
import Adafruit_DHT
import time
import requests
import json
import atexit

DHT_SENSOR = Adafruit_DHT.DHT11
DHT_PIN = 4

# create the spi bus
spi = busio.SPI(clock=board.SCK, MISO=board.MISO, MOSI=board.MOSI)

# create the cs (chip select)
cs = digitalio.DigitalInOut(board.D5)

# create the mcp object
mcp = MCP.MCP3008(spi, cs)

# create an analog input channel on pin 0
soil_moisture = AnalogIn(mcp, MCP.P0)
dust = AnalogIn(mcp, MCP.P1)
ph = AnalogIn(mcp, MCP.P2)

GPIO.setwarnings(False)    # Ignore warning for now
GPIO.setmode(GPIO.BCM)   # Use physical pin numbering
GPIO.setup(5, GPIO.OUT, initial=GPIO.LOW)
GPIO.setup(6, GPIO.OUT, initial=GPIO.HIGH)

def exit_handler():
    GPIO.output(6, GPIO.HIGH)

atexit.register(exit_handler)

samplingTime = 280/1000000
deltaTime = 40/1000000
sleepTime = 9680/1000000

try:    
    while True:
        print("\n")
        
        humidity, temperature = Adafruit_DHT.read(DHT_SENSOR, DHT_PIN)
        if humidity is not None and temperature is not None:
            print("Temp={0:0.1f}C Humidity={1:0.1f}%".format(temperature, humidity))
            #print("Raw soil moisture Value: ", soil_moisture.value)
            soil_moisture_voltage_temp = (-1.0 * 0.1923)*(soil_moisture.voltage/3.3)*1024 + 173.07
            soil_moisture_voltage = str(soil_moisture_voltage_temp )
            if soil_moisture_voltage_temp < 40:
                GPIO.output(6, GPIO.LOW)
            if soil_moisture_voltage_temp > 80:
                GPIO.output(6, GPIO.HIGH)
            print("soil moisture: " + soil_moisture_voltage + "%")
            #GPIO.output(5, GPIO.LOW) # Turn on
            sleep(samplingTime)
            dust_voltage = str((dust.voltage/3.3)*1024*1.8)
            print("PM2.5: " + dust_voltage + "ppm")
            sleep(deltaTime)
            ph_voltage = str((ph.voltage/3.3)*1024*0.00877 + 3.5)
            print("pH: " + ph_voltage)
            #GPIO.output(5, GPIO.HIGH)  # Turn off
            sleep(sleepTime)
            
            response = requests.patch('https://farmezy-7164e-default-rtdb.firebaseio.com/sensorReadings/-MqzDW4ILAo0OvR7KeRA.json', json={'temp': str(temperature), 'humidity': str(humidity), 'soilMoisture': soil_moisture_voltage, 'pm25': dust_voltage, 'ph': ph_voltage})
            #print(response.content)
            sleep(5)
        else:
            print("Sensor failure. Check wiring.")
            

except KeyboardInterrupt:
    GPIO.output(6, GPIO.HIGH)
    sys.exit()
finally:
    GPIO.output(6, GPIO.HIGH)