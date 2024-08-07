
import 'package:barcode_inventory_new/component/form/inventory.dart';
import 'package:barcode_inventory_new/component/form/mainmenu.dart';
import 'package:barcode_inventory_new/component/form/masterbarang.dart';
import 'package:barcode_inventory_new/component/form/report.dart';
import 'package:barcode_inventory_new/component/list/list_masterbarang.dart';
import 'package:barcode_inventory_new/login.dart';
import 'package:barcode_inventory_new/modeldata/modeldata.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  await Permission.storage.request();
  
  runApp(
    MultiProvider(
      providers: [
       ChangeNotifierProvider.value(value:Alldata())
      ],



       
      child:MainApp() ,
      
      )
    
   
    
    
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Login(),
       routes:{
               '/ListMasterBarang':(ctx) => List_MasterBarang_form(), 
                     
       },
       color: Colors.amber,
      
        
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<Widget> _children=[
MainMenu(),
Inventory(),
Report1(),
];

int _currentindex=0;

void onBarTapped(int index){
  setState(() {
    _currentindex=index;
  });
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: () async=> false ,
    
    child:  Scaffold(
      
         appBar: AppBar(title: Text("Main Menu",
         
          style: TextStyle(color: Colors.white),
         ),
           
        //  actions: [IconButton(onPressed: () {
        //     Navigator.push(context,MaterialPageRoute(builder: (context) => MasterBarang(),));
        //  }, icon: Icon(Icons.add))],
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        shadowColor: Colors.cyan,
         ),
      
         body:
             
         
          _children[_currentindex],
         bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          onTap: onBarTapped,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black,
          selectedFontSize: 12,
          items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Home"
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.inventory),
              label: "Inventory"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: "Finance"
                
                )
            
            ]),
        //  body: Container(
        //   height: MediaQuery.of(context).size.height,
        //   //color: Colors.blueAccent,
        //  child: Image.asset("assets/images/back1.png",fit: BoxFit.fill,),  
        //  ),
         drawer: Drawer(
          backgroundColor: Colors.green,
          
            child: ListView(
              padding: EdgeInsets.zero,
              
              children: [
                //UserAccountsDrawerHeader(accountName: Text("Irawan M"), accountEmail:  Text("irawan@gmail.com")),
                AppBar(title: Text("App Bar Menu",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Colors.blue
                 ,),
                
                
                ListTile(
                  leading: Icon(Icons.fmd_good),
                  title: Text("Master Barang",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  onTap: () {
                   //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MasterBarang(),)).then((_) => Navigator.of(context).pop());
                    Navigator.of(context).pop();
                   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => List_MasterBarang_form(),));
                    Navigator.of(context).pushNamed('/ListMasterBarang'); 

                  },
                    
                ),

                ListTile(
                  leading: Icon(Icons.output),
                  title: Text("Output",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  onTap: () {
                    
                  },

                )
              ],
            ),

         )
         
         
       ),
    );
    
   
  }
}
