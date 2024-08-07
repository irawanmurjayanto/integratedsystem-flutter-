import 'dart:convert';

import 'package:barcode_inventory_new/component/list/list_masterbarang.dart';
import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/component/data/server.dart';
import 'package:barcode_inventory_new/modeldata/modeldata.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

//irawanmurjayanto2024/iventorymasterbarangforlosgistiksection

class MasterBarang extends StatefulWidget {
  
  final String? idno;
  final String? kode;
  final String? nama;
  final String? barcode;
  final String? unititem;
  final String? groupitem;
  final String? datedoc;
  final String? notes;
  final String? tipe;
  final String? pict_desc;
   
  MasterBarang({Key?key,required this.idno,required this.tipe,required this.kode,required this.nama,required this.barcode,required this.groupitem,required this.unititem,required this.datedoc,required this.notes,required this.pict_desc}): super(key: key);
//const Homepage2({Key? key,required this.latx,required this.longx,required this.gambar,required this.imeino}) : super(key: key);
  @override
  _MasterBarangState createState() => _MasterBarangState(idno:idno,tipe:tipe,kode:kode,nama:nama,barcode:barcode,groupitem:groupitem,unititem:unititem,datedoc:datedoc,notes:notes,pict_desc:pict_desc);

  //_HomepageState2 createState() => _HomepageState2(latx: latx,longx: longx,gambar: gambar,imeino:imeino);
}

class _MasterBarangState extends State<MasterBarang> {
  final String? idno;
  final String? kode;
  final String? nama;
  final String? barcode;
  final String? unititem;
  final String? groupitem;
  final String? datedoc;
  final String? notes;
  final String? tipe;
  final String? pict_desc;

  _MasterBarangState({required this.idno,required this.tipe,required this.kode,required this.nama,required this.barcode,required this.groupitem,required this.unititem,required this.datedoc,required this.notes,required this.pict_desc});



  //TextController
  final _kode=TextEditingController();
  final _nama=TextEditingController();
  final _unit=TextEditingController();
  final _datedoc=TextEditingController();
  final _Noted=TextEditingController();
  final _barcodecode=TextEditingController();

  //final txttampungunit=TextEditingController();
  //FocusNode
  final _namaNode=FocusNode();
  final _unitNode=FocusNode();
  final _datedocNode=FocusNode();
  final _groupitemnode=FocusNode();
  final _barcodedsp=FocusNode();
  final _unititemnode=FocusNode();
  final _kodenode=FocusNode();




  
@override
 
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
   // id=ModalRoute.of(context)!.settings.arguments as String;
    //tipe=ModalRoute.of(context)!.settings.arguments as String;
    //setMessage(idno!, context);
   // final response=await Provider.of<Alldata>(context).List_MasterBarangById(idno!);
     //   setMessage(groupitem!, context);
  //      setState(() {
  //      _kode.text=kode!;
  //    _nama.text=nama!;
  //    _barcodecode.text=barcode!;    
  //   txttampungunit=unititem;
  //    txttampungroup=groupitem;
  //  // _datedoc.text=DateFormat('dd-MMM-yyyy').format(DateTime.parse(datedoc!) ) ;
  //    _Noted.text=notes!;

  //     });
  
    setState(() {
   
 // _datedoc.text=DateFormat('dd-MMM-yyyy').format(DateTime.parse(datedoc!) ) ;
   

      });
   //setMessage(datedoc!, context);

    super.didChangeDependencies();
  }


  String _scanBarcode = '-';
  String _ambilHasil = '-';
  int _jumlah=0;
  String _jumlah2='';
  static DateTime now1=DateTime.now();
  String formattedDate=DateFormat('dd-MMM-yyyy HH:mm:ss').format(now1);
 
    bool? ukuran5ltr=false;
     bool? ukuran1ltr=false;
    int? selectedOption=1;
  DateTime? setTglNow=DateTime.now();
  final String ambildate=DateFormat("dd-MM-yyyy").format(DateTime.now());

  final _form=GlobalKey<FormState>();
   
 // List<Group_Item> _listgroupitem=[];

String? txttampungroup;
String? txttampungunit;

