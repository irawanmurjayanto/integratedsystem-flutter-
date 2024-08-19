import 'package:barcode_inventory_new/component/form/masterbarang.dart';
import 'package:barcode_inventory_new/component/form/pos.dart';
import 'package:barcode_inventory_new/component/list/list_masterbarang.dart';
import 'package:barcode_inventory_new/component/list/list_purchaseorder.dart';
import 'package:barcode_inventory_new/component/list/list_purchaserequest.dart';
import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/login.dart';
import 'package:barcode_inventory_new/modeldata/modeldata.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  // getSession() async {
  //   await GetStorage.init();
  // }

  final box=GetStorage();
  // @override
  // void initState() {
  //   //getSession();
  //   // TODO: implement initState
  //   super.initState();
  // }


  getAnnoucement() async{
    Timer.periodic(new Duration(seconds: 150), (timer) {
   debugPrint(timer.tick.toString());
   Provider.of<Alldata>(context,listen: false).getMsgAnc();
});
  }

  
  @override
  void initState() {
    //getAnnoucement();
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
  ]);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width:  MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image:AssetImage("assets/images/back1.png"),fit: BoxFit.fill),
      ),
      child: Column(
        children: 
        [
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 5),
            padding: EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
              border:Border(left: BorderSide(width: 5,color:Colors.grey),
              bottom: BorderSide(width: 5,color:Colors.grey),
              top: BorderSide(width: 5,color:Colors.grey),
              right: BorderSide(width: 5,color:Colors.grey),
              ),
            ),
            child: Text("User Name : "+box.read('u_name'),style: TextStyle(color: Colors.white),),
          ),
          //List Menu
           
         
          //box besar menu
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1,style: BorderStyle.solid),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 3
                )
              ]
            ),

            child:SingleChildScrollView(
            //menu detailly
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 
                 //menu line 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  InkWell(
                  child:     
                  Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu1.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Item Master",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),
                  onTap: () {
                     Navigator.push(context,MaterialPageRoute(builder: (context) => List_MasterBarang_form()));
                  },
                  ),


                    //menu Purchase Request
                InkWell(
                  child: 
                   
                Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu2.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Purchase Request",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => List_PurchaseRequest_form(),));
                  },
                  ),

                    
                    //menu Purchase Order
                InkWell(
                  child:     
                Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu3.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Purchase Order",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),
                  onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => List_PurchaseOrder(),));
                  },
                ), 
                     
                    //menu Good Receive
                Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu4.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Good receive",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  ))  

                  ],
                ) , 
            
                 

                  SizedBox(height: 10,),

                     //menu line2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                            Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu5.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Output",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),


                    //menu Purchase Request
                Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu6.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Sales Order",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),


                    
                    //menu Return
                Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu7.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Return",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),

                     
                    //menu Transfer
                Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu8.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("Transfer",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),  


                
                  ],
                ),

                 SizedBox(height: 10,),

                Row(
                 children: [
                  InkWell(

                  child: 
                    Container(
                   
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [          
                      Image.asset("assets/images/menu9.png",scale: 2.8,fit: BoxFit.cover,),
                      SizedBox(height: 5,),
                       Text("POS",style: TextStyle(fontSize: 6,fontWeight: FontWeight.bold),),  
                    ],
                  )),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => POS_Sales(),));
                  }, 
                  ),
                 ],   

                )  
               
                       //menu POS
               

              ],
            ),
            ),
          ),
           
          


           SizedBox(height: 10)  ,

            //annoucement

           Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 150,


            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1),

            ),
            child: 
            Column(
              children: [
                SizedBox(height: 5,),
                Container(                  
                  child: Text('Announcement'),
                ),

                Container(  
                  width: double.infinity,
                  height: 90, 
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(style: BorderStyle.solid,width: 1)
                  ),               
                  child: getMsg_Anc()
                )

              ],
            ),
           ), 

            SizedBox(height: 20,)  ,

          Container(
            width: 200,
            child: 
            
            ElevatedButton(onPressed: () {
                 box.remove('u_name');
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
               }, child:
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 5,),
                  Text("Log Out",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                ],
               ))
          ),
          SizedBox(height: 10,),

           

        ]
        ),
    );
  }

  Widget getMsg_Anc(){
    return Container(
      child: 
      FutureBuilder(future: Provider.of<Alldata>(context,listen:false).getMsgAnc(),
       builder: (context, snapshot) {
         if (snapshot.connectionState==ConnectionState.waiting)
         {
          return Center(child: CircularProgressIndicator(),);
         }else
         {
          return Consumer<Alldata>(builder: (context, prov_getmsg_anc, child) {

            return ListView.builder(
              itemCount: prov_getmsg_anc.getmsganc_global.length,
              itemBuilder: (context, i) {
                return Container
                (  
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prov_getmsg_anc.getmsganc_global[i].tgl_rec!,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                    
                    Text(prov_getmsg_anc.getmsganc_global[i].message!,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                  ],
                ),  
                );
              
            },);
            
          },);
         }
       },
       
       ),
      
    );
  }
}