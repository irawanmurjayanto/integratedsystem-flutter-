import 'package:barcode_inventory_new/component/report/pdfprevpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class Rpt_Test_PDF extends StatelessWidget {
  Rpt_Test_PDF({super.key});

  String Text1="A barcode or bar code is a method of representing data in a visual, machine-readable form. Initially, barcodes represented data by varying the widths, spacings and sizes of parallel lines. Wikipedia";


        final pdf = pw.Document();

        Future <void> savePDF() async {
                final file = File("example.pdf");
await file.writeAsBytes(await pdf.save());
        }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Test PDF"),),
      body: Column(
        children: [
          Image.asset("assets/images/barcode.png"),
          Text(Text1),
        ],
      ), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.picture_as_pdf_sharp),
        onPressed: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context){
        //     return  PdfPreviewPage(text:Text1);
        //   }));
            
     // Page
     pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("Hello World"),
        ); // Center
      }));


      savePDF();

          },),
        
    );
     
  }
}