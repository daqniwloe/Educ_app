class Resp {


  String result;
  String token;

  Resp( this.result, this.token);

  Resp.fromJson(Map<String, dynamic> json) {

    result = json["result"]["token"];
    token = json["token"];
  }

  Map toJson() {
    return {

      "result": result,
      "token": token,
    };

  }

}