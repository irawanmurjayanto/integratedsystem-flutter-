import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/component/report/rpt_pr_byprno..dart';
import 'package:barcode_inventory_new/component/report/rptscreen.dart';
import 'package:barcode_inventory_new/component/report/rptscreen2.dart';
import 'package:barcode_inventory_new/component/report/rptscreen3.dart';
import 'package:barcode_inventory_new/component/report/webview_pr.dart';
import 'package:barcode_inventory_new/component/report/webview_pr_pdf.dart';
import 'package:barcode_inventory_new/main.dart';
// import 'package:barcode_inventory_new/component/report/rpt_pr_byprno.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';

class PurchaseRequest_form extends StatefulWidget {
  
  final String? tipe;
  final String? pr_no;
  final String? dept_pr;
  final String? tgl_pr;

  
  
  PurchaseRequest_form({Key?key,required this.tipe,required this.pr_no,required this.dept_pr,required this.tgl_pr }):super(key: key);

  @override
  State<PurchaseRequest_form> createState() => _PurchaseRequestListState(tipe:tipe,pr_no:pr_no,dept_pr:dept_pr,tgl_pr:tgl_pr);
}

class _PurchaseRequestListState extends State<PurchaseRequest_form> {

final box=GetStorage();
    
//codenya sama dengan yang diatas, pembedanya di bagian ScanMode
  Future<void> scanBarcodeNormalBarcode() async {
    String barcodeScanRes;
        try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff0000", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
        
        // Provider.of<Alldata>(context,listen: false).Insert_PR_Manual_Barcode(context, barcodeScanRes,_prno_temp.text, _tglpr.text, txttampung_dept!, box.read('u_name'))
        // .then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => 
        // PurchaseRequest_form(tipe: tipe, pr_no: _prno_temp.text, dept_pr: txttampung_dept.toString(), tgl_pr: _tglpr.text)
        // ,))
        // );

        Provider.of<Alldata>(context,listen: false).Insert_PR_Manual_Barcode(context, barcodeScanRes,_prno_temp.text, _tglpr.text, txttampung_dept!, box.read('u_name'))
        .then((value) => 
        
        Navigator.pop(context),
        
        );
         getRefresh_isipr(); 
       
       
    //     setState(() {
    //  // _barcodecode.text = barcodeScanRes;
    //   //_jumlah=1;
    // });
    
    // if (barcodeScanRes.isNotEmpty )
    // {

    //   if (barcodeScanRes!='-1')
    //    {
    // Future.delayed(Duration(milliseconds: 500),(){
    //     ambilHasil(_jumlah.toString(),_scanBarcode);
    //   scanBarcodeNormal();
    //      });

       //dataHeader
      


    //    setState(() {
    //   _barcodecode.text = barcodeScanRes;
    //   _jumlah++;
    // }
    //);

    //    }
    // }
    
   
  }


   Future <void> getScanBarcodeT(String barcodeScanRes) async{
    await  Provider.of<Alldata>(context,listen: false).Insert_PR_Manual_Barcode(context, barcodeScanRes,_prno_temp.text, _tglpr.text, txttampung_dept!, box.read('u_name'));
  }



  @override
  void didChangeDependencies() {
   // setMessage(_prno_temp.text, context);
  //Provider.of<Alldata>(context,listen:false).getDetail_PR_Manual(_prno_temp.text);
    // TODO: implement didChangeDependencies
    getRefresh_isipr();
    super.didChangeDependencies();
  }

  final String?tipe;
  final String? pr_no;
  final String? dept_pr;
  final String? tgl_pr;
  

  _PurchaseRequestListState({required this.tipe,required this.pr_no,required this.dept_pr,required this.tgl_pr});

  final _prno_temp =TextEditingController();
  final _cari_item_pr=TextEditingController();
  final _editQtyPR=TextEditingController();
  final String txttampung_manual_pr="";
  String valtemp_pr="";
  static String idnostr="x";
  String? txttampung_dropdept;
  BuildContext? ctx;
    final _form=GlobalKey<FormState>();
  String? txttampung_dept;
  final _tglpr=TextEditingController();


  setDelete_QtyPR(String idno_pr,String item_desc) async {
  return showDialog(context: context, 
  builder: (context) {
    return AlertDialog(
      actions: [
           Expanded(child:  
           Row(
            children: [
               
                  ElevatedButton(onPressed: () {
             Provider.of<Alldata>(context,listen: false).setDeleteQtyPRByidno(idno_pr)
             .then((value) => getRefresh_isipr());
             Navigator.pop(context);
              
             
           }, child: Row(
            children: [
              Icon(Icons.perm_identity),
              SizedBox(width: 5,),
              Text("Yes ")
            ],
           )),
           SizedBox(width: 2,),

               ElevatedButton(onPressed: () {
                Navigator.pop(context);
           }, child: Row(
            children: [
              Icon(Icons.cancel),
              SizedBox(width: 5,),
              Text("Cancel ")
            ],
           ))   

            ],
           ),     
           ),
       
            
      ],
        content: Text("Delete this "+item_desc+ " ? "),
    );
  },)  ;


  }

