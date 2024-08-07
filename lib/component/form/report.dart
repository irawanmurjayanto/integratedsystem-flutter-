import 'package:flutter/cupertino.dart';

class Report1 extends StatefulWidget {
  const Report1({super.key});

  @override
  State<Report1> createState() => _Report1State();
}

class _Report1State extends State<Report1> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),
    child: Container(
      child: Center(child: Text("Report",style: TextStyle(fontSize: 16),),),
    ),
    
    );
  }
}