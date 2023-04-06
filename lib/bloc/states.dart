import '../models/add_new_patient_model.dart';
import '../models/get_all_patients.dart';
import '../models/login_model.dart';

abstract class BreatheStates{}

class BreatheInitialState extends BreatheStates{}

class ChangeBotNavState extends BreatheStates{}

class ChangeBottomNavState extends BreatheStates{}

class TopShopLoadingState extends BreatheStates{}

class TopShopSuccessState extends BreatheStates{}

class TopShopErrorState extends BreatheStates{}

class LoginSuccessState extends BreatheStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginLoadingState extends BreatheStates{}

class LoginErrorState extends BreatheStates{
  final dynamic loginModel;
  final String error;

  LoginErrorState([this.loginModel, this.error = '']);
}

class AddNewPatientLoadingState extends BreatheStates{}

class AddNewPatientSuccessState extends BreatheStates{
  final AddNewPatientModel addNewPatientModel;
  AddNewPatientSuccessState(this.addNewPatientModel);
}

class AddNewPatientErrorState extends BreatheStates{}

class GetAllPatientsLoadingState extends BreatheStates{}

class GetAllPatientsSuccessState extends BreatheStates{
  final GetAllPatientsModel addNewPatientsModel;
  GetAllPatientsSuccessState(this.addNewPatientsModel);
}

class GetAllPatientsErrorState extends BreatheStates{}
