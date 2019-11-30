class Resp {


  String username;

  Resp( this.username);

  Resp.fromJson(Map<String, dynamic> json) {

    username = json["username"];

  }

  Map toJson() {
    return {

      "username": username,
    };

  }

}