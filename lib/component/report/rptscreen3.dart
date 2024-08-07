import 'dart:math';
import 'dart:typed_data';
import "dart:io";
 

import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/component/report/pdfcreate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:share_plus/share_plus.dart';


import 'dart:ui' as ui;


class MyHomePageJ extends StatefulWidget {
  MyHomePageJ({Key? key, required this.pr_no}) : super(key: key);
  final String pr_no;

  @override
  _MyHomePageStateJ createState() => _MyHomePageStateJ(pr_no:pr_no);
}

class _MyHomePageStateJ extends State<MyHomePageJ> {
  //Create an instance of ScreenshotController

    final String pr_no;
    _MyHomePageStateJ({required this.pr_no});

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Test Screen 3"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.abc_rounded),
        onPressed: () {
        
        
 screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  ShowCapturedWidget(context, capturedImage!);
                  screenToPdf("irawan2", capturedImage);
                }).catchError((onError) {
                  print(onError);
                });
               



      },),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                    height: MediaQuery.of(context).size.height/2,
               
                  child:  wevbiew2()
                  )),
            
       
            
          ],
        ),
      ),
    );
  }




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

  // _saved(File image) async {
  //   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
  //   print("File Saved to Gallery");
  // }



 Widget wevbiew2(){
    return   WebviewScaffold(
        appBar: AppBar(
          title: Text('Purchase Request Webview2'),
          // actions: [
          //   IconButton(onPressed: () {
              
          //   }, icon: Icon(Icons.picture_as_pdf_rounded))
          // ],
         
        ),
        
        url: 'https://irawan.angsoft.info/tests/flutter/crude_2/reportinventeorynew.php?pr_no='+pr_no,
        initialChild: Container(
           height: MediaQuery.of(context).size.height/2
          //color: Colors.redAccent,
          // child: const Center(
          //   child: Text('Waiting.....'),
          // ),
        )
    );

 }

}