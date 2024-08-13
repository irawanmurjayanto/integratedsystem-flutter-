import 'dart:async';
import 'dart:typed_data';
import 'package:barcode_inventory_new/component/data/server.dart';
import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/component/report/pdfcreate.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
 
 
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;

 
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'; 


import 'dart:io';
//import 'dart:js';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:collection/collection.dart';

class InAppWebViewExampleScreen extends StatefulWidget {

final String pr_no;
InAppWebViewExampleScreen({Key?key,required this.pr_no}):super(key: key);



  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState(pr_no:pr_no);
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
//InAppWebViewController webViewController;

  final String? pr_no;
  _InAppWebViewExampleScreenState({required this.pr_no});

// getprint() async {
  
// final printJobController = await webViewController.printCurrentPage(settings: PrintJobSettings(handledByClient: true));
// } 



  InAppWebViewController? webView;
  Uint8List? screenshotBytes;
  final box=GetStorage();

 

  List<int> jum=[];
  int hit2=0;  
  getJum() async{
    Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual(pr_no!);
    final prov=Provider.of<Alldata>(context,listen: false);
      final int hit =prov.data_manual_prglobal.length;
      
    setState(() {
       hit2=hit;
    });
    
    setMessage(hit.toString(), context);
  }

  Future <void> getJum2() async{
    Consumer<Alldata>(builder: (context, prov, child) {
      return ListView.builder(
        itemCount: prov.data_manual_prglobal.length,
        itemBuilder: (context, i) {
          
      },);
    },);
  }

  getRefresh_Rpt_PR(String pr_nox) async {
    EasyLoading.show(status: "Processing..");
  await Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual(pr_nox);
  
    final prov=Provider.of<Alldata>(context,listen: false);
      final int hit =prov.data_manual_prglobal.length;
      
    
    
   // setMessage(hit.toString(), context);




          final Workbook workbook = Workbook();
          //Accessing via index
          final Worksheet sheet = workbook.worksheets[0];
          //Datetime h=DateTime.fromMillisecondsSinceEpoch();
          const String excelFile = 'Purchase Request';

              sheet.getRangeByName('A4:C4').cellStyle.hAlign=HAlignType.center;

              sheet.getRangeByIndex(1, 1).setText('All Students');
              sheet.getRangeByIndex(2, 1).setText('Form 4 West'); // example class
              sheet.getRangeByIndex(4, 1).setText('NO');
              // set the titles for the subject results we want to fetch
              sheet.getRangeByIndex(4, 2).setText('Item');
              sheet.getRangeByIndex(4, 3).setText('Qty');

       
              //sheet.getRangeByIndex(5, 2).setText(prov.data_manual_prglobal[0].nama_item);
              List<int> total=[];
              total.clear();
              for (var i = 0; i < hit; i++) {
              int h=hit+1; 
              total.add(int.parse(prov.data_manual_prglobal[i].qty_pr!));
              sheet.getRangeByIndex(i + 5, 1).setText(h.toString());  
              sheet.getRangeByIndex(i + 5, 1).cellStyle.hAlign=HAlignType.center;  
              sheet.getRangeByIndex(i + 5, 2).setText(prov.data_manual_prglobal[i].nama_item!);
              sheet.getRangeByIndex(i + 5, 2).cellStyle.hAlign=HAlignType.left;  
              sheet.getRangeByIndex(i + 5, 3).setText(prov.data_manual_prglobal[i].qty_pr!);
              sheet.getRangeByIndex(i + 5, 3).cellStyle.hAlign=HAlignType.center;  
    
              }
              sheet.getRangeByIndex(hit + 6, 2).setText("Total QTy");  
              sheet.getRangeByIndex(hit + 6, 3).setText(total.sum.toString());  

      

               // save the document in the downloads file
        final List<int> bytes = workbook.saveAsStream();
        // File('/storage/emulated/0/Download/$excelFile.xlsx').writeAsBytes(bytes);

        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/$excelFile.xlsx').create();
        await imagePath.writeAsBytes(bytes);

        await Share.shareXFiles(([XFile(imagePath.path)]));


    // toast message to user
    // setMessage("Download Succesfully", context);

    //dispose the workbook
    workbook.dispose();

    EasyLoading.dismiss();

}

  @override
  void initState() {
    //getRefresh_Rpt_PR(pr_no!);
    EasyLoading.dismiss();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Purchase Request",style: TextStyle(fontSize: 13,)),
        actions: [
          IconButton(onPressed: ()  {
             
                EasyLoading.show(status: 'Processing..');
               final  filename=DateTime.now().microsecondsSinceEpoch;  
               screenToPdf("Rpt"+filename.toString(), screenshotBytes!);
            

          }, icon: Icon(Icons.picture_as_pdf_sharp,size: 30,)) , 

          IconButton(onPressed: ()  {
                EasyLoading.show(status: 'Processing..');
               final  filename=DateTime.now().microsecondsSinceEpoch;  
               screenToImage("Rpt"+filename.toString(), screenshotBytes!);

          
            

          }, icon: Icon(Icons.image_search,size: 30,)),
          SizedBox(width: 5,),

          IconButton(onPressed: ()  async {
             EasyLoading.show(status: 'Processing..');
             final  filename=DateTime.now().microsecondsSinceEpoch;  
             screenToPrint("Rpt"+filename.toString(), screenshotBytes!);
            

          }, icon: Icon(Icons.print,size: 30,)),
          SizedBox(width: 5,),
          IconButton(onPressed: () {
          getRefresh_Rpt_PR(pr_no!);  
        
            
            
          }, icon: Icon(Icons.exposure_outlined))

           
        ], 
        ),
         
        
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
              child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(NamaServer.server+'tests/flutter/crude_2/reportinventeorynew.php?pr_no='+pr_no!+'&u_name='+box.read('u_name'),)),
          
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                //  debuggingEnabled: true
                supportZoom: true
                 ),
              android: AndroidInAppWebViewOptions(
                textZoom: 200,
                builtInZoomControls: true,
                displayZoomControls: true,
                 

              )   
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onPrint: (InAppWebViewController  controller, url) {
              // webView = controller;
            },
            onLoadStart: (InAppWebViewController controller, url) {},
            onLoadStop: (InAppWebViewController controller, url) async {
             screenshotBytes = await controller.takeScreenshot();
             //screenToPdf("irawanxxx", screenshotBytes!);
              // screenToImage("irawanimage", screenshotBytes!);


              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       content: Image.memory(screenshotBytes!),
              //     );
              //   },
              // );
            },
          ))
        ])));
  }


 
}