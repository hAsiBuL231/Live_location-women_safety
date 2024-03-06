import 'package:flutter/material.dart';

class Group {
  String? groupId;
  String? name;
  String? image;
  List<String>? idList;
  String? createTime;
  String? updateTime;

  Group({this.groupId, this.name, this.image, this.idList, this.createTime, this.updateTime});

  Group.fromJson(Map<String, dynamic> json) {
    try {
      groupId = json['name'].split('/').last;
      name = json['fields']['name']['stringValue'];
      image = json['fields']['image']['stringValue'];
      idList = json['fields']['id_list']['arrayValue']['values'].map<String>((value) => value['stringValue'].toString()).toList();
      createTime = json['createTime'];
      updateTime = json['updateTime'];
    } catch (e) {
      print(" \n \n \n Error while parsing JSON for Group: ${e.toString()} \n \n ");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    final Map<String, dynamic> fields = Map<String, dynamic>();
    final Map<String, dynamic> idListMap = Map<String, dynamic>();
    List<Map<String, dynamic>> values = [];

    for (String id in idList!) {
      values.add({'stringValue': id});
    }

    idListMap['arrayValue'] = {'values': values};
    fields['name'] = {'stringValue': name};
    fields['image'] = {'stringValue': image};
    fields['id_list'] = idListMap;
    data['name'] = groupId;
    data['fields'] = fields;
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    return data;
  }
}


