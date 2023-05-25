class SearchPatientModel {
  SearchPatientModel({
    required this.status,
    required this.message,
    required this.patients,
  });
  late final dynamic status;
  late final dynamic message;
  late final List<Patients> patients;

  SearchPatientModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    patients =
        List.from(json['patients']).map((e) => Patients.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['patients'] = patients.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Patients {
  Patients({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.address,
    required this.mobileNumber,
    required this.medicalRecords,
  });
  late final dynamic id;
  late final dynamic fullName;
  late final dynamic gender;
  late final dynamic address;
  late final dynamic mobileNumber;
  late final List<MedicalRecords> medicalRecords;

  Patients.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    gender = json['gender'];
    address = json['address'];
    mobileNumber = json['mobile_number'];
    medicalRecords = List.from(json['medical_records'])
        .map((e) => MedicalRecords.fromJson(e))
        .toList();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['full_name'] = fullName;
    _data['gender'] = gender;
    _data['address'] = address;
    _data['mobile_number'] = mobileNumber;
    _data['medical_records'] = medicalRecords.map((e) => e.toJson()).toList();
    return _data;
  }
}

class MedicalRecords {
  MedicalRecords({
    required this.result,
    required this.date,
  });
  late final dynamic result;
  late final dynamic date;

  MedicalRecords.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'];
    date = json['date'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['result'] = result;
    _data['date'] = date;
    return _data;
  }
}
