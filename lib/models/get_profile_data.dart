class GetProfileDataModel {
  GetProfileDataModel({
    required this.Message,
    required this.profiledata,
  });
  late final String Message;
  late final Profiledata profiledata;

  GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    Message = json['Message'];
    profiledata = Profiledata.fromJson(json['profiledata']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Message'] = Message;
    _data['profiledata'] = profiledata.toJson();
    return _data;
  }
}

class Profiledata {
  Profiledata({
    required this.doctorname,
    required this.specialization,
    required this.yearsOfExperience,
    required this.phoneNumber,
    required this.numberOfPatients,
    required this.doctorImage,
  });
  late final String doctorname;
  late final String specialization;
  late final int yearsOfExperience;
  late final String phoneNumber;
  late final int numberOfPatients;
  late final String doctorImage;

  Profiledata.fromJson(Map<String, dynamic> json) {
    doctorname = json['doctorname'];
    specialization = json['specialization'];
    yearsOfExperience = json['years_of_experience'];
    phoneNumber = json['phone_number'];
    numberOfPatients = json['number_of_patients'];
    doctorImage = json['doctor_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['doctorname'] = doctorname;
    _data['specialization'] = specialization;
    _data['years_of_experience'] = yearsOfExperience;
    _data['phone_number'] = phoneNumber;
    _data['number_of_patients'] = numberOfPatients;
    _data['doctor_image'] = doctorImage;
    return _data;
  }
}
