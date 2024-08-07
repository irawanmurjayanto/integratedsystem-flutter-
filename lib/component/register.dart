import 'package:barcode_inventory_new/component/data/seriapp.dart';
import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';

class LoginReg extends StatefulWidget {
  const LoginReg({super.key});

  @override
  State<LoginReg> createState() => _LoginRegState();
}



class _LoginRegState extends State<LoginReg> {

  final _user=TextEditingController();
  final _pass=TextEditingController();
  final _form=GlobalKey<FormState>();
  bool passWordVisible=false;
  String? _tampungDept;
  bool _isvalid=false;
  String _errorMessage='';

 

@override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }

  @override
  void initState() {
    Provider.of<Alldata>(context,listen:false).getList_Dept();
    passWordVisible=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (

        
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
              SizedBox(height: 55,),
              Text("Integrated System " + SeriApp.seriapp,style: TextStyle(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),

              //box user/password
              Container(
                  margin:EdgeInsets.all(30),
                height: MediaQuery.of(context).size.height/1.8,
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
                    Text("Registration Form",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
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

                    DropDept(),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                       children: [

                        ElevatedButton(onPressed: () {    

                          setState(() {
                            _isvalid=validationPassword(_pass.text);
                          });

                         if (_isvalid)
                          {   
                             if (_user.text.isEmpty)
                             {
                              setMessage("User Name must be filled", context) ;   
                             }  
                             else if(_pass.text.isEmpty)
                             {
                              setMessage("Password must be filled", context) ;     
                             }
                             else if (_tampungDept==null)
                             {
                              setMessage("Departement must be choosed", context) ; 
                             }else
                             {  
                              Provider.of<Alldata>(context,listen: false).setUserPass(context,_user.text, _pass.text, _tampungDept!);
                             }
                          }else{
                             setMessage(_errorMessage, context);
                          }
                    }, child: Text("Submit")),

                  
                    
                    

                       ],
                    ),
                     //_isvalid?Text('Password is Valid'):Text('Invalid Password'+ _errorMessage)
                  ],
                ),
              ),
              SizedBox(height: 30,),
              //copy right
              Text("@PT Paradise 2024")

            ],
          )

    
    // )
    ),
    ),
    );
  }



Widget DropDept() {
  return Container(
    // decoration: BoxDecoration(
    //   border: Border.all(style: BorderStyle.solid,width: 1),
    //   borderRadius: BorderRadius.circular(10),
    // ),
    padding: EdgeInsets.all(5),

    child: Consumer<Alldata>(builder: (context, prov_reg, child) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1,style: BorderStyle.solid)
            )
        ),
        hint: Text("Departement",style: TextStyle(decoration: TextDecoration.none),),
        items: prov_reg.deptNameGlobal.map((e) => 
        DropdownMenuItem(
          child:Text(e.dept_name.toString(),style: TextStyle(decoration: TextDecoration.none),),
          value: e.dept_name.toString(),
           )).toList(), 
        onChanged: 
        (value) {
          setState(() {
            _tampungDept=value;
          });
        },
        
        );
    },)
     
  );
}  

Widget FormTengah(){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(style: BorderStyle.solid,width: 2,color: Colors.black54),
      borderRadius: BorderRadius.circular(5)
      
    ),
    child: Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "User Name",
            label: Text("UserName")
          ),
          controller: _user,
        ),

         TextField(
          decoration: InputDecoration(
            labelText: "Password",
            label: Text("Password")
          ),
          keyboardType: TextInputType.visiblePassword,
          controller: _pass,
        ),

      ],
    ),
  );
}

Widget ButLogin(){
  return Padding(padding: 
  EdgeInsets.all(5),
   child: 
   ElevatedButton(onPressed: 
   () {
     
   },
   child:Row(children: [Icon(Icons.login),SizedBox(width:5),Text("Login")],))
   ,
  );
}
 

  Widget User_Name(){
    return Container(
      padding: EdgeInsets.all(5),
      child: 
      TextFormField(
        controller: _user,
        autofocus: true,
        decoration: InputDecoration(
          labelText: "User Name",
          hintText: "User Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(style: BorderStyle.solid,width: 1,color: Colors.black)
          )

        ),
      ),
    );
  
  }



  Widget Password(){
    return Container(
      padding: EdgeInsets.all(5),
      child: 
      TextFormField(
        controller: _user,
        autofocus: true,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(style: BorderStyle.solid,width: 1,color: Colors.black)
          )

        ),
      ),
    );
  
  }




bool validationPassword(String password){
    _errorMessage='';
   
 // Password length greater than 6 
    if (password.length <6) { 
      _errorMessage += 'Password must be longer than 6 characters.\n'; 
    } 

    // Contains at least one uppercase letter 
    if (!password.contains(RegExp(r'[A-Z]'))) { 
      _errorMessage += 'Uppercase letter is missing.\n'; 
    } 
  
    // // Contains at least one lowercase letter 
    // if (!password.contains(RegExp(r'[a-z]'))) { 
    //   _errorMessage += '• Lowercase letter is missing.\n'; 
    // } 
  
    // // Contains at least one digit 
    // if (!password.contains(RegExp(r'[0-9]'))) { 
    //   _errorMessage += '• Digit is missing.\n'; 
    // } 
  
    // // Contains at least one special character 
    // if (!password.contains(RegExp(r'[!@#%^&*$(),.?":{}|<>]'))) { 
    //   _errorMessage += '• Special character is missing.\n'; 
    // } 
  

  return _errorMessage.isEmpty;

}  


  }   
  
