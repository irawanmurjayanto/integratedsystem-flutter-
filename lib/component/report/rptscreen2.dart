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

class InAppWebViewExampleScreen extends StatefulWidget {

final String pr_no;
InAppWebViewExampleScreen({Key?key,required this.pr_no}):super(key: key);


// Future<void> _convertImageToPDF(screenShot) async {
 
  

// //Create a new PDF document.
// final PdfDocument document = PdfDocument();
// //Read image data.
// final Uint8List imageData = File(screenShot).readAsBytesSync();
// //Load the image using PdfBitmap.
// final PdfBitmap image = PdfBitmap(imageData);
// //Draw the image to the PDF page.
// document.pages
//     .add()
//     .graphics
//     .drawImage(image, const Rect.fromLTWH(0, 0, 500, 200));
// // Save the document.

// File('ImageToPDF.pdf').writeAsBytes(await document.save());
// // Dispose the document.
// document.dispose();


//   }

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

 
  //  Future <void> getExcelData(int results) async{

  //             //Creating a workbook.
  //         final Workbook workbook = Workbook();
  //         //Accessing via index
  //         final Worksheet sheet = workbook.worksheets[0];
  //         const String excelFile = 'test_download';

  //      for (var i = 0; i < results.length; i++) {
  //               sheet.getRangeByIndex(i + 5, 1).setText(results[i][0]);
  //               sheet.getRangeByIndex(i + 5, 2).setText(results[i][3]['Maths'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 3).setText(results[i][3]['English'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 4).setText(results[i][3]['Kiswahili'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 5).setText(results[i][3]['Physics'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 6).setText(results[i][3]['Biology'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 7).setText(results[i][3]['Chemistry'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 8).setText(results[i][3]['Geography'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 9).setText(results[i][3]['Spanish'][0].toString());
  //               sheet.getRangeByIndex(i + 5, 10).setText(results[i][3]['Total'][0].toString());
  //             }

  //  }

  @override
  void initState() {
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

                 //Creating a workbook.
          final Workbook workbook = Workbook();
          //Accessing via index
          final Worksheet sheet = workbook.worksheets[0];
          const String excelFile = 'test_download';
          
              sheet.getRangeByIndex(1, 1).setText('All Students');
              sheet.getRangeByIndex(2, 1).setText('Form 4 West'); // example class
              sheet.getRangeByIndex(4, 1).setText('NO');
              // set the titles for the subject results we want to fetch
              sheet.getRangeByIndex(4, 2).setText('Item');
              sheet.getRangeByIndex(4, 3).setText('Qty');

              final prov=Provider.of<Alldata>(context,listen: false);
              prov.getDetail_PR_Manual(pr_no!);
              final int hit=prov.data_manual_prglobal.length;

              for (var i = 0; i < hit; i++) {
              sheet.getRangeByIndex(i + 5, 1).setText(i.toString());
              sheet.getRangeByIndex(i + 5, 2).setText(prov.data_manual_prglobal[i].nama_item);
              sheet.getRangeByIndex(i + 5, 2).setText(prov.data_manual_prglobal[i].qty_pr);
              }

              final List<int> bytes = workbook.saveAsStream();
              File('/storage/emulated/0/Download/$excelFile.xlsx').writeAsBytes(bytes);

              // toast message to user
              setMessage("Download Succesfully ", context);

              //dispose the workbook
              workbook.dispose();
              

              
           

              // loop through the results to set the data in the excel sheet cells
             

            
            
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