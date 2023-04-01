
import 'package:grad_proj_ui_test/models/signup_model.dart';

abstract class SignUpStates{}

class SignUpInitialState extends SignUpStates{}

class SignUpSuccessState extends SignUpStates{
  final SignUpModel signupModel;
  SignUpSuccessState(this.signupModel);
}

class SignUpLoadingState extends SignUpStates{}

class SignUpErrorState extends SignUpStates{
  final String error;
  SignUpErrorState(this.error);
}

class ChangeBottomNavState1 extends SignUpStates{}

class ChangeGenderButtonState extends SignUpStates{}