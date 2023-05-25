class ReadMedicalRecordModel {
  ReadMedicalRecordModel({
    required this.status,
    required this.message,
    required this.patients,
  });
  late final bool status;
  late final dynamic message;
  late final List<Patients> patients;

  ReadMedicalRecordModel.fromJson(Map<dynamic, dynamic> json) {
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
    required this.result,
    required this.patientId,
  });
  late final dynamic result;
  late final int patientId;

  Patients.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'];
    patientId = json['patient_id'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['result'] = result;
    _data['patient_id'] = patientId;
    return _data;
  }
}
