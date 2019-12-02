class NetworkError {
  String status;
  String message;
  String title;

  NetworkError({this.status, this.message,this.title});

  toJson() {
    Map<String, dynamic> json = {
      "status": this.status,
      "message": this.message,
      "title":this.title
    };
    return json;
  }
}
