import 'package:barcode_inventory_new/component/form/masterbarang.dart';
import 'package:barcode_inventory_new/component/list/list_masterbarang.dart';
import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/modeldata/modeldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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
            child: Text("User Name : Irawan",style: TextStyle(color: Colors.white),),
          ),
          //List Menu

          //Menu 1 List Item Master
          Container(
            margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
                border: Border.all(width: 2,style: BorderStyle.solid,color: Colors.orange),
              ),
              child: Row(children: [

                //but 1
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => List_MasterBarang_form()));
                  },
                  child:
                  Row(
                    children: [
                      Icon(Icons.toc,size: 40,),  
                      SizedBox(width: 10,),
                       Text("Item Master",style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(width: MediaQuery.of(context).size.width/3,) 
                    ],
                  )
                 
                ),
               
                
               
              
              
              ],
              
              )

          ),


          //Menu 2 Purchase Request
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
                border: Border.all(width: 2,style: BorderStyle.solid,color: Colors.orange),
              ),
              child: Row(children: [

                //but 1
                InkWell(
                  onTap: () {
                    setMessage("OK", context);
                  },
                  child:
                  Row(
                    children: [
                      Icon(Icons.quora,size: 40,),  
                      SizedBox(width: 10,),
                       Text("Purchase Request",style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(width: MediaQuery.of(context).size.width/3,) 
                    ],
                  )
                 
                ),
               
                
               
              
              
              ],
              
              )

          ),

          //Menu 3 Purchase order
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
                border: Border.all(width: 2,style: BorderStyle.solid,color: Colors.orange),
              ),
              child: Row(children: [

                //but 1
                InkWell(
                  onTap: () {
                    setMessage("OK", context);
                  },
                  child:
                  Row(
                    children: [
                      Icon(Icons.sell,size: 40,),  
                      SizedBox(width: 10,),
                       Text("Purchase Order",style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(width: MediaQuery.of(context).size.width/3,) 
                    ],
                  )
                 
                ),
               
                
               
              
              
              ],
              
              )

          ),

           //Menu 4 Good Receive
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
                border: Border.all(width: 2,style: BorderStyle.solid,color: Colors.orange),
              ),
              child: Row(children: [

                //but 1
                InkWell(
                  onTap: () {
                    setMessage("OK", context);
                  },
                  child:
                  Row(
                    children: [
                      Icon(Icons.fmd_good,size: 40,),  
                      SizedBox(width: 10,),
                       Text("Good Receive",style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(width: MediaQuery.of(context).size.width/3,) 
                    ],
                  )
                 
                ),
               
                
               
              
              
              ],
              
              )

          ),

//Menu 5 Sales Order
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
                border: Border.all(width: 2,style: BorderStyle.solid,color: Colors.orange),
              ),
              child: Row(children: [

                //but 1
                InkWell(
                  onTap: () {
                    setMessage("OK", context);
                  },
                  child:
                  Row(
                    children: [
                      Icon(Icons.point_of_sale_sharp,size: 40,),  
                      SizedBox(width: 10,),
                       Text("Sales Order",style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(width: MediaQuery.of(context).size.width/3,) 
                    ],
                  )
                 
                ),
               
                
               
              
              
              ],
              
              )

          ),

          //Menu 5 Invoice
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
                border: Border.all(width: 2,style: BorderStyle.solid,color: Colors.orange),
              ),
              child: Row(children: [

                //but 1
                InkWell(
                  onTap: () {
                    setMessage("OK", context);
                  },
                  child:
                  Row(
                    children: [
                      Icon(Icons.pin_invoke_outlined,size: 40,),  
                      SizedBox(width: 10,),
                       Text("Invoice",style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(width: MediaQuery.of(context).size.width/3,) 
                    ],
                  )
                 
                ),
               
                
               
              
              
              ],
              
              )

          ),

          
        ]
        ),
    );
  }
}