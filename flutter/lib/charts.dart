import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iothon2019/chart.dart';
import 'package:iothon2019/controls.dart';

//Date

class ChartsPage extends StatefulWidget {
  String area;
  ChartsPage(this.area);

  @override
  ChartsPageState createState() => new ChartsPageState();
}

class ChartsPageState extends State<ChartsPage> {
  ChartsPageState();

  int _cIndex = 0;
  List<String> _title = [
    "Otaniemi",
    "Tapiola",
    "Espoon Keskus",
    "Matinkylä"
  ];

  @override
  void initState() {
    super.initState();
    switch (widget.area) {
      case "Dashboard":
        _cIndex=0;
        break;
      case "Medical Profile":
        _cIndex=1;
        break;
      case "Notifications":
        _cIndex=2;
        break;
      case "Settings":
        _cIndex=3;
        break;
    }
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }
  Widget getDrawer() {
    return  new Drawer(
      child: new ListView(
        children: <Widget>[
          new ListTile(
              leading: new Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/gym.png"),
                    ),
                  )
              ),
              title: new Text("Life Style"),
              onTap: (){
              }
          ),
          new ListTile(
              leading: new Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/man.png"),
                    ),
                  )
              ),
              title: new Text("Medical Profile"),
              onTap: () {
                Navigator.pop(context);
                _incrementTab(1);
              }
          ),
          new ListTile(
              leading: new Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/vitals.png"),
                    ),
                  )
              ),
              title: new Text("Check Ups"),
              onTap: (){
                Navigator.pop(context);

              }
          ),
          new ListTile(
              leading: new Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/calendar.png"),
                    ),
                  )
              ),
              title: new Text("Appointments"),
              onTap: (){
                Navigator.pop(context);
              }
          ),
          new ListTile(
              leading: new Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/syringe.png"),
                    ),
                  )
              ),
              title: new Text("Vaccinations"),
              onTap: (){
                Navigator.pop(context);
              }
          ),
          new ListTile(
              leading: new Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/prescription.png"),
                    ),
                  )
              ),
              title: new Text("Prescription"),
              onTap: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }), //IconButton
        title: Text(_title[_cIndex]),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.cogs),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ControlsPage()),
                );
              }), // IconButton
        ], // <Widget>[]
      ), //AppBar,
      drawer:  getDrawer(),
      body: new ChartWidget(),
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color(0x4286f4),
              primaryColor: Color(0x4286f4),
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          child: new BottomNavigationBar(
            currentIndex: _cIndex,
            type: BottomNavigationBarType.shifting ,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.university,
                      color: Colors.white
                  ),
                  title: new Text(_title[0])
              ),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.university,
                      color: Colors.white
                  ),
                  title: new Text(_title[1])
              ),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.train,
                      color: Colors.white
                  ),
                  title: new Text(_title[2])
              ),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.subway,
                      color: Colors.white
                  ),
                  title: new Text(_title[3])
              )
            ],
            onTap: (index){
              _incrementTab(index);
              print(index);
            },)
      ),
    );
  }
}
