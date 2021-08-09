import 'package:flutter/material.dart';

class View extends StatefulWidget {
  View({this.addData, this.timeData});
  final dynamic addData;
  final dynamic timeData;

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  String gu = '';
  String si = '';
  String time = '';

  @override
  void initState() {
    super.initState();
    updateData(widget.addData, widget.timeData);
  }

  void updateData(dynamic addData, dynamic timeData) {
    gu = addData["results"][1]['region']['area2']['name'];
    si = addData["results"][1]['region']['area1']['name'];
    time = timeData;
    print(gu);
    print(time);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(si), Text(gu), Text("일몰 시간: ${time}")],
            )));
  }
}
