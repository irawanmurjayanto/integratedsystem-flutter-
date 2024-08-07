// //import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';

// // Future main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await FlutterDownloader.initialize(
// //       debug: true // optional: set false to disable printing logs to console
// //   );
// //   await Permission.storage.request();
// //   runApp(WebViewContainer(targetUrl: targetUrl));
// // }



// class WebViewContainer extends StatefulWidget {
//   final String pr_no;

//   WebViewContainer({Key?key, required this.pr_no}) : super(key: key);

//   @override
//   _WebViewContainerState createState() => _WebViewContainerState(pr_no:pr_no);
// }

// class _WebViewContainerState extends State<WebViewContainer> {
//     late InAppWebViewController _webViewController;
//     final String pr_no;
//     _WebViewContainerState({required this.pr_no});


  
// Future <void> getDownload() async{
//    await FlutterDownloader.initialize();
//    await Permission.storage.request();
// }

//   Future<dynamic> ShowCapturedWidget(
//       BuildContext context, Uint8List capturedImage) {
//     return showDialog(
//       useSafeArea: false,
//       context: context,
//       builder: (context) => Scaffold(
//         appBar: AppBar(
//           title: Text("Captured widget screenshot"),
//         ),
//         body: Center(child: Image.memory(capturedImage)),
//       ),
//     );
//   }
  
// @override
//   void initState() {
//     getDownload();
//     // TODO: implement initState
//     super.initState();
//   }  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter InAppWebView Example'),
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: Uri.parse('https://irawan.angsoft.info/tests/flutter/crude_2/reportinventeorynew.php?pr_no='+pr_no,)),
//         onWebViewCreated: (InAppWebViewController controller) {
//           _webViewController = controller;
//         },
//         initialOptions: InAppWebViewGroupOptions(
//               crossPlatform: InAppWebViewOptions(
//               //  debuggingEnabled: true,
//                 useOnDownloadStart: true,

//                   useShouldOverrideUrlLoading: true,
        
//                 mediaPlaybackRequiresUserGesture: false,

              



//               ),


               
//       android: AndroidInAppWebViewOptions(
//         useHybridComposition: true,
//         supportMultipleWindows: true,
//       ),
//       ios: IOSInAppWebViewOptions(
//         allowsInlineMediaPlayback: true,
//       ) 


//             ),
     
//         onLoadStart: (InAppWebViewController controller, url) async{
         
         
//           setState(() {
//             print(' Page started loading: $url');
//           });


//            Directory? tempDir =
//                               await getExternalStorageDirectory();
             
//              setState(() {
//               print("onDownloadStart $url");
//              });

//                  await FlutterDownloader.enqueue(
//                       url: url.toString(),
//                     //  fileName: url.suggestedFilename, //================File Name
//                       savedDir: tempDir!.path,
//                       showNotification: true,
//                       requiresStorageNotLow: false,
//                       openFileFromNotification: true,
//                       saveInPublicStorage: true,
//                           );



//         },
 
//           //  onDownloadStartRequest: (InAppWebViewController controller, url) async {
//           //     Directory? tempDir =
//           //                     await getExternalStorageDirectory();
             
//           //    setState(() {
//           //     print("onDownloadStart $url");
//           //    });

//           //        await FlutterDownloader.enqueue(
//           //             url: url.toString(),
//           //           //  fileName: url.suggestedFilename, //================File Name
//           //             savedDir: tempDir!.path,
//           //             showNotification: true,
//           //             requiresStorageNotLow: false,
//           //             openFileFromNotification: true,
//           //             saveInPublicStorage: true,
//           //                 );
                        

//           //   },    


            
            


//         // onLoadStop: (InAppWebViewController controller, url) {
//         //   setState(() {
//         //      print("onDownloadStart $url");
//         //   });
//         // },
//       ),
//     );
//   }
// }