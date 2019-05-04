import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:iothon2019/server/model.dart';
import 'package:iothon2019/server/service.dart';

class ChartWidget extends StatefulWidget {
  ChartWidget();

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('10:00', 11),
      new OrdinalSales('10:30', 13),
      new OrdinalSales('11:00', 13),
      new OrdinalSales('11:30', 14),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  State createState() {
    return new ChartWidgetState(
      _createSampleData(),
    );
  }
}

class ChartWidgetState extends State<ChartWidget> {
  final List<charts.Series> seriesList;

  ChartWidgetState(this.seriesList);

  List<charts.Series<LightPoles, String>> _createTemperatureSeries(List<LightPoles> data) {
    return [
      new charts.Series<LightPoles, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LightPoles el, _) => el.time,
        measureFn: (LightPoles el, _) => el.temperature,
        data: data,
      )
    ];
  }

  //Call to the database to bring the data from a Light pole
  Future<List<LightPoles>> getAllLocationData() async {
    var res = await ServiceAPI().getAllLocationData("otaniemi");
    return res;
  }

  @override
  Widget build(BuildContext context) {
//    return ListView.builder(
//      padding: EdgeInsets.all(8.0),
//      itemExtent: 100.0,
//      itemCount: 1,
//      itemBuilder: (BuildContext context, int index) {
//        return getElement(context, index);
//      },
//    );
////  return  new charts.BarChart(
////    seriesList,
////    animate: animate,
////  );
    return ListView(scrollDirection: Axis.vertical, children: <Widget>[
      Container(
        width: 180,
        height: 200,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(0),
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(
                "https://t-lehti.fi/wp-content/uploads/2012/02/otaniemiinnovaatiokeskittyma.jpg"),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
      ),
      Center(
        child: Text(
          "Temperature",
          style: TextStyle(
              color: Colors.black, fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
      ),
      Center(
          child: FutureBuilder<List<LightPoles>>(
            future: getAllLocationData(),
            // a previously-obtained Future<String> or null
            builder: (BuildContext context,
                AsyncSnapshot<List<LightPoles>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {

                return Container(
                  width: 350,
                  height: 250,
                  child: new charts.BarChart(
                    _createTemperatureSeries(snapshot.data),
                    animate: false,
                  ),
                );
              } else {
              return Container();
              }
            },
          )),
    ]);
  }
}

//Container(
//width: 350,
//height: 250,
//child: new charts.BarChart(
//seriesList,
//animate: false,
//),
//),
/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
