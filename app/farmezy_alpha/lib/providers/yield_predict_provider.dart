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
  String _temp;
  String _humidity;
  String _ph;
  String _recommendedCrop;
  String _cropImageUrl;
  String _animalDetected;
  String _timeStamp;

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
