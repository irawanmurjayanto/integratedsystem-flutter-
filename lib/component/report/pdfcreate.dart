import 'dart:io';
//import 'dart:js';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_easyloading/flutter_easyloading.dart';
 
 

Future screenToPdf(String fileName,Uint8List screenShot) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
          child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
        );
      },
    ),
  );
  String path = (await getTemporaryDirectory()).path;
  final pdfFile = await File('$path/$fileName.pdf').create();

   final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(screenShot);



  pdfFile.writeAsBytesSync(await pdf.save());
  //await Share.shareXFiles(([XFile(imagePath.path)]));
  await Share.shareXFiles(([XFile(pdfFile.path)]));
  //await Share.share([pdfFile.path]);
  EasyLoading.dismiss();
}


Future screenToPrint(String fileName,Uint8List screenShot) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
          child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
        );
      },
    ),
  );
  String path = (await getTemporaryDirectory()).path;
  final pdfFile = await File('$path/$fileName.pdf').create();


   final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(screenShot);



  pdfFile.writeAsBytesSync(await pdf.save());

   String pathPDF = pdfFile.path;


  // if (pathPDF.isNotEmpty) {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => MyPdfViewer(path: pathPDF),
  //                       ),
  //                     );
  //                   }

await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());

// final pdf2 = await rootBundle.load(imagePath.path);
// await Printing.layoutPdf(onLayout: (_) => pdf2.buffer.asUint8List());
  //await Share.shareXFiles(([XFile(imagePath.path)]));
  //await Share.shareXFiles(([XFile(pdfFile.path)]));
  //await Share.share([pdfFile.path]);
  EasyLoading.dismiss();
}

Future screenToImage(String fileName,Uint8List screenShot) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
          child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
        );
      },
    ),
  );
  // String path = (await getTemporaryDirectory()).path;
  // final pdfFile = await File('$path/$fileName.pdf').create();

   final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/$fileName.png').create();
        await imagePath.writeAsBytes(screenShot);



  //pdfFile.writeAsBytesSync(await pdf.save());
  await Share.shareXFiles(([XFile(imagePath.path)]));
 // await Share.shareXFiles(([XFile(pdfFile.path)]));
  //await Share.share([pdfFile.path]);
  EasyLoading.dismiss();
}




// class MyPdfViewer extends StatefulWidget {
//   final String base64Pdf;
//   MyPdfViewer({@required this.base64Pdf});
//   @override
//   _MyPdfViewerState createState() => _MyPdfViewerState();
// }
// class _MyPdfViewerState extends State<MyPdfViewer> {
//   PDFViewController pdfViewController;
//   int currentPage = 0;
//   int totalPages = 0;
//   bool isReady = false;
//   String errorMessage = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: Stack(
//         children: [
//           PDFView(
//             filePath: null,
//             fitEachPage: true,
//             fitPolicy: FitPolicy.BOTH,
//             onRender: (_pages) {
//               setState(() {
//                 totalPages = _pages;
//               });
//             },
//             onError: (error) {
//               setState(() {
//                 errorMessage = error.toString();
//               });
//             },
//             onPageError: (page, error) {
//               setState(() {
//                 errorMessage = '$error';
//               });
//             },
//             onViewCreated: (PDFViewController vc) {
//               setState(() {
//                 pdfViewController = vc;
//               });
//               _loadPdf();
//             },
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Center(
//                   child: Text(errorMessage),
//                 ),
//         ],
//       ),
//     );
//   }
//   _loadPdf() async {
//     try {
//       setState(() {
//         isReady = false;
//       });
//       final data = base64Decode(widget.base64Pdf);
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/my_file.pdf');
//       await file.writeAsBytes(data);
//       setState(() {
//         isReady = true;
//       });
//       await pdfViewController.loadFile(file.path);
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//       });
//     }
//   }
// }