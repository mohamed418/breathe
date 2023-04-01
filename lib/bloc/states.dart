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
