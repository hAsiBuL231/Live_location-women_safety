class Users {
  String? securityCode;
  String? email;
  String? name;
  String? phone;
  String? imageUrl;
  String? createTime;
  String? updateTime;

  Users({this.securityCode, this.email, this.name, this.phone, this.imageUrl, this.createTime, this.updateTime});

  Users.fromJson(Map<String, dynamic> json)
      : securityCode = json['name'].split('/').last,
        email = json['fields']['email']['stringValue'],
        name = json['fields']['name']['stringValue'],
        phone = json['fields']['phone']['integerValue'],
        imageUrl = json['fields']['imageUrl']['stringValue'],
        createTime = json['createTime'],
        updateTime = json['updateTime'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': securityCode,
      'fields': {
        if (email != null) 'email': {'stringValue': email},
        if (name != null) 'name': {'stringValue': name},
        if (phone != null) 'phone': {'integerValue': int.parse(phone!)},
        if (imageUrl != null) 'imageUrl': {'stringValue': imageUrl},
      },
      'createTime': createTime,
      'updateTime': updateTime,
    };
    return data..removeWhere((key, value) => value == null);
  }
}
