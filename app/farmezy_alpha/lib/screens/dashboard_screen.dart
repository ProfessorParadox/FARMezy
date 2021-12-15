import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  // const DashboardScreen({ Key? key }) : super(key: key);
  static const routeName = '/dashboard-Screen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  height: MediaQuery.of(context).size.height*0.3,
                margin: EdgeInsets.only(top: 10),
                padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Crop Yield Prediction",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Yield is :....",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/crop_yield.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
            Container(
                //  height: MediaQuery.of(context).size.height*0.3,
                margin: EdgeInsets.only(top: 10),
                padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Crop Suggestion",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Suggested Crop is :....",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/crop_yield.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