final ImagePicker picker=ImagePicker();
File? image;



Future takePciture(ImageSource media) async
{
   var chooseimage=await picker.pickImage(source:media,imageQuality: 5,preferredCameraDevice: CameraDevice.front);
  setState(() {
   image=File(chooseimage!.path); 
  });
   
}

Future <void> SaveMaster() async{
  //final isValid=_form.currentState!.validate();
 
   //  setMessage("x", context);
     
    


    //  String baseimage2='';    

 
      // if (image==null)
      // {
      //     baseimage2=pict_desc!;
      // }else
      // {
      // List<int> imageBytes = image!.readAsBytesSync();
      // String baseimage = base64Encode(imageBytes);
      // String baseimage2=baseimage==null?'x':baseimage;
      // }
      
      if (image==null)
      {
        String baseimage2=pict_desc!+'&kosong';
       // setMessage(txttampungroup.toString(), context);
           await Provider.of<Alldata>(context,listen: false).SaveMaster(baseimage2,context,
       _kode.text, _nama.text, _barcodecode.text, txttampungroup.toString(), _datedoc.text, txttampungunit.toString(), _Noted.text);      
       
      } else
      { 
      List<int> imageBytes = image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      String baseimage2=baseimage==null?'x':baseimage;
       await Provider.of<Alldata>(context,listen: false).SaveMaster(baseimage2,context,
      _kode.text, _nama.text, _barcodecode.text, txttampungroup.toString(), _datedoc.text, txttampungunit.toString(), _Noted.text);

      }
  
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => List_MasterBarang_form(),));
  
      
  

 

}
   



  getUpdateData() async{

    //setMessage(groupitem!, context);

    setState(() {
       _kode.text=kode!;
     _nama.text=nama!;
     _barcodecode.text=barcode!;    
    txttampungunit=unititem;
     txttampungroup=groupitem;
     _datedoc.text=DateFormat('dd-MMM-yyyy').format(DateTime.parse(datedoc!) ) ;
     _Noted.text=notes!;

      });
  }

  @override
  void initState() {
   
    Provider.of<Alldata>(context,listen: false).listGroupitem();
    Provider.of<Alldata>(context,listen: false).listUnit();
    getUpdateData();
    
   
   // setMessage(id!, context);
    
    // setState(() {
    //  // _kode.text=ambildate;
    //   _datedoc.text=ambildate;
    // });
    super.initState();
  }

  

  @override
  void dispose() {
    _namaNode.dispose();
    _unitNode.dispose();
    _datedocNode.dispose();
    _groupitemnode.dispose();
    _barcodedsp.dispose();
    _unititemnode.dispose();
    super.dispose();
  } 

 _getFocusFirst(){
  _kodenode.requestFocus();
 }

 Future<void> dataHeader(String company,String tgl) async {
    String barcodeScanRes;
      try {
      barcodeScanRes = await FlutterBarcodeScanner.dataHeader(
           company,tgl);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

   
  }


  Future<void> ambilHasil(String jumlah,String barcode) async {
    String barcodeScanRes;
      try {
      barcodeScanRes = await FlutterBarcodeScanner.ambilHasil(
           jumlah,barcode);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      _jumlah=1;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
      try {
       
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff0000", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

   
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
         _jumlah++;
    });
  }
//codenya sama dengan yang diatas, pembedanya di bagian ScanMode
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
        try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff0000", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

        setState(() {
      _barcodecode.text = barcodeScanRes;
      _jumlah=1;
    });
    
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

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(title: Text("Master Barang",style: TextStyle(color: Colors.white),),
           backgroundColor: Colors.black54,
           foregroundColor: Colors.white,
           
           actions: [
            IconButton(onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MasterBarang(idno: null, tipe: 'edit', kode: null, nama:null, barcode: null, groupitem: 'Item Group Detail', unititem: 'Unit Item Detail', datedoc: '', notes: null, pict_desc: null)));
            }, icon: Icon(Icons.add,size: 30,)),
            
            IconButton(onPressed: () {
             SaveMaster();
           }, icon: Icon(Icons.save))],
           ),
           floatingActionButton: PickBarcode(),
       body: 
       SingleChildScrollView(
       child: 
       Form(
        key: _form,
         child: 
         Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/back2.png'),fit: BoxFit.fill)
          ),
          padding: EdgeInsets.all(10),
             
         child: 

 Column(
          children: [
         //  _getFocusFirst(),
           
            Kode(),
            SizedBox(height: 8,),
            Nama(),
            SizedBox(height: 8,),
            BarcodeCode(),
            SizedBox(height: 8,),
            DropGroupItem(),
            SizedBox(height: 10,),
            getDatePciker(),
            SizedBox(height: 8,),        
            DropUnit(),
             
            SizedBox(height: 10,),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  
                CameraPict(),
                SizedBox(width: 5,),
                Container(
                width: MediaQuery.of(context).size.width/1.6,
                height:MediaQuery.of(context).size.height/6.5,
                child:Noted()      
               ),
           
            //   )
                
              ],
            )
            ,
            
            
          ],
         ) ,

         )
        
       ),    
       )
    );
  }

 

