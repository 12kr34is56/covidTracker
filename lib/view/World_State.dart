import 'dart:async';
import 'package:covidtracker/Models/WorldStateModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'countries.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Covid Tracker"),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: stateServices.getStateApi(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                              "Death": double.parse(snapshot.data!.deaths!.toString()),
                              // 'total' :100,
                              // 'recovered' :80,
                              // 'dead' :20,
                            },
                            chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                            chartType: ChartType.ring,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            animationDuration: Duration(milliseconds: 1200),
                            colorList: colorList,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .056),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseRow(title: 'Total', value: snapshot.data!.cases!.toString()),
                                  ReuseRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                                  ReuseRow(title: 'Death', value: snapshot.data!.deaths!.toString()),
                                  ReuseRow(title: 'Active', value: snapshot.data!.active!.toString()),
                                  ReuseRow(title: 'Today Cases', value: snapshot.data!.todayCases!.toString()),
                                  ReuseRow(title: 'Today Death', value: snapshot.data!.todayDeaths!.toString()),
                                  ReuseRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered!.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>countries()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: Color(
                                    0xff1aa260,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text("Track Countries"),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  String title, value;
  ReuseRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title),
              Spacer(
                flex: 1,
              ),
              Text(value),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Divider(),
        ],
      ),
    );
  }
}
