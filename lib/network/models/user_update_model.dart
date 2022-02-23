class UserUpdateModel {
  String? name;
  String? job;

  UserUpdateModel({this.name, this.job});

  UserUpdateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['job'] = job;
    return data;
  }
}
