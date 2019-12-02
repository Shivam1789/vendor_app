class ImageList {
  int id;
  int userId;
  int type;
  String image;
  int status;
  String createdAt;
  String updatedAt;

  ImageList(
      {this.id,
        this.userId,
        this.type,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  ImageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
