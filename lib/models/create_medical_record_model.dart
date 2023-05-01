class CreateMedicalRecordModel {

  late final String message;

  CreateMedicalRecordModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
  }
}