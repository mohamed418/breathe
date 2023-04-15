class DeletePatientPatientModel {
  late final String success;

  DeletePatientPatientModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
  }
}