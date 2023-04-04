import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/components.dart';
import '../models/add_new_patient_model.dart';
import '../models/login_model.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';
import '../ui/screens/home/home_screen.dart';
import 'states.dart';

class BreatheCubit extends Cubit<BreatheStates> {
  BreatheCubit() : super(BreatheInitialState());

  static BreatheCubit get(context) => BlocProvider.of(context);

  int currentIndex = 3;

  IconData icon = Icons.visibility_off;
  bool isVisible = false;

  void visible() {
    isVisible = !isVisible;
    icon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(ChangeBottomNavState());
  }

  void login({
    required String email,
    required String password,
    //dynamic token,
    //required BuildContext? context,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'login',
      data: {
        "email": email,
        "password": password,
        token: CacheHelper.getData(key: "token") ?? '',
      },
    ).then((value) {
      //print(value.data['message']);
      LoginModel loginModel = LoginModel.fromJson(value.data);
      //getUserData();
      LoginErrorState(loginModel);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      debugPrint('login error $error');
    });
  }

  void addNewPatient({
    required String full_name,
    required String gender,
    required String address,
    required String mobile_number,
    //dynamic token,
    required BuildContext? context,
  }) {
    emit(AddNewPatientLoadingState());
    DioHelper.postData(
      url: 'patient',
      data: {
        "full_name": full_name,
        "gender": gender,
        "address": address,
        "mobile_number": mobile_number,
        token: CacheHelper.getData(key: "token") ?? '',
      },
    ).then((value) {
      AddNewPatientModel addNewPatient =
          AddNewPatientModel.fromJson(value.data);
      Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
      emit(AddNewPatientSuccessState(addNewPatient));
    }).catchError((error) {
      emit(AddNewPatientErrorState());
      debugPrint('add new patient error $error');
    });
  }
}
