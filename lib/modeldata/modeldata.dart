import 'dart:convert';

class Group_Item{

String? id;
String? group_name;

Group_Item({this.id,this.group_name});

factory Group_Item.fromJson(Map<String,dynamic>json)
{
  return Group_Item(
   id:json['id'],
   group_name:json['group_name']
  );
}


}

class Unit_Item{

  String?id;
  String?unit_name;

  Unit_Item({this.id,this.unit_name});

  factory Unit_Item.fromJson(Map<String,dynamic>json)
  {
    return Unit_Item(
      id: json['id'],
      unit_name: json['unit_name']
    );
  }

   

}

class List_MasterBarang{

String?id;
String?kode;
String?nama;
String?barcode;
String?unititem;
String?groupitem;
String?pict_desc;
String?datedoc;
String?notes;

List_MasterBarang({ this.id,this.kode,this.nama,this.barcode,this.unititem,this.groupitem,this.pict_desc,this.datedoc,this.notes});

 factory List_MasterBarang.fromJson(Map<String,dynamic>json)
 {
   return List_MasterBarang(
    id:json['id'],
    kode:json['kode'],
    nama:json['nama'],
    barcode:json['barcode'],
    unititem:json['unititem'],
    groupitem:json['groupitem'],
    pict_desc:json['pict_desc'],
    datedoc:json['datedoc'],
    notes:json['notes'],
   );
 }

}