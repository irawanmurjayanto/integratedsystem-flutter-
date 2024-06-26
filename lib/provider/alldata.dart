import 'dart:io';

import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/component/data/server.dart';
import 'package:barcode_inventory_new/modeldata/modeldata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class Alldata with  ChangeNotifier {
List<Group_Item> _groupitem=[];
List<Group_Item> get groupitemglobal=>_groupitem;
bool isLoading=false;
//File? image;


Future<void> listGroupitem() async{

var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');
final response=await http.post(
  url,
  body:{
    'tipe':'lihatgroupitem'
  });

final convertData=jsonDecode(response.body)['data'] as List;
final newdata=convertData.map((e) => Group_Item.fromJson(e)).toList();
_groupitem=newdata;
//print(_groupitem);
isLoading=true;
notifyListeners();
} 


List<Unit_Item> _unititem=[];
List<Unit_Item> get unitemglobal=>_unititem; 

Future <void> listUnit() async {

var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');
final response=await http.post(
  url,
  body: {
    'tipe':'unit'
  }
);
 final ConvertData=jsonDecode(response.body)['data'] as List;
 print(ConvertData);
 final newdata=ConvertData.map((e) => Unit_Item.fromJson(e)).toList();
 _unititem=newdata;
 isLoading=true;
 notifyListeners();
}
 
 
 Future <void> SaveMaster(image,BuildContext context,String kode,String nama,String barcode,String groupitem,String datedoc,String unititem,String notes) async {

 var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');
 final response =await http.post(
  url,
  body: {
    'tipe':'masterbarang',
    'kode':kode,
    'nama':nama,
    'barcode':barcode,
    'groupitem':groupitem,
    'datedoc':datedoc,
    'unititem':unititem,
    'notes':notes,
    'image':image,
  } 
  
  );

  

  if (response.statusCode==200)
  {
    var json=jsonDecode(response.body);

    print (json['message']);
   
     setMessage("Save OK", context);
  }

    
  notifyListeners();
 }


List<List_MasterBarang> _listmasterbarang=[];
List<List_MasterBarang> get listmasterbarangglobal=>_listmasterbarang;

 Future <void> List_MasterBaranang(String item) async {

 var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');

  final response =await http.post(
    url,
    body: {
      'tipe':'list_masterbarang',
      'item':item,
    
    }
  );

  final convertData=jsonDecode(response.body)['data'] as List;
  print(convertData);
  final _newdata=convertData.map((e) => List_MasterBarang.fromJson(e)).toList();
  _listmasterbarang=_newdata;
  notifyListeners();
  
 }

  Future <void> getPict_MasterBarang() async{
    var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');
  }

}
 