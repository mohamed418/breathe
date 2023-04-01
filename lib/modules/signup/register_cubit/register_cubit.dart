import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/signup_model.dart';
import '../../../network/remote/dio_helper.dart';
import 'register_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  SignUpModel? signupModel;
  void userSignUp({
    String? username,
    String? email,
    String? password,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(url: 'signup', data: {
      "username": username,
      "email": email,
      'password': password,
    }).then((value) {
      signupModel = SignUpModel.fromJson(value.data);
      emit(SignUpSuccessState(signupModel!));
      print(signupModel!.message);
    }).catchError((error) {
      print('error: $error');
      emit(SignUpErrorState(error.toString()));
    });
  }



  IconData icon1 = Icons.visibility_off;
  bool isVisible1 = false;

  void visible1() {
    isVisible1 = !isVisible1;
    icon1 = isVisible1 ? Icons.visibility : Icons.visibility_off;
    emit(ChangeBottomNavState1());
  }

}
