import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class POS_Sales extends StatefulWidget {
  const POS_Sales({super.key});

  @override
  State<POS_Sales> createState() => _POS_SalesState();
}

class _POS_SalesState extends State<POS_Sales> {
final _tgl=TextEditingController();
String? _tampung;

getCustPOS() async{
await Provider.of<Alldata>(context,listen: false).getDataCustPOS();
}

getDateNow() async{
 setState(() {
   _tgl.text=DateFormat("dd-MM-yyyy").format(DateTime.now());
 });
}
@override
  void initState() {
    getCustPOS();
    getDateNow();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("POS Sales"),),
      body: Column(
        children: [
            DropCust(),
            getPickDate()
        ],
      ),
    );
  }

  Widget getPickDate(){
    return Container(
      height: 100,
      child: TextFormField(
        controller: _tgl,
        decoration: InputDecoration(
          labelText: "Date",
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.solid,width: 1)            
          )
        ),
        onTap: () async {
          DateTime ? pickdate=await
          showDatePicker(context: context, 
          initialDate: DateTime.now(),
          firstDate: DateTime(1920), 
          lastDate: DateTime(2030));

          if (pickdate!=null)
          {
            final String formatdate=DateFormat("dd-MM-yyyy").format(pickdate);
            
            setState(() {
            _tgl.text=formatdate;
          });
          
         }
          
          
        },
        validator: (value) {
          if (value!.isEmpty)
          {
            return "Date Can not null";

          }
          return null;
        },
      ),
    );
  }
  Widget DropCust() {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
      child: Consumer<Alldata>(builder: (context, prov, child) {
        return ListView.builder(
          itemCount: prov.getCustPOS_Global.length,
          itemBuilder: (context, i) {
            return DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,width: 1)),
                labelText: "Customer Name",
                
              ),
              items: prov.getCustPOS_Global.map((e) => 
              DropdownMenuItem(
                child:Text(e.nama_cust!),
                value: e.idno!,   
                )).toList(), 
              onChanged: (value) {
                setState(() {
                  _tampung!=value;
                });
              },);
          
        },);
        
      },)
    );
  }
}