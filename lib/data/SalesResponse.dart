class SalesResponse {
  Data data;

  SalesResponse({this.data});

  SalesResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  num remainPoint;
  num amount;
  User user;
  num disc;
  num finalAmount;
  bool flag;
  num points;
  num adminAmount;
  num adminShare;

  Data(
      {this.remainPoint,
        this.amount,
        this.user,
        this.disc,
        this.finalAmount,
        this.flag,
        this.points,
        this.adminAmount,
        this.adminShare});

  Data.fromJson(Map<String, dynamic> json) {
    remainPoint = json['remain_point'];
    amount = json['amount'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    disc = json['disc'];
    finalAmount = json['final_amount'];
    flag = json['flag'];
    points = json['points'];
    adminAmount = json['admin_amount'];
    adminShare = json['admin_share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remain_point'] = this.remainPoint;
    data['amount'] = this.amount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['disc'] = this.disc;
    data['final_amount'] = this.finalAmount;
    data['flag'] = this.flag;
    data['points'] = this.points;
    data['admin_amount'] = this.adminAmount;
    data['admin_share'] = this.adminShare;
    return data;
  }
}

class User {
  int id;
  String name;
  String phone;
  String email;
  int state;
  int city;
  String address;
  String code;
  double points;
  int createdBy;
  String createdAt;
  String updatedAt;
  int status;
  String deletedAt;
  int parent;
  String dob;

  User(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.state,
        this.city,
        this.address,
        this.code,
        this.points,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.deletedAt,
        this.parent,
        this.dob});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    code = json['code'];
    points = json['points'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    parent = json['parent'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address'] = this.address;
    data['code'] = this.code;
    data['points'] = this.points;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['parent'] = this.parent;
    data['dob'] = this.dob;
    return data;
  }
}