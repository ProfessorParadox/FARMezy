import 'package:farmezy_alpha/providers/yield_predict_provider.dart';
import 'package:farmezy_alpha/screens/fertiliser_suggest_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './yield_predict.dart';
import './crop_recommend.dart';
import './fertiliser_suggest.dart';

import '../widgets/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  // const DashboardScreen({ Key? key }) : super(key: key);
  static const routeName = '/dashboard-Screen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _isLoading =false;
  var _isInit = true;
  @override

  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero).then((value){
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      setState(() {
        _isLoading=true;
      });
      Provider.of<YieldData>(context,listen: false).getImageData().then((_) {
       Provider.of<YieldData>(context,listen: false).getSensorData().then((_){
        setState(() {
          _isLoading=false;
        });
        });
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading ?  Center(child: CircularProgressIndicator(),) :  Container(
        color: Colors.teal[50],
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Camera(),
              SizedBox(
                height: 10,
              ),
              YieldPrediction(),
              SizedBox(
                height: 10,
              ),
              CropRecommendation(),
              SizedBox(
                height: 10,
              ),
              FertilizerSuggestion(),
              SizedBox(height: 10),
              TempnHumidity(),
              SizedBox(
                height: 10,
              ),
              PhPMSoil(),
            ],
          ),
        ),
      ),
    );
  }
}

class YieldPrediction extends StatelessWidget {
  // const YieldPrediction({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: MediaQuery.of(context).size.height*0.3,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushReplacementNamed(YieldPredictFormScreen.routeName);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "  Crop Yield Prediction",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/yield.png'),
                    fit: BoxFit.fill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CropRecommendation extends StatelessWidget {
  // const YieldPrediction({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: MediaQuery.of(context).size.height*0.3,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushReplacementNamed(CropRecFormScreen.routeName);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "  Crop Recommendation",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/crop.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FertilizerSuggestion extends StatelessWidget {
  // const YieldPrediction({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: MediaQuery.of(context).size.height*0.3,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushReplacementNamed(FertiSuggestFormScreen.routeName);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "  Fertilizer Suggestion",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fertilizer.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TempnHumidity extends StatefulWidget {
  //const TempnHumidity({ Key? key }) : super(key: key);

  @override
  _TempnHumidityState createState() => _TempnHumidityState();
}

class _TempnHumidityState extends State<TempnHumidity> {
  @override
  Widget build(BuildContext context) {
    String temperature = Provider.of<YieldData>(context, listen: true).tempData;
    String humidity =
        Provider.of<YieldData>(context, listen: true).humidityData;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () async {
          await Provider.of<YieldData>(context, listen: false).getSensorData();
          temperature = Provider.of<YieldData>(context, listen: false).tempData;
          humidity =
              Provider.of<YieldData>(context, listen: false).humidityData;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "  Temperature and Humidity",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(children: [
              Text(
                " Temperature : ",
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "${temperature} C",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal[700],
                    fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(height: 5),
            Row(children: [
              Text(
                " Humidity : ",
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "${humidity} %",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal[700],
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class PhPMSoil extends StatefulWidget {
  //const PhPMSoil({ Key? key }) : super(key: key);

  @override
  _PhPMSoilState createState() => _PhPMSoilState();
}

class _PhPMSoilState extends State<PhPMSoil> {
  @override
  Widget build(BuildContext context) {
    String ph = Provider.of<YieldData>(context, listen: true).phData;
    String pm25 = Provider.of<YieldData>(context, listen: true).pm25Data;
    String soilMoisture =
        Provider.of<YieldData>(context, listen: true).soilMoistureData;
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () async {
          await Provider.of<YieldData>(context, listen: false).getSensorData();
          ph = Provider.of<YieldData>(context, listen: false).phData;
          pm25 = Provider.of<YieldData>(context, listen: false).pm25Data;
          soilMoisture =
              Provider.of<YieldData>(context, listen: false).soilMoistureData;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "  pH PM2.5 and Soil Moisture",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(children: [
              Text(
                " pH : ",
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "${double.parse(ph).toStringAsFixed(3)}",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal[700],
                    fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(height: 5),
            Row(children: [
              Text(
                " PM2.5 : ",
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "${double.parse(pm25).toStringAsFixed(3)}",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal[700],
                    fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(height: 5),
            Row(children: [
              Text(
                " Soil Moisture : ",
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "${double.parse(soilMoisture).toStringAsFixed(3)} %",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal[700],
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class Camera extends StatefulWidget {
  //const Camera({ Key? key }) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    /*for(int i=0;i>-1;i++){
    String imageURL = Provider.of<YieldData>(context, listen: true).animalImage;
    String animalName = Provider.of<YieldData>(context, listen: true).animal;
    String time = Provider.of<YieldData>(context, listen: true).timeStamp;
    } */
    String imageURL = Provider.of<YieldData>(context, listen: true).animalImage;
    String animalName = Provider.of<YieldData>(context, listen: true).animal;
    String time = Provider.of<YieldData>(context, listen: true).timeStamp;
    return Container(
      //  height: MediaQuery.of(context).size.height*0.3,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          Provider.of<YieldData>(context, listen: false).getImageData();
          imageURL = Provider.of<YieldData>(context, listen: false).animalImage;
          animalName = Provider.of<YieldData>(context, listen: false).animal;
          time = Provider.of<YieldData>(context, listen: false).timeStamp;
          if (animalName != 'No animal detected') {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      title: Text('Warning',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.red,
                              fontSize: 30)),
                      content: Text(
                        '${animalName} is detected near your field \n\n At : ${time}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                        )
                      ],
                    ));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "  Live Camera",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5,),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
