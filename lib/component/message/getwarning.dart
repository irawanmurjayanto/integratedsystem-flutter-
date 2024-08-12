import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


void setMessage(String pesan,BuildContext context){
  final kirim =  SnackBar(content:Text(pesan,style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
  behavior: SnackBarBehavior.floating,
 
  backgroundColor: Colors.teal,
  shape: StadiumBorder(side: BorderSide(width:2,style: BorderStyle.solid,strokeAlign: BorderSide.strokeAlignCenter)),
  margin: EdgeInsets.only(
    left:30,right:30,bottom: MediaQuery.of(context).size.height-450
  ),
  );
  
  ScaffoldMessenger.of(context).showSnackBar(kirim);
   

}


void setWarning(String pesan,BuildContext context){
  final kirim =  SnackBar(content:Text(pesan,style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
  behavior: SnackBarBehavior.floating,
 
  backgroundColor: Colors.red,
  shape: StadiumBorder(side: BorderSide(width:2,style: BorderStyle.solid,strokeAlign: BorderSide.strokeAlignCenter)),
  margin: EdgeInsets.only(
    left:30,right:30,bottom: MediaQuery.of(context).size.height-450
  ),
  );
  
  ScaffoldMessenger.of(context).showSnackBar(kirim);
   

}


  void getStatusInet(BuildContext context) async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
   //  setWarning("Mobile Connection lost,please wait..", context);
     //return ;
     
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    // setWarning("Wifi Connection lost,please wait...", context);
     
    }else
    {
      EasyLoading.dismiss();
      setWarning("Internet Connection lost,please wait...", context);
      return;
    }
  }