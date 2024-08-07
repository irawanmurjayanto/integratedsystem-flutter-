import 'package:barcode_inventory_new/component/report/webview_pr_pdf.dart';
import 'package:flutter/material.dart';
 
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';

class RptWebviewPage extends StatelessWidget {
  final String pr_no;
  RptWebviewPage({Key? key,required this.pr_no}) : super(key: key);

  ScreenshotController screenshotController=ScreenshotController();
  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Screenshot(controller: screenshotController,
      child: WebviewScaffold(
        appBar: AppBar(
          title: Text('Purchase Request Webview'),
          // actions: [
          //   IconButton(onPressed: () {
              
          //   }, icon: Icon(Icons.picture_as_pdf_rounded))
          // ],
         
        ),
        
        url: 'https://irawan.angsoft.info/tests/flutter/crude_2/reportinventeorynew.php?pr_no='+pr_no,
        initialChild: Container(
          height: MediaQuery.of(context).size.height/2,
          //color: Colors.redAccent,
          child: const Center(
            child: Text('Waiting.....'),
          ),
        ),
      ),
      
      ),

      floatingActionButton: FloatingActionButton(
        child: IconButton(onPressed: () {
          
        }, icon: Icon(Icons.picture_as_pdf_sharp)),
        onPressed: () {
       // Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewContainer(pr_no: pr_no),));
       screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  ShowCapturedWidget(context, capturedImage!);
                }).catchError((onError) {
                  print(onError);
                });
      },),
    );
  }
}