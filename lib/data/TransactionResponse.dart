class TransactionResponse {
  int id;
  num amount;
  num discount;
  num finalAmount;
  num adminShare;
  num adminAmount;
  String code;
  String istDate;
  String custName;
  Customer customer;

  TransactionResponse(
      {this.id,
      this.amount,
      this.discount,
      this.finalAmount,
      this.adminShare,
      this.adminAmount,
      this.code,
      this.istDate,
      this.custName,
      this.customer});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    discount = json['discount'];
    finalAmount = json['final_amount'];
    adminShare = json['admin_share'];
    adminAmount = json['admin_amount'];
    code = json['code'];
    istDate = json['ist_date'];
    custName = json['cust_name'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['final_amount'] = this.finalAmount;
    data['admin_share'] = this.adminShare;
    data['admin_amount'] = this.adminAmount;
    data['code'] = this.code;
    data['ist_date'] = this.istDate;
    data['cust_name'] = this.custName;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}

class Customer {
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

  Customer(
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

  Customer.fromJson(Map<String, dynamic> json) {
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
