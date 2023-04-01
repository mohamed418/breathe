class LoginModel {

  late final String message;
  late final String? token;

  LoginModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    token = json['token'];
  }
}