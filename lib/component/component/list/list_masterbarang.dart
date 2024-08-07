import 'package:barcode_inventory_new/component/form/masterbarang.dart';
import 'package:barcode_inventory_new/component/message/getwarning.dart';
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class List_MasterBarang_form extends StatefulWidget {
  const List_MasterBarang_form({super.key});

  @override
  State<List_MasterBarang_form> createState() => _List_MasterBarangState();
}

class _List_MasterBarangState extends State<List_MasterBarang_form> {

  Future <void> _refreshMasterBarang() async{
    await Provider.of<Alldata>(context,listen: false).List_MasterBaranang(carikata);
  }

  final String id="1";
  final String tipe="edit";
  final String carikata="";
    final _cari=TextEditingController();
    final _carinode=FocusNode();
 
 @override
  void didChangeDependencies() {
   // setMessage("Didchange", context);
   // _refreshMasterBarang();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

   @override
  void initState() {
    _refreshMasterBarang();
    // TODO: implement initState
    //Provider.of<Alldata>(context,listen: false).List_MasterBaranang(carikata);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Item Master List",style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.black54,
              foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => MasterBarang(idno: null, tipe: 'edit', kode: null, nama: null, barcode: '', groupitem: 'Item Group Detail', unititem: 'Unit Item Detail', datedoc: '', notes: '', pict_desc: null)));
          }, icon: Icon(Icons.add))
        ],
      ),
      
      
      body: SingleChildScrollView(
   child: 


 Container(
  height: MediaQuery.of(context).size.height/1,
decoration: BoxDecoration(
  image: DecorationImage(image: AssetImage("assets/images/back1.png"),fit: BoxFit.fill)
),
child: Column(
  children: [
Cari_ItemMasterBarang(),    
SizedBox(height: 10,),
refresh_datamastbarang(),
  ],
),
 ),
 

    
      )
    );
  }

Widget refresh_datamastbarang(){

return SingleChildScrollView(

child: 

Container(
height: MediaQuery.of(context).size.height/1.2,
 
child: 

RefreshIndicator(
        onRefresh: () => _refreshMasterBarang(),
        child: FutureBuilder(
          future: Provider.of<Alldata>(context,listen: false).List_MasterBaranang(carikata), 
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return CircularProgressIndicator();
            }else{
              return  Consumer<Alldata>(builder: (context, item, child) {
                return ListView.builder(
                  itemCount: item.listmasterbarangglobal.length,
                    itemBuilder: (context, i) {
                      
                      return Container(
                        
                        
                        margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                         // image: DecorationImage(image: AssetImage('assets/images/listdata.png'),fit: BoxFit.cover),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white,Colors.grey]
                          ),
                        
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.orange,width: 2,style: BorderStyle.solid),
                        ),
                       child:InkWell(
                        splashColor: Colors.pink,  
                        onTap: () {
                        // setMessage(item.listmasterbarangglobal[i].id!, context);
                        //Navigator.pushNamed(context,'/AddMasterBarang',);
                       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MasterBarang(idno:item.listmasterbarangglobal[i].id!,kode:item.listmasterbarangglobal[i].kode!,nama:item.listmasterbarangglobal[i].nama!, tipe: 'edit'),));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MasterBarang(idno: item.listmasterbarangglobal[i].id!, tipe: 'edit', kode: item.listmasterbarangglobal[i].kode!, nama: item.listmasterbarangglobal[i].nama!, barcode: item.listmasterbarangglobal[i].barcode!, groupitem: item.listmasterbarangglobal[i].groupitem!, unititem: item.listmasterbarangglobal[i].unititem!, datedoc:item.listmasterbarangglobal[i].datedoc!, notes: item.listmasterbarangglobal[i].notes!,pict_desc:item.listmasterbarangglobal[i].pict_desc!)));
                        // Text(item.groupitemglobal[i].group_name.toString());
                         
                        },
                        // onTapDown: (details) {
                        //   setMessage(item.groupitemglobal[i].group_name.toString(), context);
                        // },
                    child: 
                       
                       Row(
                        
children: [
      
 Text(item.listmasterbarangglobal[i].kode!,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
 //jump to 2nd column
 SizedBox(width: 10),

Container(
  padding: EdgeInsets.all(5),
  margin: EdgeInsets.only(left: 0),
  child: Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(item.listmasterbarangglobal[i].nama!+"("+item.listmasterbarangglobal[i].unititem!+")",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
 
 
 
    ],
  ),
)
]
 
                       )
                        
                       )                      
                           

                      );
                },);
              },);
            }

          },)
      )
)
);

}  

Widget Cari_ItemMasterBarang(){
     
  return Container(
    margin: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 10),
    // padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage("assets/images/sch1.png"),fit: BoxFit.cover),
    // gradient: LinearGradient(
    //   begin: Alignment.centerLeft,
    //   end: Alignment.bottomRight,
    //   colors: [Colors.white,Colors.cyan])
     ),
    child: Form(child: 
    
    TextFormField(
      autofocus: true,
      focusNode: _carinode,
      keyboardType: TextInputType.text,
      
      decoration: InputDecoration(
        
        label: Text("Item Master Search",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
      ),
      controller: _cari,
      onChanged: (value) {
        _cari.text=value;
        carikata!=value;
        Provider.of<Alldata>(context,listen: false).List_MasterBaranang(value);
      },
    ),
    )
  );
 }


}