Widget DropUnit(){
  return Consumer<Alldata>(builder: (context, provUnititem, child) {
    return DropdownButtonFormField(
      validator: (value) {
        if(value!.isEmpty)
        {
        return "Unit Item Harus diisi";
      }
        return null;
      },
      focusNode: _unititemnode,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        label: Text("Unit Item"),
        
      ),
      
      hint: Text(tipe=='edit'?unititem!:"Unit Item Detail"),
      items: provUnititem.unitemglobal.map((e) => DropdownMenuItem(
        child: Text(e.unit_name.toString()),
        value: e.unit_name.toString(),)).toList(), 
    onChanged: (value) {
      setState(() {
        txttampungunit=value;
      });
      
    },);
  },);
}

Widget Kode(){
  return Container(
   child: 
    TextFormField(
              autofocus: true,
              focusNode: _kodenode,
              decoration: InputDecoration(
                labelText: "Kode",
                focusColor: Colors.pinkAccent,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                //fillColor: Colors.amberAccent,
                //filled: true,
                ),
              
              controller: _kode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_namaNode);
              },
               validator: (value) {
                 if (value!.isEmpty)
                 {
                  return "Kode Tidak boleh Kosong ";
                       
                 }
                 return null;
               },
            ),
   
 
  );
}

Widget Nama(){
return Container(
  child: 
 TextFormField(
              focusNode: _namaNode,
              decoration: InputDecoration(labelText: "Nama"
              ,
                focusColor: Colors.pinkAccent,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) 
               // fillColor: Colors.amberAccent,
                //filled: true,
              ),
              controller: _nama,
              onFieldSubmitted:(_) {
                FocusScope.of(context).requestFocus(_barcodedsp);
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              
            validator: (value) {
                if (value!.isEmpty)
                {
                  return "Nama tidak boleh kosong";
                }
                return null;
              },
            ),

);
}

  Widget UkuranGalon(){
   
   return Container(
    padding: EdgeInsets.only(left: 30,top: 5,bottom: 5),
    decoration: BoxDecoration(
      border: Border.all(style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(5)
      
    ),
       child: Column(
        children: [
 
          Row(
            children: [
  Text("5 Liter"),
  SizedBox(width: 5,),
          Checkbox(
            
            value: ukuran5ltr, 
            onChanged:<bool> (value) {
           setState(() {
             ukuran5ltr=value;
           });
            },),
            SizedBox(width: 5,),
  Text("1 Liter"),
  SizedBox(width: 5,),

  Checkbox(
            
            value: ukuran1ltr, 
            onChanged:<bool> (value) {
           setState(() {
             ukuran1ltr=value;
           });
            },),
  
                 
            
            ],
          )
        
        ],
       ),
   );
  }

Widget BarcodeCode(){
  return Container(
     child: TextFormField(
      controller: _barcodecode,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusColor: Colors.pinkAccent,
          label: Text("Barcode Code")
        ),
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_groupitemnode);
        },
       validator: (value) {
         if (value!.isEmpty)
         {
          return "Kode Barcode tidak boleh kosong";
         }
         return null;
       }, 
     ),
  );
}
Widget GradeItem(){

  return Container(
    decoration: BoxDecoration(
      border: Border.all(style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      children: [
  
ListTile(
                title: const Text('Grade A'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Grade B'),
                leading: Radio<int>(
                  value: 2,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
              ),
        ]
    )
    );
     
 
 }

Widget PickBarcode(){
  return Padding(
    padding:EdgeInsets.all(5),
    child: FloatingActionButton.small(onPressed: () {
      scanBarcodeNormal();
    },
    child: Container(
      padding: EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(style: BorderStyle.solid)
      ),
      child: Image.asset("assets/images/barcode2.png"),
    )
      
  
    ),
    );
}
  Widget getDatePciker(){
    return Container(
    child: TextFormField(
      focusNode: _datedocNode,
      controller: _datedoc,
      decoration: InputDecoration(
        label: Text("Date Created (dm-mm-yyyy)"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) 
      ),
       onFieldSubmitted: (_) {
         FocusScope.of(context).requestFocus(_unititemnode);
       },
       onTap: () async {
         DateTime? pickkeddate=await showDatePicker(
          context: context, 
          initialDate: DateTime.now(),
          firstDate: DateTime(2020), 
          lastDate: DateTime(2090)
          );
          if (pickkeddate!=null){
            final String formatteddate=DateFormat("dd-MMM-yyyy").format(pickkeddate);
            setState(() {
            _datedoc.text=formatteddate;  
            });
          } 
       
       },
       validator: (value) {
         if (value!.isEmpty)
         {
          return "Date Tidak noleh kosong";
         }
         return null;
       },
    ),
    );
  }


Widget CameraPict(){
  return Container(
    clipBehavior: Clip.antiAlias,
             width: MediaQuery.of(context).size.width/3.6,
                height:MediaQuery.of(context).size.height/6.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
     border: Border.all(style: BorderStyle.solid,color: Colors.black38),
color: Colors.black38
    ),

    
    
       //  clipBehavior: Clip.antiAlias, 
        // width: MediaQuery.of(context).size.width/1,
         child: 
         Padding(padding: EdgeInsets.all(2),
         child: 
           idno==null?(
           image==null?IconButton(onPressed: () {
           takePciture(ImageSource.camera);
         }, icon:Icon(Icons.camera_enhance)):
         
         InkWell(
          onTap: () {
              takePciture(ImageSource.camera);
          },
          child:Image.file(
          fit: BoxFit.fill,
          
          File(image!.path),
          width: 250,
          height: 150,
          
          )
          ,
         )
        
        
         
      
         
         ):
         InkWell(
           onTap: () {
              takePciture(ImageSource.camera);
          },
          child: image!=null?
          Image.file(
          fit: BoxFit.fill,
          
          File(image!.path),
          width: 250,
          height: 150,
          
          ):Image.network(NamaServer.server+'tests/flutter/crude_2/'+ pict_desc!,fit: BoxFit.fill,)
          ,
          
          )
        
         )    
      
  
      
    );
 
}
Widget Noted(){
  return Padding(
    padding: EdgeInsets.all(1),
child: TextFormField(
  decoration: InputDecoration(
    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    focusColor: Colors.pinkAccent,
    label: Text("Notes : "),
    hintText: "Notes" 
  ),

  maxLines: 3,
  
  controller: _Noted,
  onChanged: (value) {
    setState(() {
      _Noted.text=value;
    });
  }, 
  

  

),

  );
}
 

Widget DropGroupItem(){
 return  Consumer<Alldata>(builder:(context, prov, child) {
   
   return Container(
child: DropdownButtonFormField(
  focusNode: _groupitemnode,
  decoration: InputDecoration(
    label: Text("Item Group"),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) 
  ), 
  hint: Text(tipe=='edit'?groupitem!:"Item Group Detail"),
  items: prov.groupitemglobal.map((e) => DropdownMenuItem(
    child: Text(e.group_name.toString()),
    value: e.group_name.toString(),)).toList(), 
  validator: (value) {
    if (value!.isEmpty){
      return "Data tidak boleh kosong";
    }
    return null;
  },
  onChanged: (value) {
  txttampungroup=value;  
  },),
  
   );
    

 },);
  
}

}
