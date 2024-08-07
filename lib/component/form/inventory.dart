import 'package:flutter/cupertino.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),
    child: Container(
      child: Center(child: Text("Inventory",style: TextStyle(fontSize: 16),),),
    ),
    
    );
  }
}