class GetAllPatientsModel {
  GetAllPatientsModel({
    required this.status,
    required this.message,
    required this.patients,
  });
  late final bool status;
  late final dynamic message;
  late final List<Patients> patients;

  GetAllPatientsModel.fromJson(Map<dynamic, dynamic> json) {
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
  late final int id;
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
    required this.message,
  });
  late final dynamic message;

  MedicalRecords.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['message'] = message;
    return _data;
  }
}
