import '../models/add_new_patient_model.dart';
import '../models/create_medical_record_model.dart';
import '../models/get_all_patients.dart';
import '../models/get_profile_data.dart';
import '../models/login_model.dart';
import '../models/search_patient_model.dart';

abstract class BreatheStates {}

class BreatheInitialState extends BreatheStates {}

class ChangeBotNavState extends BreatheStates {}

class ChangeBottomNavState extends BreatheStates {}

class TopShopLoadingState extends BreatheStates {}

class TopShopSuccessState extends BreatheStates {}

class TopShopErrorState extends BreatheStates {}

class LoginSuccessState extends BreatheStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginLoadingState extends BreatheStates {}

class LoginErrorState extends BreatheStates {
  final dynamic loginModel;
  final String error;

  LoginErrorState([this.loginModel, this.error = '']);
}

class AddNewPatientLoadingState extends BreatheStates {}

class AddNewPatientSuccessState extends BreatheStates {
  final AddNewPatientModel addNewPatientModel;
  AddNewPatientSuccessState(this.addNewPatientModel);
}

class AddNewPatientErrorState extends BreatheStates {
  final String error;

  AddNewPatientErrorState(this.error);
}

class GetAllPatientsLoadingState extends BreatheStates {}

class GetAllPatientsSuccessState extends BreatheStates {
  final GetAllPatientsModel addNewPatientsModel;
  GetAllPatientsSuccessState(this.addNewPatientsModel);
}

class GetAllPatientsErrorState extends BreatheStates {
  final String error;

  GetAllPatientsErrorState(this.error);
}

class SearchPatientsLoadingState extends BreatheStates {}

class SearchPatientsSuccessState extends BreatheStates {
  final SearchPatientModel searchResult;

  SearchPatientsSuccessState(this.searchResult);
}

class SearchPatientsErrorState extends BreatheStates {
  final String errorMessage;

  SearchPatientsErrorState(this.errorMessage);
}

class ForgetPasswordLoadingState extends BreatheStates {}

class ForgetPasswordSuccessState extends BreatheStates {}

class ForgetPasswordErrorState extends BreatheStates {
  final String message;

  ForgetPasswordErrorState(this.message);
}

class VerifyCodeLoadingState extends BreatheStates {}

class VerifyCodeSuccessState extends BreatheStates {}

class VerifyCodeErrorState extends BreatheStates {
  final String message;

  VerifyCodeErrorState(this.message);
}

class ResetPassLoadingState extends BreatheStates {}

class ResetPassSuccessState extends BreatheStates {}

class ResetPassErrorState extends BreatheStates {
  final String message;

  ResetPassErrorState(this.message);
}

class CreateMedicalRecordLoadingState extends BreatheStates {}

class CreateMedicalRecordSuccessState extends BreatheStates {
  final CreateMedicalRecordModel addNewPatientModel;
  CreateMedicalRecordSuccessState(this.addNewPatientModel);
}

class CreateMedicalRecordErrorState extends BreatheStates {
  final String error;

  CreateMedicalRecordErrorState(this.error);
}

class ReadMedicalRecordLoadingState extends BreatheStates {}

class ReadMedicalRecordSuccessState extends BreatheStates {}

class ReadMedicalRecordErrorState extends BreatheStates {
  final String errorMessage;

  ReadMedicalRecordErrorState(this.errorMessage);
}

class CreateProfileDataLoadingState extends BreatheStates {}

class CreateProfileDataSuccessState extends BreatheStates {
  // final String data;
  //
  // CreateProfileDataSuccessState(this.data);
}

class CreateProfileDataErrorState extends BreatheStates {
  final String errorMessage;

  CreateProfileDataErrorState(this.errorMessage);
}

class AddProfileImageLoadingState extends BreatheStates {}

class AddProfileImageSuccessState extends BreatheStates {
  final GetProfileDataModel getProfileDataModel;
  AddProfileImageSuccessState(this.getProfileDataModel);
}

class AddProfileImageErrorState extends BreatheStates {
  final dynamic error;
  AddProfileImageErrorState(this.error);
}

class GetProfileDataLoadingState extends BreatheStates {}

class GetProfileDataSuccessState extends BreatheStates {
  final GetProfileDataModel getProfileDataModel;
  GetProfileDataSuccessState(this.getProfileDataModel);
}

class GetProfileDataErrorState extends BreatheStates {
  final dynamic error;
  GetProfileDataErrorState(this.error);
}

class EditProfileDataLoadingState extends BreatheStates {}

class EditProfileDataSuccessState extends BreatheStates {}

class EditProfileDataErrorState extends BreatheStates {
  final dynamic error;
  EditProfileDataErrorState(this.error);
}

class PredictResultLoadingState extends BreatheStates {}

class PredictResultSuccessState extends BreatheStates {
  final String result;

  PredictResultSuccessState(this.result);
}

class PredictResultErrorState extends BreatheStates {
  final String errorMessage;

  PredictResultErrorState(this.errorMessage);
}