  //Edit QTy Pr (jul1124)
  getEditDialog(String idno_pr,String QtyPR,String item_desc) async {

     _editQtyPR.text=QtyPR;   

     return showDialog(context: context, 
       
     builder:(context) {
       return AlertDialog(
       // backgroundColor: Colors.blue,
        shadowColor: Colors.amber,
        iconColor: Colors.white,
        actions: [
         IconButton(onPressed: () {
              Provider.of<Alldata>(context,listen: false).setUpdateQtyPRByidno(idno_pr, _editQtyPR.text);
              Navigator.pop(context);
            }, icon: Icon(Icons.save,size: 40,)),
            SizedBox(width: 10,),
             IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.cancel,size: 40,))
        ],
        title: Text(item_desc+"(idno : "+idno_pr+" )",style: TextStyle(fontSize: 12),),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
         
            child: 
          TextFormField(
            keyboardType: TextInputType.number,
            
          decoration: InputDecoration(
            label: Text("Edit Qty"),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(width: 2,color: Colors.black54,style: BorderStyle.solid)
            )
          ),
          
          autofocus: true,
          controller: _editQtyPR,
         
          onChanged: (value) {
            setState(() {
              _editQtyPR.text=value;
            });
          },
          
        ),
          ),

       
          ],
        )
       );
     },);
  }


  getMsg1() async {

   final snakbar=await SnackBar(content: Text("Departemen must be choosed"));
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);

  }
  
  getRefresh_isipr() async{
    

     await Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual(_prno_temp.text);
        

  }

  getManual_PR() async{
   return showDialog(context: context, 
   
   builder: 
    (context) {
      return  SingleChildScrollView(
      child: 
      
       AlertDialog(
          title: Text("Manual Purchase Request",style: TextStyle(fontSize: 12),),
          content: Column(
              children: [
              TextFormField(
              autofocus: true,
              controller:_cari_item_pr,
              decoration: InputDecoration(
              label:Text("PR Item Search"),  
              hintText: "Item Search",
              
              border: 
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(width: 2,color: Colors.grey,style: BorderStyle.solid)
              )
            
              
            ),
            onChanged: (value) {
              txttampung_manual_pr!=value;
              Provider.of<Alldata>(context,listen: false).List_MasterBaranang(value);
            },
          ),


            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height/2,
                 decoration: BoxDecoration(
                  color: Colors.white70,
                   borderRadius: BorderRadius.circular(2),
                   border: Border.all(width: 2,style: BorderStyle.solid,color: Colors.grey) ,
                ),
                 child: FutureBuilder
                (future: Provider.of<Alldata>(context,listen: false).List_MasterBaranang(txttampung_manual_pr), 
            
            
                 builder: (context, snapshot) {

                  if(snapshot.connectionState==ConnectionState.waiting)
                  {
                      return Center(child: CircularProgressIndicator(),);
                  }else
                  {
                    return Consumer<Alldata>(builder:(context, prov_manual_pr, child) {
                  
                  return ListView.builder(
                    itemCount: prov_manual_pr.listmasterbarangglobal.length,
                    itemBuilder:(context, i) {

                      
                        return InkWell(
                        child: 
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(bottom: 3,top:2,left:2,right:2),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(width: 2,style: BorderStyle.solid)

                          ),
                            child: Row(
                              children: [
                                Text(prov_manual_pr.listmasterbarangglobal[i].nama!,style: TextStyle(color: Colors.white),),
                                
                              ],
                            ),
                        ),
                        onTap: () {

                          // final valid=_form.currentState!.validate();
                          // if (!valid)
                          // {
                          //   setMessage("Departement must be choosed", context);
                          //   return;
                          // }
                          Provider.of<Alldata>(context,listen: false).Insert_PR_Manual(context,_prno_temp.text,prov_manual_pr.listmasterbarangglobal[i].kode!,prov_manual_pr.listmasterbarangglobal[i].nama!, _tglpr.text, "1",prov_manual_pr.listmasterbarangglobal[i].unititem! , txttampung_dept!, box.read('u_name'))
                         .then((value) => getRefresh_isipr()); 
                         Navigator.pop(context);
                         
                       
                         //Provider.of<Alldata>(context,listen:false).getDetail_PR_Manual(_prno_temp.text);
                         //setMessage(idnostr+"-"+prov_manual_pr.listmasterbarangglobal[i].unititem!+"-"+txttampung_dropdept!+"-" , context);
                 //    setMessage(prov_manual_pr.listmasterbarangglobal[i].nama!, context);
                        },
                        );
                  

                  },);
                },);
                  }
                 }
                ),
              ),

            )

              ]
            //Text Search
        
          )
       )
      );
    },
   );
  }



  

    Future <void> getPRNO() async{
    DateTime Tgl=DateTime.now();
    int day=Tgl.day;
    int mt=Tgl.month;
    int yr=Tgl.year;
    int hr=Tgl.hour;
    int mn=Tgl.minute;
    int sc=Tgl.second;
     idnostr=day.toString()+mt.toString()+yr.toString()+hr.toString()+mn.toString()+sc.toString();
       
        
          setState(() {
              _prno_temp.text="";
              valtemp_pr='PR-'+idnostr.toString();
              _prno_temp.text='PR-'+idnostr.toString();
          });
          
       
       
     
       

  }

  getTgl() async{
 DateTime Tgl=DateTime.now();
 final String awal_date=DateFormat("dd-MM-yyyy").format(Tgl);
  _tglpr.text=awal_date;

  }

 @override
  void initState() {

  

if (tipe=='insert')
{

getPRNO();
getTgl();  
//Provider.of<Alldata>(context,listen:false).getDetail_PR_Manual(_prno_temp.text);
}else{
  setState(() {
    _prno_temp.text=pr_no!;
    txttampung_dept=dept_pr!;
    _tglpr.text=DateFormat("dd-MMM-yyyy").format(DateTime.parse(tgl_pr!));
  });


} 


//getRefresh_isipr();
//setMessage(_prno_temp.text, context);


Provider.of<Alldata>(context,listen: false).getList_Dept();
    // TODO: implement initState
    super.initState();
  }

  





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(title: Text("Purchase Request",style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
      actions: [
        IconButton(onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen(pr_no: pr_no!)));
        }, icon: Icon(Icons.print,size: 35,)),



 IconButton(onPressed: () {
         getRefresh_isipr();
        }, icon: Icon(Icons.refresh,size: 35,)),


        //   IconButton(onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePageJ(pr_no: pr_no!)));
        // }, icon: Icon(Icons.picture_as_pdf_rounded,size: 35,)),

        //   IconButton(onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePageJ(pr_no: pr_no!)));
        // }, icon: Icon(Icons.image_sharp,size: 35,)),
      ],
      ),
      
      body:
     
      
       SingleChildScrollView(
    
        //padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
           
              decoration: BoxDecoration(
                
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.white,Colors.blueAccent]),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black,width: 2,style: BorderStyle.solid)

              ),
              child: Column(
                children: [

                    prno_wg(),  
                    SizedBox(height: 5,),
                    Tgl_doc(),
                    SizedBox(height: 5,),
                    DropDept_PR(),
                    SizedBox(height: 5,),
                    
                   


                ],

              ),

            ),
            
            ButtonAdd(),
            SizedBox(height: 5,),
            //getDetail_isipr(valtemp_pr),  
            Detail_PR(valtemp_pr),
          ],
        ),
        
        ),
        

    );
  }


  Widget Detail_PR(String noprtemp){
    return SingleChildScrollView(
      child:
    Container(
           margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
      height:  MediaQuery.of(context).size.height/2,
    //  width: MediaQuery.of(context).size.width/1,
      decoration: BoxDecoration(
         
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12,width: 3)
      ),

      child: FutureBuilder(future: Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual(noprtemp), 
        builder: (context, snapshot) {
          
          if (snapshot.connectionState==ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }else
          {
            return Consumer<Alldata>(builder: (context, prov_detail_pr, child) {
              
              return ListView.builder(
                itemCount: prov_detail_pr.data_manual_prglobal.length,
                itemBuilder: (context, i) {

                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(bottom:2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors:[Colors.white,Colors.white24]),
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(width: 2,style: BorderStyle.solid)
                    ),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: 
                              Container(
                         
                              decoration: BoxDecoration(
                              gradient: LinearGradient(colors:[Colors.brown,Colors.blueGrey]),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1,style: BorderStyle.solid)
                              ),
                                child: Text(prov_detail_pr.data_manual_prglobal[i].nama_item!+" ("+prov_detail_pr.data_manual_prglobal[i].unit_pr!+")"+ " "+valtemp_pr,style: TextStyle(color: Colors.white),),
                              ),

                              ),
                               SizedBox(width: 5),
                               
                            ],
                          ),
                          SizedBox(height:5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(

                                children: [
                                  Icon(Icons.request_quote,size: 30),
                               SizedBox(width:2),
                               Text('Qty :'+prov_detail_pr.data_manual_prglobal[i].qty_pr!),
                               SizedBox(width:15),
                               
                                ],
                              ),

                              Row(
                                
                                 
                                children: [

                                Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(5)
                                ),  
                                child: 
                                IconButton(
                                
                                onPressed:() {
                                 getEditDialog(prov_detail_pr.data_manual_prglobal[i].idno!, prov_detail_pr.data_manual_prglobal[i].qty_pr!, prov_detail_pr.data_manual_prglobal[i].nama_item!);
                               },  
                               
                               
                                icon: Icon(Icons.edit,size: 30),),
                                ),


                               SizedBox(width:15),

                                 Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(5)
                                ),  
                                child: 
                                IconButton(
                                  
                                    onPressed: () {
                                   setDelete_QtyPR(prov_detail_pr.data_manual_prglobal[i].idno!, prov_detail_pr.data_manual_prglobal[i].nama_item!);
                               }
                               
                               , icon: Icon(Icons.delete,size:30),),
                                 )

                                ],
                              )
                               
                              
                             
                            ],  
                          )
                           
                         
                        ],
                      )
                      ,
                  );
                
              },);
            },);
          }

        },)    
            
       


        
         
      
    )
    );
     
  
  }

  Widget ButtonAdd(){
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
      children: [

          
       ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        
                      ),
                      onPressed: 
                      () {
                        
                          if (txttampung_dept==null)
                        {
                            setMessage("Departement must be choosed", context);
                        } else{
                          scanBarcodeNormalBarcode();
                        }


                      }, 
                        
                        
                        child: 
                        Row(
                          children: [
                            Icon(Icons.barcode_reader),
                            
                             SizedBox(width: 5,), 
                          Text("BarcodeRD ",style: TextStyle(color: Colors.white),),
                          ],
                        )
                        
                        ),
        SizedBox(width: 5,),
       ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        
                      ),
                      onPressed: 
                      () {
                         
                        if (txttampung_dept==null)
                        {
                            setMessage("Departement must be choosed", context);
                        } else{
                          getManual_PR();
                        }
                             //getMsg1();
                          
                      }, 
                   
                        
                        child: 
                        Row(
                          children: [
                            Icon(Icons.manage_accounts),
                            
                             SizedBox(width: 5,), 
                          Text("Manual",style: TextStyle(color: Colors.white),),
                          ],
                        )
                        
                        ),
           ]
      )
      
    );
  }

 

  Widget DropDept_PR(){
    return Form(
      key: _form,
    child:
    Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.only(left: 2),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5),
      //   border: Border.all(width:2,color: Colors.orange,style: BorderStyle.solid)
      // ),

      child: Consumer<Alldata>(builder: (context, pr_value, child) {

        return DropdownButtonFormField(
           decoration: InputDecoration(
          label: Text("Departement List",),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(width: 5,color: Colors.yellow,style: BorderStyle.solid)
            
          )
        ),
          hint: Text(tipe=="edit"?dept_pr!:"Name Departement"),
          items: pr_value.deptNameGlobal.map((e) => DropdownMenuItem(
            value: e.dept_name.toString(),
            child: Text(e.dept_name.toString()),
            
            )).toList(),

          validator: (value) {
            if(value!.isEmpty)
            {
              return "Departement mus be choosed";
            }
            return null;
          },   
          
          onChanged: (value) {
            txttampung_dept=value;
          },); 
        
      },),
    ),
    );
  }



  Widget Tgl_doc(){
    return Container(
        

             padding: EdgeInsets.all(3),
       child: TextFormField(
        controller: _tglpr,
        
        decoration: InputDecoration(
          label: Text("PR Date",),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(width: 5,color: Colors.yellow,style: BorderStyle.solid)
            
          )
        ),
        onTap: () async {
          DateTime? pickdate= await 
          showDatePicker(
            context: context, 
            initialDate: DateTime.now(),
            firstDate: DateTime(1920), 
            lastDate: DateTime(2560));
          if (pickdate!=null)
          {
            final String formatdate=DateFormat("dd-MM-yyyy").format(pickdate);
            setState(() {
              _tglpr.text=formatdate;
            });
          }
          
        },

        validator: (value) {
          if (value!.isEmpty)
          {
            return "Date can no null";
          }
          return null;
        },
       ), 
    );
  }

  Widget Form_PR(){
    return Container(
      child: Form(
        key: _form,
        child: 
        
        TextFormField(

        )
      
      ),
    );
  }

  Widget prno_wg(){
    return Container(
      margin: EdgeInsets.only(left: 10),
 
      child: TextField(
        enabled: false,
        controller: _prno_temp,
        onChanged: (value) {
          _prno_temp.text=value;
        },
      
      ),
    );
  }


   
}

 