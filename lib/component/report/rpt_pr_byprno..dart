// import 'dart:html';

import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/component/report/pdfcreate.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/rendering.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:collection/collection.dart';
//
//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

import 'dart:math';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
 

class Rpt_PR_By_PRNO extends StatefulWidget {
  final String? prno;
  final String? dept_pr;
  final String? tgl_pr;
  


  Rpt_PR_By_PRNO({Key?key,required this.prno,required this.dept_pr,required this.tgl_pr}):super(key:key);

  @override
  State<Rpt_PR_By_PRNO> createState() => _Rpt_PR_By_PRNOState(prno:prno,dept_pr:dept_pr,tgl_pr:tgl_pr);
}

class _Rpt_PR_By_PRNOState extends State<Rpt_PR_By_PRNO> {

 final String? prno;
  final String? dept_pr;
  final String? tgl_pr;

  

 _Rpt_PR_By_PRNOState({required this.prno,required this.dept_pr,required this.tgl_pr});


 


getRefresh_Rpt_PR(String pr_no) async {
  await Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual(pr_no);

}

   final pdf = pw.Document();

Future<void> ViewPDFIra() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}  

final int Total=0;
List<int> Jumlah=[];

List<int> Jumlah2=[];

int TotalJumlah=0;
int TotalSemua=0;
 

@override
  void didChangeDependencies() {
   // getJumlah(prno!);
   //setMessage(prno!, context);
   
    super.didChangeDependencies();
  }


 getJumlahTotal() async{
 // Jumlah2.clear;

 
//  getRefresh_Rpt_PR(prno!);
 
  final prov=Provider.of<Alldata>(context,listen:false);
  prov.getDetail_PR_Manual(prno!);

  final int hit=prov.data_Qty_PR_global.length;

  int i=0;

  for (i=0;i<hit;i++)
  {
    Jumlah2.add(int.parse(prov.data_Qty_PR_global[i].qty_pr!));
  }

//  // TotalJumlah=int.parse(prov.data_Qty_PR_global[hit].qty_pr!);
 
 

  setState(() {
  //Jumlah2.add(2)  ;
  TotalJumlah=Jumlah2.sum;
});
//setMessage(TotalJumlah.toString(), context);
setMessage(TotalJumlah.toString(), context);

}


@override
  void initState() {
   // getRefresh_Rpt_PR(prno!);
    //  Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual(prno!);
      getJumlahTotal();
   // getJumlah(prno!);
  //   final msg=SnackBar(content: Text("Test"));
  //  ScaffoldMessenger.of(context).showSnackBar(msg);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: Text("Purchase Request Report"),
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
      actions: [
        IconButton(onPressed: () {
        
        }, icon: Icon(Icons.preview),
        )
      ],
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
         //ViewPDFIra();
 

      },
      child: Icon(Icons.picture_as_pdf),
      ),
      body: 
           Column(
            children: [
                   getHeader(), 
                    Expanded(
                      flex: 1,
                      child: getDetail_Rpt_PR2()),
                     Expanded(
                      flex: 0,
                      child:
                       Text("Total :" +TotalJumlah.toString()),
                     )
                    
         


                      

            ],
           )
   );
           
              // Table(
              //   children:[
              //   TableRow(
              //     children: [
              //       TableCell(child: getHeader())
              //     ]
              //   ),

              //    TableRow(
              //     children: [
              //      getDetail_Rpt_PR2()
              //     ]
              //   ),
  
              //    TableRow(
              //     children: [
              //       TableCell(child: Text("Total "+TotalJumlah.toString(),textAlign: TextAlign.center,))
              //     ]
              //   )
                   

                
                    
              //   ]
                 
              // ),

              

                
                   
            

      
         
        
    
   
}
 

Widget getHeader(){
  return 
     Container(
      padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black
              ),
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Purchase Request",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),),
                Text("("+prno!+" / " +dept_pr! +" / "+DateFormat("dd-MMM-yyyy").format(DateTime.parse(tgl_pr!))+" )",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),),
              
              ],
            )
         
            );
    
}
 

