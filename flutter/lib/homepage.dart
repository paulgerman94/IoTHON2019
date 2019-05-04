import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iothon2019/detailspage.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      /*
      appBar: AppBar(
        leading: IconButton(icon: Icon(FontAwesomeIcons.arrowLeft), onPressed: (){

        }), //IconButton
        title: Text("Otaniemi"),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: (){
            }),// IconButton
          ], // <Widget>[]
      ), //AppBar
    */
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _buildContainer(), // Horizontal Scroll
        ], // <Widget>[]
      ), //Scaffold
    );
  }

  Widget _googlemap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: LatLng(60.1841379, 24.8125743), zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            //AREAS = Blue
            //Otaniemi
            new Marker(
                markerId: MarkerId('otaniemi'),
                position: LatLng(60.1841379, 24.8125743),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              placeName: "Otaniemi",
                              lat: 60.1841379,
                              long: 24.8125743)));
                }),
            //Matinkyla
            new Marker(
                markerId: MarkerId('matinkyla'),
                position: LatLng(60.1583809, 24.7338766),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              placeName: "Matinkylä",
                              lat: 60.1583809,
                              long: 24.7338766)));
                }),
            //Espoon Keskus
            new Marker(
                markerId: MarkerId('espoonkeskus'),
                position: LatLng(60.2048366, 24.6448674),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              placeName: "Espoon Keskus",
                              lat: 60.2048366,
                              long: 24.6448674)));
                }),

            //PLACES
            //Aalto University
            new Marker(
                markerId: MarkerId('aaltoyliopisto'),
                position: LatLng(60.1866693, 24.8254933),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              placeName: "Aalto University",
                              lat: 60.1866693,
                              long: 24.8254933)));
                }),
            //JMT
            new Marker(
                markerId: MarkerId('jmt'),
                position: LatLng(60.18318, 24.8282988),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              placeName: "Jämerantäival",
                              lat: 60.18318,
                              long: 24.8282988)));
                }),
            //Unisport
            new Marker(
                markerId: MarkerId('unisport'),
                position: LatLng(60.18318, 24.8282988),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              placeName: "Uni Sport Gym",
                              lat: 60.18318,
                              long: 24.8282988)));
                }),
          },
        ));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 150.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              //Otaniemi
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://i.ytimg.com/vi/6zimp87Avvc/maxresdefault.jpg",
                    60.1841379,
                    24.8125743,
                    "Otaniemi"),
              ),
              //Matinkyla
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://mb.cision.com/Public/197/9422238/8e9e511f473cb815_800x800ar.jpg",
                    60.1583809,
                    24.7338766,
                    "Matinkylä"),
              ),
              //Espoon Keskus
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://static.mvlehti.net/uploads/2017/07/espoon-keskus.jpeg",
                    60.2048366,
                    24.6448674,
                    "Espoon Keskus"),
              ),
            ],
          )),
    );
  }

  Widget _boxes(String _image, double lat, double long, String placeName) {
    return GestureDetector(
        onTap: () {
          _gotoLocation(lat, long);
        },
        child: Container(
          child: new FittedBox(
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(_image),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myDetailsContainer(placeName)),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Widget myDetailsContainer(String placeName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Container(
            child: Text(
              placeName,
              style: TextStyle(
                  color: Color(0xff3200ee),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(lat, long), zoom: 14, bearing: 45.0), //tilt: 50.0
    ));
  }
}
