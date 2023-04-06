import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/components.dart';
import '../models/add_new_patient_model.dart';
import '../models/get_all_patients.dart';
import '../models/login_model.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/home/home_tab/home_tab.dart';
import '../ui/screens/home/list_of_patients/patients_tab.dart';
import '../ui/screens/home/my_account/account_tab.dart';
import '../ui/screens/home/symptoms/symptoms_tab.dart';
import 'states.dart';

class BreatheCubit extends Cubit<BreatheStates> {
  BreatheCubit() : super(BreatheInitialState());

  static BreatheCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  IconData icon = Icons.visibility_off;
  bool isVisible = false;

  void visible() {
    isVisible = !isVisible;
    icon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(ChangeBottomNavState());
  }

  List<BottomNavyBarItem> tabs = [
    BottomNavyBarItem(
      icon: const Icon(Icons.home),
      title: const Text(
        "home",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.category_outlined),
      title: const Text(
        "Symptoms",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.interpreter_mode),
      title: const Text(
        'Patients',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.person),
      title: const Text(
        "account",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
  ];

  List<Widget> Screens = [
    const HomeTab(),
    const SymptomsTab(),
    const PatientsTab(),
    const AccountTab(),
  ];

  void changeBot(index) {
    emit(ChangeBotNavState());
    currentIndex = index;
    if (currentIndex == 2) {
      getAllPatients();
    }
  }


  void login({
    required String email,
    required String password,
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
            return const HomeScreen();
          },
        ),
      );

      emit(AddNewPatientSuccessState(addNewPatient));
      getAllPatients();
    }).catchError((error) {
      emit(AddNewPatientErrorState());
      debugPrint('add new patient error $error');
    });
  }

  GetAllPatientsModel? getAllPatientsModel;
  void getAllPatients() {
    emit(GetAllPatientsLoadingState());
    DioHelper.getData(
      url: 'patients',
    ).then((value) {
      getAllPatientsModel =
      GetAllPatientsModel.fromJson(value.data);
      print(value.data);
      emit(GetAllPatientsSuccessState(getAllPatientsModel!));
    }).catchError((error) {
      emit(GetAllPatientsErrorState());
      debugPrint('add new patient error $error');
    });
  }
}
