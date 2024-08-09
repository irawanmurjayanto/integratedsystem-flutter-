import 'package:barcode_inventory_new/component/data/seriapp.dart';
import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:barcode_inventory_new/register.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:get_storage/get_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}



class _LoginState extends State<Login> {

  final _user=TextEditingController();
  final _pass=TextEditingController();
  final _form=GlobalKey<FormState>();
  bool passWordVisible=false;

  getSession() async{
  await GetStorage.init();
  }

@override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }

  @override
  void initState() {
    getSession();
    passWordVisible=true;
    super.initState();
  }

  final box=GetStorage();

  @override
  Widget build(BuildContext context) {

    
    return WillPopScope( onWillPop:() async=> false,
    
    child:  
     Scaffold (

        
    body: 
   SingleChildScrollView(
      child:Container(
    
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage("assets/images/back1.png"),fit: BoxFit.cover)
      ),

           

          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Integrated System " + SeriApp.seriapp,style: TextStyle(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.bold),),
              SizedBox(height: 55,),

              //box user/password
              Container(
                  margin:EdgeInsets.all(30),
                height: MediaQuery.of(context).size.height/2.2,
                decoration: BoxDecoration(
                  boxShadow: [
                    
                    BoxShadow(offset: Offset(1, 2),
                    blurRadius: 4,
                    spreadRadius: 4,
                    color: Colors.white
                    )
                  
                     
                  
                  
                  ,],
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Colors.white54,Colors.white]),
                  border: Border.all(style:BorderStyle.solid,width: 2,color: Colors.white)
                ),
              
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Login Form",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 15,),
                    TextField(
                      controller: _user,
                      
                      decoration: InputDecoration(
                        labelText: "User Name",
                        
                        border: OutlineInputBorder(borderSide:BorderSide(width: 1,style: BorderStyle.solid,color: Colors.blueAccent)),
                      ),
                    ),
                     SizedBox(height: 15,) ,
                     TextField(
                        
                      //keyboardType: TextInputType.visiblePassword,
                      controller: _pass,
                      obscureText: passWordVisible,
                      
                      decoration: InputDecoration(
                        helperText: "Password must contain Uppercase letter",
                        labelText: "Password",
                         suffixIcon: IconButton(onPressed: 
                         () {
                           setState(() {
                             passWordVisible=!passWordVisible;
                           });
                         }, icon: Icon(passWordVisible?Icons.visibility_off:Icons.visibility)),

                         border: OutlineInputBorder(borderSide:BorderSide(width: 1,style: BorderStyle.solid,color: Colors.blueAccent)),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                     
                        ElevatedButton(onPressed: () {    

                           getStatusInet(context); 
                           Provider.of<Alldata>(context,listen: false).getUserPass(context, _user.text ,_pass.text);  

                    }, child: Text("Submit")),
                    
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => LoginReg(),));
                    }, child: Text('(Register)',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))


                       ],
                    )
                   
                  ],
                ),
              ),
              SizedBox(height: 70,),
              //copy right
              Text("@PT Paradise "+DateFormat('yyyy').format(DateTime.now())),

            ],
          )

    
    // )
    ),
    ),
    ),
    );
    
    
    
  }

 
 
 






  }   
  