Widget getDetail_Rpt_PR2(){
  return Consumer<Alldata>(builder:(context, provj, child) {
    return ListView.builder(
      itemCount: provj.data_manual_prglobal.length,
      itemBuilder: (context, i) {
       return Column(
        children: [

          

           Card(
          child: ListTile(
            leading: Text(provj.data_manual_prglobal[i].nama_item!),
            trailing: Text(provj.data_manual_prglobal[i].qty_pr!),
          ),
           )

        ],
       );
    },);
  }
  );
     

}

Widget getDetail_Rpt_PR(String pr_no){
 
return Container(
  //color: Colors.amberAccent,
 decoration: BoxDecoration(
  
 ),
 child: 
 Column(
  children: [
     Expanded(child: 
     RefreshIndicator(
  onRefresh: () => getRefresh_Rpt_PR(pr_no),
  child: FutureBuilder(
    future: Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual(pr_no), 
    builder: (context, snapshot) {
      
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return Center(child: CircularProgressIndicator(),);
        }else
        {
          return Consumer<Alldata>(builder: (context, prov_rpt_pr, child) {
         
            return ListView.builder(
              itemCount: prov_rpt_pr.data_manual_prglobal.length,
              itemBuilder: (context, i) {
               
              
               
                  
                  return   Card(
                   color: Colors.amber,
                   child: 
                   
                   ListTile(
                    leading: Text(prov_rpt_pr.data_manual_prglobal[i].nama_item!+"("+prov_rpt_pr.data_manual_prglobal[i].unit_pr!+")",style: TextStyle(color: Colors.black),), 
                    // title: Text("Title"),
                    //subtitle: Text(TotalJumlah.toString()),
                    trailing: Text(prov_rpt_pr.data_manual_prglobal[i].qty_pr!,style: TextStyle(color: Colors.black),), 
                   ),
                   
                   
                   
                  
                  
                 


                  );
                
     
                   

           
       
                
            },);
          },);
        }
    },
    
    ),
  
  ),
     ),
   
      Text('Total '+TotalSemua.toString()),
  ],
 )

   
 
 );
 

 

}
}

