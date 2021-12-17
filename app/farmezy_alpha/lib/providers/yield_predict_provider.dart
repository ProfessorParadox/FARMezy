import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';




class YieldData with ChangeNotifier {
  String _stateName;
  String _seasonPlanted;
  String _cropPlanted;
  double _rainFall;
  String _expectedYield;
  String _n;
  String _p;
  String _k;

  String _temp='';
  String _humidity='';
  String _ph='';
  String _pm25='';
  String _soilMoisture='';

  String _recommendedCrop;
  String _cropImageUrl;
  String _animalDetected='No animal detected';
  String _timeStamp='';
  String _imageURL='';

  void cropRecommend(String nval, String pval, String kval, String tempval,
      String humidityval, String phval, double rfall) {
    _n = nval;
    _p = pval;
    _k = kval;
    _temp = tempval;
    _humidity = humidityval;
    _ph = phval;
    _rainFall = rfall;
  }

  String get crop {
    return _recommendedCrop;
  }


  String get animalImage{
    return _imageURL;
  }

  String get animal{
    return _animalDetected;
  }

  String get timeStamp{
    return _timeStamp;
  }
  Future<void> getImageData() async{

    final url='https://farmezy-7164e-default-rtdb.firebaseio.com/image-detection/-Mqpj4y7qlRRegL2H79X.json';

    try{
      final response= await http.get(url);
      print(json.decode(response.body));
      _animalDetected=json.decode(response.body)['label'];
      _timeStamp=json.decode(response.body)['time-stamp'];
     // _imageURL='https://firebasestorage.googleapis.com/v0/b/farmezy-7164e.appspot.com/o/output.jpg?alt=media&token=85ea84a2-52c7-4aab-b9cc-db5d3ea6c76a';
      final temp= await http.get('https://firebasestorage.googleapis.com/v0/b/farmezy-7164e.appspot.com/o/output.jpg');
      String token=json.decode(temp.body)['downloadTokens'];
      _imageURL='https://firebasestorage.googleapis.com/v0/b/farmezy-7164e.appspot.com/o/output.jpg?alt=media&token=${token}';
      notifyListeners();
    }
    catch(error){
      print(error);
    }
  }

   Future<void> getSensorData() async {

    final url= 'https://farmezy-7164e-default-rtdb.firebaseio.com/sensorReadings/-MqzDW4ILAo0OvR7KeRA.json';

   try{
     final response= await http.get(url);
     print(json.decode(response.body));
     _temp=json.decode(response.body)['temp'];
     _humidity=json.decode(response.body)['humidity'];
     _soilMoisture=json.decode(response.body)['soilMoisture'];
     _pm25=json.decode(response.body)['pm25'];
     _ph=json.decode(response.body)['ph'];

     notifyListeners();
   }
   catch(error){
     print(error);

   } 
  }

  String get tempData{
    return _temp;
  }

  String get humidityData{
    return _humidity;
  }

  String get pm25Data{
    return _pm25;
  }

  String get phData{
    return _ph;
  }

  String get soilMoistureData{
    return _soilMoisture;
  }





  Future<void> fetchCrop() async {
    final url = 'https://farmezy-ml-predictions.herokuapp.com/predictCrop';

    try {
      final response = await http.post(
        url,
        //headers: {'Content-Type': 'application/json', 'Charset': 'utf-8',"Accept":"application/json"},
        body: {
          'N': _n,
          'P': _p,
          'K': _k,
          'temperature': _temp,
          'humidity': _humidity,
          'ph': _ph,
          'rainfall': _rainFall.toString(),
        },
      );
      print("expected result: ");
      // print(json.decode(response.body));
      _recommendedCrop = json.decode(response.body)['Crop'];
      print(_recommendedCrop);
    } catch (error) {
      print("error encountered");
      print(error);
    }

    
     final imageUrl =
        'https://www.googleapis.com/customsearch/v1?key=AIzaSyAFXPvYwRKXMeF0JST4mrdk3npnKD3sjew&cx=313899fc2a4c06589&q=${_recommendedCrop}&searchType=image&num=1';

    try {
      final imageResponse = await http.get(
        imageUrl,
      );
     // print(imageResponse.body);
     _cropImageUrl= json.decode(imageResponse.body)['items'][0]['link']; 
    } catch (error) {
      print("image search error");
    }


final imageRecogUrl = 'https://farmezy-7164e-default-rtdb.firebaseio.com/image-detection.json';
    
  }

  


  void yieldPredict(
      String sName, String sPlanted, String cPlanted, double rFall) {
    _stateName = sName;
    _seasonPlanted = sPlanted;
    _cropPlanted = cPlanted;
    _rainFall = rFall;
  }

  String get yield {
    return _expectedYield;
  }

  String get cropUrl {
    return _cropImageUrl;
  }

 

  Future<void> fetchResult() async {
    final url = 'https://farmezy-ml-predictions.herokuapp.com/predictYield';
   
    try {
      final response = await http.post(
        url,
        //headers: {'Content-Type': 'application/json', 'Charset': 'utf-8',"Accept":"application/json"},
        body: {
          'rainfall_mm': _rainFall.toString(),
          'State_Name': _stateName,
          'Crop': _cropPlanted,
          'Season': _seasonPlanted,
        },
      );
      print("expected result: ");
      // print(json.decode(response.body));
      _expectedYield = json.decode(response.body)['tonnes/hectare_yield'];
      print(_expectedYield);
    } catch (error) {
      print("error encountered");
      print(error);
    }
    
  }
}
