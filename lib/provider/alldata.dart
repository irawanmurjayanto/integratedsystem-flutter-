import 'dart:io';

import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/component/data/server.dart';
import 'package:barcode_inventory_new/login.dart';
import 'package:barcode_inventory_new/main.dart';
import 'package:barcode_inventory_new/modeldata/modeldata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class Alldata with  ChangeNotifier {
List<Group_Item> _groupitem=[];
List<Group_Item> get groupitemglobal=>_groupitem;
bool isLoading=false;

  //connectivity internet

  

  


//File? image;

//Drop List Group item
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

//Drop List Unit
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
 
 //Save Data
 Future <void> SaveMaster(image,BuildContext context,String kode,String nama,String barcode,String groupitem,String datedoc,String unititem,String notes) async {

 var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');

 
    final response =await http.post
    (
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
   
    // setMessage("Save OK", context);
  }

    
  notifyListeners();
 }

//List Master Item
List<List_MasterBarang> _listmasterbarang=[];
List<List_MasterBarang> get listmasterbarangglobal=>_listmasterbarang;

 Future <void> List_MasterBaranang(String item) async {
 _listmasterbarang.clear();
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

//list PR
  List<List_Dept> _deptName=[];
  List<List_Dept> get deptNameGlobal=>_deptName;

  Future <void> getList_Dept() async {
    _deptName.clear();
    var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');
    final response=await http.post(
      url,
      body: {
        'tipe':'lihat_dept'
      }
      );

      // if (response.statusCode==200)
      // {
          final json=jsonDecode(response.body)['data'] as List;
          final  newData=json.map((e) => List_Dept.fromJson(e)).toList();
          _deptName=newData;
          print(json);
          notifyListeners();
      // }

      

  }

  //Insert Data to PR Manual

  Future <void> Insert_PR_Manual(BuildContext context, String pr_no,String kode_item,String nama_item,String pr_tgl,String qty_pr,String unit_pr,String dept_pr,String u_name ) async{
    var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');
  
  
    final response=await http.post(
      url,
      body: {
        'tipe':'insert_pr_manual',
        'pr_no':pr_no,
        'kode_item':kode_item,
        'nama_item':nama_item,
        'pr_tgl':pr_tgl,
        'qty_pr':qty_pr,
        'unit_pr':unit_pr,
        'dept_pr':dept_pr,
        'u_name':u_name
      }
    );

    if (response.statusCode==200)
    {
      final json=jsonDecode(response.body);
      print (json['message']);
      setMessage("INsert OK", context);
  
    }else
    {
      setMessage("INsert NOT OK", context);
    }
    notifyListeners();
  }


Future <void> Insert_PR_Manual_Barcode(BuildContext context, String barcode,String pr_no,String pr_tgl,String dept_pr,String u_name ) async{
    var url=Uri.parse(NamaServer.server+'tests/flutter/crude_2/inventorynew.php');
  
  
    final response=await http.post(
      url,
      body: {
        'tipe':'insert_pr_manual_barcode',
        'barcode':barcode,
        'pr_no':pr_no,
        'pr_tgl':pr_tgl,
        'dept_pr':dept_pr,
        'u_name':u_name
      }
    );

    if (response.statusCode==200)
    {
      final json=jsonDecode(response.body);
      print (json['message']);
    // setMessage("INsert OK", context);
  
    }else
    {
      setMessage("INsert NOT OK", context);
    }
    notifyListeners();
  }


  List <Lihat_PR_Manual> _data_manual_pr=[];
  List <Lihat_PR_Manual> get data_manual_prglobal=>_data_manual_pr;
  List <Total_Qty_PR> _data_Qty_PR=[];
  List <Total_Qty_PR> get data_Qty_PR_global =>_data_Qty_PR;
 

  Future <void> getDetail_PR_Manual(String pr_no) async {
    _data_manual_pr.clear();
    
    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");
    final response=await http.post(
      url,
      body: {
        'tipe':'lihat_pr_manual',
        'pr_no':pr_no
      }
    );
    if (response.statusCode==200)
    {
      final json =jsonDecode(response.body)['data'] as List;
      final newData=json.map((e) => Lihat_PR_Manual.fromJson(e)).toList();

      final json2 =jsonDecode(response.body)['data'] as List;
      final newData2=json2.map((e) => Total_Qty_PR.fromJson(e)).toList();

      // final newData2=json2.map((e) 
      // {
      // return 
      // Total_Qty_PR(qty_pr:e['qty_pr']);
      // }
      // ).toList();
    
    
    //   int i;
    //  for (i=0;i<json2.length;i++)
    //  {
    //   _data_Qty_PR.add(json2[5]);
    //  }



    //print('json222');    
      _data_manual_pr=newData;
      _data_Qty_PR=newData2;
      

    
    }
    notifyListeners();
  }

 List <List_PR_Detail> _list_pr_detail=[];
 List <List_PR_Detail> get list_pr_detailglobal=>_list_pr_detail;

  Future <void> getDetail_List_PR(String pr_no) async{
    _list_pr_detail.clear();
    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");
    final response=await http.post(
      url,
      body: {
        'tipe':'list_pr_detail',
        'pr_no':pr_no
      }
      );

      if (response.statusCode==200)
      {

        final json=jsonDecode(response.body)['data'] as List;
        print (json);
        final _newData=json.map((e) => List_PR_Detail.fromJson(e)).toList();
        _list_pr_detail=_newData;
      }

      notifyListeners();

  }

  //update qty_pr
  Future <void> setUpdateQtyPRByidno(String idno,String Qty) async {

    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");

    final response=await http.post(
      url,
      body: {
        'tipe':'update_qty_pr',
        'idno':idno,
        'qty_pr' :Qty
      }
      
      );

      if (response.statusCode==200)
      {
            final json=response.body;

      }


  }


  //delet qty_pr
  Future <void> setDeleteQtyPRByidno(String idno) async {

    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");

    final response=await http.post(
      url,
      body: {
        'tipe':'delete_qty_pr',
        'idno':idno
      }
      
      );

      if (response.statusCode==200)
      {
            final json=response.body;

      }
notifyListeners();

  }


  //insert pass/user

  Future <void> setUserPass(context,String u_name,String u_pass,String dept_name) async {

    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");

    final response=await http.post(
      url,
      body: {
        'tipe':'create_user',
        'u_name':u_name,
        'u_pass':u_pass,
        'dept_name':dept_name,
      }
      
      );
          //  if (response.statusCode==200)
          //  {
           final _newData=jsonDecode(response.body);
              if (_newData['message']=='error')
              {
                setMessage("User alaready exist,pls choose another user nama", context);
              } else
              {
                 setMessage("User Registered Succesfully", context);
                 Future.delayed(Duration(milliseconds: 10000));
                 Navigator.push(context, MaterialPageRoute(builder:(context) => Login(),));
              }
          //  }

            notifyListeners();
  }




//insert pass/user
   getSession() async{
    await GetStorage.init();
   }
   

  Future <void> getUserPass(context,String u_name,String u_pass) async {
    getSession();
    final box=GetStorage();
    box.write('u_name', u_name);

    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");

    final response=await http.post(
      url,
      body: {
        'tipe':'check_userpass',
        'u_name':u_name,
        'u_pass':u_pass,
       // 'dept_name':dept_name,
      }
      
      );
          //  if (response.statusCode==200)
          //  {
           final _newData=jsonDecode(response.body);

           print(_newData);

              if (_newData['message']=='no')
              {
                setMessage("Use/Password Invalid", context);
                EasyLoading.dismiss();
                return;  
              } 

              if (_newData['message']=='x')
              {
                setMessage("You must be registered first", context);
                EasyLoading.dismiss();
                return;
              } 
              
              if (_newData['message']=='ok')
              {
                // setMessage("Succesfully Get in", context);
                // Future.delayed(Duration(milliseconds: 10000));    
                 Navigator.push(context, MaterialPageRoute(builder:(context) => HomePage(),));
              }
          //  }

            notifyListeners();
            EasyLoading.dismiss();
  }



 
  List <Msg_anc_data> _getmsganc=[];
  List <Msg_anc_data> get getmsganc_global=>_getmsganc;

  Future <void> getMsgAnc() async {
    _getmsganc.clear();
    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");

    final response=await http.post(
      url,
      body: {
        'tipe':'msg1',
      }
    );
        // if (response.statusCode==200)
        // {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final newdata=json.map((e) => Msg_anc_data.fromJson(e)).toList();
         _getmsganc=newdata;
          
        // }
      
        notifyListeners();
  }

 
 
  List<Cust_POS> _getCustPOS=[];
  List<Cust_POS> get getCustPOS_Global=>_getCustPOS;

  Future <void> getDataCustPOS() async {
    var url=Uri.parse(NamaServer.server+"tests/flutter/crude_2/inventorynew.php");
    final response=await http.post(
      url,
      body: {
        'tipe':'cust_pos',
      }
      );

      if (response.statusCode==200)
      {
        final json =jsonDecode(response.body)['data'] as List;
        final newData=json.map((e) => Cust_POS.fromJson(e)).toList();
        _getCustPOS=newData;
      }
      notifyListeners();
  }


}


