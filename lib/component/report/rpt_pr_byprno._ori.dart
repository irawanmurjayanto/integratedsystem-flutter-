// import 'dart:html';

import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

 

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: Text("Purchase Request Report"),
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
      
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
        
      },
      child: Icon(Icons.picture_as_pdf),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
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
         
            ),
            SizedBox(height: 10,),
            //colum header
        
            // Table(
            //     border: TableBorder.all(),
            //     children: [
            //       TableRow(
            //          children: [
            //           TableCell(child: Center(child: Text("No"),)),
            //           TableCell(child: Center(child: Text("Kode"),)),
            //           TableCell(child: Center(child: Text("Item Desc."),)),
            //           TableCell(child: Center(child: Text("Qty"),)),
            //          ]
            //       )
            //     ],
            // )
            getDetail_Rpt_PR(prno!),
           
             
            
   DefaultTextStyle.merge(style:
                      TextStyle(fontSize: 16), 
                      child: 
                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total"),
                        Text(
                          "Total Cost : 3000",
                        ),
                      ],
                    ),         
                
               )
              

                 
          ],

        ),
      ),
    );
}
Widget getDetail_Rpt_PR(String pr_no){
return  SingleChildScrollView(
  //height: MediaQuery.of(context).size.height,
  // height: double.minPositive,
  // width: double.infinity,
  // padding:EdgeInsets.all(5),
 child: 
 
 

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
                  
                  return  Table(
                      
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(children: [
                          Text(prov_rpt_pr.data_manual_prglobal[i].nama_item!+"("+prov_rpt_pr.data_manual_prglobal[i].unit_pr!+")",style: TextStyle(color: Colors.black),),
                          Text(prov_rpt_pr.data_manual_prglobal[i].qty_pr!,style: TextStyle(color: Colors.black),),
                        ]),
                        
                      ],

                  );
                    //  ListTile(
                    //   leading: Text(prov_rpt_pr.data_manual_prglobal[i].nama_item!+"("+prov_rpt_pr.data_manual_prglobal[i].unit_pr!+")",style: TextStyle(color: Colors.white),),
                    //   title: Text("Quantity :"+prov_rpt_pr.data_manual_prglobal[i].qty_pr.toString(),style: TextStyle(color: Colors.white),),
                    //  ) ;  
                    
                    
                    //header item

                    
                    // Container(
                    //     height: 200,
                    //     padding: EdgeInsets.all(5),
                    //     margin: EdgeInsets.only(left: 5,right: 5,top: 5),
                    //      width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       color: Colors.blue,

                    //     ),
                    //     child: Text(prov_rpt_pr.data_manual_prglobal[i].nama_item!+"("+prov_rpt_pr.data_manual_prglobal[i].unit_pr!+")",style: TextStyle(color: Colors.white),),
                    //   ),
                    //   Container(
                    //    height: 200,
                    //     padding: EdgeInsets.all(5),
                    //     margin: EdgeInsets.only(left: 5,right: 5),
                    //      width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       color: Colors.black54,

                    //     ),
                    //     child: Text("Quantity :"+prov_rpt_pr.data_manual_prglobal[i].qty_pr.toString(),style: TextStyle(color: Colors.white),),
                    //   ),

                 



                
     
                   

           
       
                
            },);
          },);
        }
    },
    
    ),
  
  ),
 

 
);
 

}
}
