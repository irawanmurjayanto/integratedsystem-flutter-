import 'dart:math';
import 'dart:typed_data';
import "dart:io";
 

import 'package:barcode_inventory_new/component/message/getwarning.dart';
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

 
// For rendering widgets and capturing widget subtrees
import 'package:flutter/rendering.dart';
 

class MyHomePageNew extends StatefulWidget {
  MyHomePageNew({Key? key, required this.pr_no}) : super(key: key);
  final String pr_no;

  @override
  _MyHomePageState createState() => _MyHomePageState(pr_no:pr_no);
}

class _MyHomePageState extends State<MyHomePageNew> {

  final String pr_no;
  _MyHomePageState({required this.pr_no});

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  ScreenshotController _screenshotController = ScreenshotController();

  final GlobalKey globalKey = GlobalKey();

//   RepaintBoundary(
//   key: globalKey,
//   child: Scaffold(
//     appBar: AppBar(
//       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       title: const Text('Screenshot Page'),
//     ),
//     body: Center(
//       child: ElevatedButton(
//         onPressed: (){},
//         child: const Text('Take Screenshot'),
//       ),
//     ),
//   ),
// );

  Future<void> _captureScreenShot() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2);
    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List pngBytes = byteData.buffer.asUint8List();
    await Share.shareXFiles([XFile.fromData(pngBytes, mimeType: 'image/png')]);
  }


//  getSave() async {
 
//   ///Capture and saving to a file
//   // screenshotController.captureFromWidget(your_widget(), delay: const Duration(seconds: 1)).then((value) async {
//   //  final  image = value;

//   //   final dir = await getApplicationDocumentsDirectory();
//   //   final imagePath = await File('${dir.path}/captured.png').create();
//   //   await imagePath.writeAsBytes(image!);
//   // });

// }

//  int _counter = 0;
//   Uint8List _imageFile;
 
  @override
  void initState() {
  //  getSave();
 // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
     return RepaintBoundary(
  key: globalKey,
  child:
    Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Purchase Request"),
        actions: [
          IconButton(onPressed: () {
        }, 
          icon: Icon(Icons.ac_unit))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.abc_rounded),
        onPressed: () {
  
          _captureScreenShot();


      },),
      body:  
    //          WebviewScaffold(
  
        
    //     url: 'https://irawan.angsoft.info/tests/flutter/crude_2/reportinventeorynew.php?pr_no='+pr_no,
    //     initialChild: Container(
    //        height: MediaQuery.of(context).size.height/2,
       
    //     )
    // ),
           Center(child: Text("Test Render"),)
          
        ),
    );
      
  }

  // Future<dynamic> ShowCapturedWidget(
  //     BuildContext context, Uint8List capturedImage) {
  //   return showDialog(
  //     useSafeArea: false,
  //     context: context,
  //     builder: (context) => Scaffold(
  //       appBar: AppBar(
  //         title: Text("Captured widget screenshot"),
  //       ),
  //       body: Center(child: Image.memory(capturedImage)),
  //     ),
  //   );
  // }

  // _saved(File image) async {
  //   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
  //   print("File Saved to Gallery");
  // }
  // Widget testWidget(){
  //   return Center(
  //     child: Text("Test Widget"),
  //   );
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
           margin: EdgeInsets.only(top: 50),
          //color: Colors.redAccent,
          // child: const Center(
          //   child: Text('Waiting.....'),
          // ),
        )
    );
  }
}