// void _printScreen(statement) async {
//    final Directory? directory;
//     final ByteData fontData =
//         await rootBundle.load('assets/fonts/Outfit/static/Outfit-Regular.ttf');
//     final ttf = pw.Font.ttf(fontData.buffer.asByteData());
//     final image = pw.MemoryImage(
//       (await rootBundle.load('assets/images/logo_text.png'))
//           .buffer
//           .asUint8List(),
//     );
//     try {
//       final doc = pw.Document();
//       doc.addPage(pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           build: (pw.Context context) {
//             return pw.ListView(
//               children: [
//                 pw.Container(
//                   padding: pw.EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: pw.Column(
//                     mainAxisAlignment: pw.MainAxisAlignment.start,
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Image(
//                         image,
//                         width: 120,
//                         fit: pw.BoxFit.contain,
//                       ),
//                       pw.SizedBox(height: 50),
//                       pw.Text(
//                         "${widget.statement.name}",
//                         style: pw.TextStyle(font: ttf),
//                       ),
//                       pw.Text(
//                         "${widget.statement.phone}",
//                         style: pw.TextStyle(font: ttf),
//                       ),
//                       pw.Text(
//                         "${widget.statement.email}",
//                         style: pw.TextStyle(font: ttf),
//                       ),
//                       pw.SizedBox(height: 50),
//                       pw.Row(
//                         children: [
//                           pw.Text(
//                             "${widget.statement.month}",
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 font: ttf,
//                                 fontSize: 20),
//                           ),
//                           pw.SizedBox(width: 10),
//                           pw.Text(
//                             "${widget.statement.year}",
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 font: ttf,
//                                 fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       pw.Text(
//                         "Monthly statement",
//                         style: pw.TextStyle(
//                           font: ttf,
//                           color: PdfColor.fromInt(Colors.grey.value),
//                         ),
//                       ),
//                       pw.SizedBox(height: 30),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Text(
//                             "TOTAL EARNINGS",
//                             style: pw.TextStyle(
//                                 font: ttf,
//                                 color: PdfColor.fromInt(Colors.grey.value),
//                                 fontSize: 30,
//                                 fontWeight: pw.FontWeight.bold),
//                           ),
//                           pw.Text(
//                             "\$${widget.statement.totalEarning}",
//                             style: pw.TextStyle(
//                                 font: ttf,
//                                 fontSize: 30,
//                                 fontWeight: pw.FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       pw.SizedBox(height: 50),
//                       pw.Text(
//                         "Earnings breakdown",
//                         style: pw.TextStyle(
//                           font: ttf,
//                           fontSize: 22,
//                           fontWeight: pw.FontWeight.bold,
//                           decoration: pw.TextDecoration.underline,
//                         ),
//                       ),
//                       pw.SizedBox(height: 30),
//                       pw.Row(
//                         children: [
//                           pw.SizedBox(
//                               width: 120,
//                               child: pw.Text(
//                                 "Moving cost",
//                                 style: pw.TextStyle(font: ttf),
//                               )),
//                           pw.Text("\$${widget.statement.movingCost}"),
//                         ],
//                       ),
//                       pw.Row(
//                         children: [
//                           pw.SizedBox(
//                               width: 120,
//                               child: pw.Text(
//                                 "Travel cost",
//                                 style: pw.TextStyle(font: ttf),
//                               )),
//                           pw.Text("\$${widget.statement.travelCost}"),
//                         ],
//                       ),
//                       pw.Row(
//                         children: [
//                           pw.SizedBox(
//                               width: 120,
//                               child: pw.Text(
//                                 "Service fee",
//                                 style: pw.TextStyle(font: ttf),
//                               )),
//                           pw.Text("\$${widget.statement.serviceFee}"),
//                         ],
//                       ),
//                       pw.Row(
//                         children: [
//                           pw.SizedBox(
//                               width: 120,
//                               child: pw.Text(
//                                 "GST",
//                                 style: pw.TextStyle(font: ttf),
//                               )),
//                           pw.Text("\$${widget.statement.gst}"),
//                         ],
//                       ),
//                       pw.Row(
//                         children: [
//                           pw.SizedBox(
//                               width: 120,
//                               child: pw.Text(
//                                 "Tips",
//                                 style: pw.TextStyle(font: ttf),
//                               )),
//                           pw.Text("\$${widget.statement.tips}"),
//                         ],
//                       ),
//                       pw.Row(
//                         children: [
//                           pw.SizedBox(
//                               width: 120,
//                               child: pw.Text(
//                                 "Refunds",
//                                 style: pw.TextStyle(font: ttf),
//                               )),
//                           pw.Text("\$${widget.statement.refund}"),
//                         ],
//                       ),
//                       pw.SizedBox(height: 50),
//                       pw.Text(
//                         "Total number of jobs completed for the month ${widget.statement.numberOfJobs}",
//                         style: pw.TextStyle(font: ttf),
//                       ),
//                       pw.SizedBox(height: 80),
//                       pw.Text(
//                         "THIS IS NOT AN OFFICIAL INVOICE OR TAX DOCUMENT",
//                         style: pw.TextStyle(
//                           font: ttf,
//                           fontSize: 20,
//                           color: PdfColor.fromInt(Colors.grey.value),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }));

// if (Platform.isIOS) {
//         directory = await getApplicationDocumentsDirectory();
//       } else {
//         directory = await getDownloadsDirectory();
//       }

//       if (directory == null) {
//         CustomSnackbar.showBottom(context, "Document directory not available");
//         return;
//       }
//       String path = directory.path;
//       String myFile =
//           '${path}/Tingsapp-statement-${statement.month}-${statement.year}.pdf';
//       final file = File(myFile);
//       await file.writeAsBytes(await doc.save());
//       OpenFile.open(myFile);
//     } catch (e) {
//       debugPrint("$e");
//       CustomSnackbar.showBottom(context, "$e");
//     }
//   }