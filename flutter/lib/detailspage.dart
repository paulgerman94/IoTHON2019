import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:iothon2019/homepage.dart';
import 'package:iothon2019/server/service.dart';

class DetailsPage extends StatefulWidget {
  final String placeName;
  final double lat;
  final double long;

  DetailsPage({this.placeName, this.lat, this.long});

  @override
  DetailsPageState createState() =>
      new DetailsPageState(placeName: placeName, lat: lat, long: long);
}

class DetailsPageState extends State<DetailsPage> {
  //Constructor
  final String placeName;
  final double lat;
  final double long;

  //API
  String dominant_pollutant = "";
  String air_condition = "";
  String temperature = "";
  double humidity = 0.0;

  //Date
  String formattedDate = "";

  DetailsPageState({this.placeName, this.lat, this.long});

  @override
  void initState() {
    super.initState();
    this.initService();
    this.getCurrentDate();
  }

  //Call to the database to bring the data from a Light pole
  Future<void> initService() async {
    await ServiceAPI().getLocationData(lat, long).then((res) {
      setState(() {
        temperature = res.temperature.round().toString();
        humidity = res.humidity;
        dominant_pollutant = res.airQuality.dominantPollutant;
        air_condition = res.airQuality.type;
      });
    });
  }

  void getCurrentDate() {
    var now = new DateTime.now().add(Duration(hours: 3));
    var formatter = new DateFormat('Hm');
    formattedDate = formatter.format(now);
    //print(new DateFormat.yMMMd().format(new DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }), //IconButton
        title: Text(placeName),
      ), //AppBar

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          _weather(context),
          _humidity(context),
          _airQuality(context)
        ]),
      ), //Scaffold
    );
  }

  // ############ WEATHER ############
  // Weather Layout
  Widget _weather(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: _weatherBox(
          "https://fortunedotcom.files.wordpress.com/2011/12/sun.jpg",
          "Otaniemi"),
    );
  }

  //Weather Box
  Widget _weatherBox(String _imageWeather, String placeName) {
    return GestureDetector(
      child: new FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Color(0x802196F3),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(0.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_imageWeather),
                    ),
                  ),
                ),
                Container(child: weatherTextContainer(placeName)),
              ]),
        ),
      ),
    );
  }

  Widget weatherTextContainer(String placeName) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Time
          Text(
            temperature,
            style: TextStyle(
                color: Colors.black,
                fontSize: 48.0,
                fontWeight: FontWeight.bold),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Espoo",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Clear",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text(
//                          lightPole.temperature.round().toString(),
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 24.0,
//                          ),
//                        ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
//                      ],
//                    ),
//                    Text(
//                      "Feels like -3º",
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 18.0,
//                      ),
//                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ############ HUMIDITY ############
  // Weather Layout
  Widget _humidity(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: _humidityBox(
        humidity,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYFPDzoFMZxQG3K4Z9HltwkDb1qbR6ut4OV_jiMECkz5yZrvIA",
      ),
    );
  }

  //Weather Box
  Widget _humidityBox(double humidity, String _imageHumidity) {
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//        Container(

    return GestureDetector(
      child: new FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Color(0x802196F3),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Humidity",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                          ),
                        ),
                        Text(
                          humidity.toString() + "%",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(0.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_imageHumidity),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  // ############ AIR QUALITY ############
  // Weather Layout
  Widget _airQuality(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: _airQualityBox(
        humidity,
        "https://www.haierbiomedical.co.uk/wp-content/uploads/2017/02/haier_clean-air-icon.png",
      ),
    );
  }

  //Weather Box
  Widget _airQualityBox(double humidity, String _imageAirCondition) {
    return GestureDetector(
      child: new FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Color(0x802196F3),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(0.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_imageAirCondition),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Air Quality",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          air_condition,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                          ),
                        ),
                        Text(
                          dominant_pollutant,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                          ),
                        ),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}
