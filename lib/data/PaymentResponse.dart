class PaymentResponse {
  List<Result> result = new List();
  num pending;

  PaymentResponse({this.result, this.pending});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['pending'] = this.pending;
    return data;
  }
}

class Result {
  int id;
  int userId;
  int amount;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  String istDate;

  Result(
      {this.id,
      this.userId,
      this.amount,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.istDate});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    istDate = json['ist_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ist_date'] = this.istDate;
    return data;
  }
}
