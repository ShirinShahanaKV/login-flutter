class UserModelSignIn {
  String? name;
  String? email;
  String? photourl;
  String? id;

  UserModelSignIn({this.name, this.email, this.photourl, this.id});

  UserModelSignIn.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    photourl = json['photourl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['photourl'] = this.photourl;
    data['id'] = this.id;
    return data;
  }
}