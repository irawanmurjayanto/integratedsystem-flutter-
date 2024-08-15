import 'package:barcode_inventory_new/component/form/purchaserequest.dart';
 
import 'package:barcode_inventory_new/provider/alldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class List_PurchaseRequest_form extends StatefulWidget {
  const List_PurchaseRequest_form({super.key});

  @override
  State<List_PurchaseRequest_form> createState() => _List_PurchaseRequest_formState();
}

class _List_PurchaseRequest_formState extends State<List_PurchaseRequest_form> {
  final _carikata=TextEditingController();
  final String _texttampung_carikata="";

  Future <void> getRefresh() async{
   await Provider.of<Alldata>(context,listen:false).getDetail_List_PR(_texttampung_carikata);
  }
  
  @override
  void didChangeDependencies() {
  // Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual("");  
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  
  @override
  void initState() {
    getRefresh();

    //refresh data pr form
    Provider.of<Alldata>(context,listen: false).getDetail_PR_Manual("");
    // TODO: implement initState
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Purchase Request List",style: TextStyle(fontSize: 16,color: Colors.white),),
       backgroundColor: Colors.black54,
       foregroundColor: Colors.white,
       actions: [IconButton(onPressed: () {
       
        Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseRequest_form(tipe: "insert", pr_no: "",dept_pr: "",tgl_pr: ""),));
         //Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseRequest_form2(),));
       }, icon: Icon(Icons.add))],
       ),
       
      body: 
      SingleChildScrollView(
         
      child: 
      Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/back1.png"),fit: BoxFit.fill)
      ),  
      child: 
      Column(
        children: [ 
           SizedBox(height: 5,),
           EditSearch(_carikata),
           SizedBox(height: 5,),
           List_Detail_PR(), 




          

        ],
      ), 
        ),
      ),
      );
  }

  Widget List_Detail_PR(){
    return SingleChildScrollView(
          child:Container(
             height: MediaQuery.of(context).size.height/1.4, 
          child: RefreshIndicator( 
            onRefresh: () => getRefresh(),
            child: FutureBuilder(future: 
            Provider.of<Alldata>(context,listen:false).getDetail_List_PR(_texttampung_carikata), 
            builder: 
            (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else{
                return Consumer<Alldata>(builder: (context, prov_list_pr, child) {
                  return ListView.builder(
                    itemCount: prov_list_pr.list_pr_detailglobal.length,
                    itemBuilder:  (context, i) {

                      return Container(
                        
                           margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
                        padding: EdgeInsets.only(left: 5,top:5,bottom: 5),
                        decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid,width: 1,color: Colors.black54),
                          borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white,Colors.white]
                          ),
                            
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                           children: [

                             //Line 1 pr no
                             Row(
                              crossAxisAlignment: CrossAxisAlignment.start,  
                             // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               //header
                                Container(
                                
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                padding:EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
                                
                                child:Text('PR NO : ',style: TextStyle(color: Colors.white),),  
                              ),

                              SizedBox(width:3),
                              //pr-no  
                              Expanded(child: 
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                padding:EdgeInsets.only(top: 5,left: 5,bottom: 5),
                                
                                child:Text(prov_list_pr.list_pr_detailglobal[i].pr_no!,style: TextStyle(color: Colors.white),),  


                              ),
                              ),

                                SizedBox(width: 5,),
                                //date
                              

                              ]
                             ),

                              SizedBox(height:7),

                              Container(//global cont for dept plus dept
                                 margin: EdgeInsets.only(right: 5), 
                                 padding: EdgeInsets.only(bottom: 5,top: 5,left:5),
                                decoration: BoxDecoration(
                                // image: DecorationImage(image: AssetImage("assets/images/listdata.png"),fit: BoxFit.fill), 
                                  //  gradient: LinearGradient(
                                  //   begin: Alignment.bottomLeft,
                                  //   end: Alignment.topRight,
                                  //   colors: [Colors.white,Colors.blueGrey]),
                                  borderRadius: BorderRadius.circular(5)
                                ),

                                child: 
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [    
                              

                              Column(
                              //  mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  
                                Container(
                                padding:EdgeInsets.all(5),
                               // color: Colors.blue,  
                                child:Text(DateFormat('dd-MMM-yyyy').format(DateTime.parse(prov_list_pr.list_pr_detailglobal[i].tgl_pr!)),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight:FontWeight.bold),),  
                              ),

                               SizedBox(width:3),
                               //dept
                                Container(
                                padding:EdgeInsets.all(5),
                               // color: Colors.blue,
                                child:Text(prov_list_pr.list_pr_detailglobal[i].dept_pr!,style: TextStyle(color: Colors.black),),  
                              ), 
                                ]
                              ),

                              //icon button line 2
                               SizedBox(width: 10,) ,
                              Row(
                               
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [

                                    //icon button
                                Container(
                                  
                                    decoration: BoxDecoration(
                                      border: Border.all(style: BorderStyle.solid,width: 1,strokeAlign: BorderSide.strokeAlignCenter),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),                         
                                  //padding: EdgeInsets.all(5),
                                  child: 
                                   IconButton(onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseRequest_form(tipe: "edit", pr_no: prov_list_pr.list_pr_detailglobal[i].pr_no!,dept_pr:prov_list_pr.list_pr_detailglobal[i].dept_pr!,tgl_pr: prov_list_pr.list_pr_detailglobal[i].tgl_pr!,)));
                                  }, icon: Icon(Icons.edit)),
                              
                            
                                ),

                                  SizedBox(width: 10,),  
                                  
                                  Container(
                                    decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width:1),
                                  borderRadius: BorderRadius.circular(10)
                                ),                         
                                  //padding: EdgeInsets.all(5),
                                  child: 
                                   IconButton(onPressed: () {
                                    
                                  }, icon: Icon(Icons.delete)),
                              
                            
                                ),

                                ],
                              )



                              ]
                              )
                                
                                
                            )//line 2 date plus dept global
                                 
                              

                             
                           ], 
                        ),
                      );
                    
                  });
                  
                },);
              }
            },
            ),
            )
           
          ),
        
    );
  }

  Widget EditSearch(TextEditingController CariKata){
    return Container(//padding: EdgeInsets.all(2),
    
    margin: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 10),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/sch1.png"),fit: BoxFit.cover),
        gradient: LinearGradient(colors:[Colors.white,Colors.cyan])
      ),
      child:  Form(child: TextFormField(
        autofocus: true,
        controller: CariKata,
        decoration: InputDecoration(
          fillColor: Colors.amberAccent,
          border: OutlineInputBorder(      
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(width: 5,color: Colors.black,style: BorderStyle.solid)),
          label: Text("PR NO Search",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
          
        ),
         onChanged: (value) {
           setState(() {
             _texttampung_carikata!=value;
             Provider.of<Alldata>(context,listen: false).getDetail_List_PR(value);
           });
         },
      )
      
      )
    
    );
  }
}