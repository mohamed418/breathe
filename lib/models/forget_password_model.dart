class ForgetPasswordModel {
  late final String message;

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
