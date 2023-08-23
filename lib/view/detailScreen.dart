import 'package:flutter/material.dart';
import 'World_State.dart';

class detailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCase,
      totalDeath,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  detailScreen({
    required this.image,
    required this.name,
    required this.totalCase,
    required this.totalDeath,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(

                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      ReuseRow(
                          title: "totalCase", value: widget.totalDeath.toString()),
                      ReuseRow(
                          title: "totalDeath", value: widget.totalDeath.toString()),
                      ReuseRow(
                          title: "totalRecovered",
                          value: widget.totalRecovered.toString()),
                      ReuseRow(title: "active", value: widget.active.toString()),
                      ReuseRow(
                          title: "critical", value: widget.critical.toString()),
                      ReuseRow(
                          title: "todayRecovered",
                          value: widget.todayRecovered.toString()),
                      ReuseRow(title: "test", value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(radius: 50, backgroundImage: NetworkImage(widget.image)),
            ],
          ),
        ],
      ),
    );
  }
}
