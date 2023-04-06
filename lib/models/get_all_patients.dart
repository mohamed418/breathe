class GetAllPatientsModel {
  late final bool status;
  late final Null message;
  late final List<Patients> patients;

  GetAllPatientsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = null;
    patients = List.from(json['patients']).map((e)=>Patients.fromJson(e)).toList();
  }

}

class Patients {
  late final String fullName;
  late final String gender;
  late final String address;
  late final String mobileNumber;

  Patients.fromJson(Map<String, dynamic> json){
    fullName = json['full_name'];
    gender = json['gender'];
    address = json['address'];
    mobileNumber = json['mobile_number'];
  }
}