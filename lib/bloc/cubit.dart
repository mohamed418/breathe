import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/ui/screens/login_screen.dart';
import '../models/add_new_patient_model.dart';
import '../models/create_medical_record_model.dart';
import '../models/forget_password_model.dart';
import '../models/get_all_patients.dart';
import '../models/login_model.dart';
import '../network/local/cache_helper.dart';
import '../ui/screens/forget_password_screen/create_new_password_screen.dart';
import '../ui/screens/forget_password_screen/otp_screen.dart';
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

  List<Widget> screens = [
    const HomeTab(),
    const SymptomsTab(),
    const PatientsTab(),
    const AccountTab(),
  ];

  void changeBot(index) {
    emit(ChangeBotNavState());
    currentIndex = index;
    if (currentIndex == 2) {
      getAllPatients(CacheHelper.getData(key: 'Token'));
    }
  }

  // void login({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(LoginLoadingState());
  //   DioHelper.postData(
  //     url: 'login',
  //     data: {
  //       "email": email,
  //       "password": password,
  //       //token: CacheHelper.getData(key: "token") ?? '',
  //     },
  //     Token: CacheHelper.getData(key: "token") ?? '',
  //   ).then((value) {
  //     //debugPrint(value.data['message']);
  //     LoginModel loginModel = LoginModel.fromJson(value.data);
  //     //getUserData();
  //     LoginErrorState(loginModel);
  //     emit(LoginSuccessState(loginModel));
  //   }).catchError((error) {
  //     emit(LoginErrorState(error.toString()));
  //     debugdebugPrint('login error $error');
  //   });
  // }
  Future<void> addNewPatient(
    context,
    String token,
    String fullName,
    String gender,
    String address,
    String mobileNumber,
  ) async {
    emit(AddNewPatientLoadingState());

    final dio = Dio(BaseOptions(
      baseUrl: 'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    final data = {
      'full_name': fullName,
      'gender': gender,
      'address': address,
      'mobile_number': mobileNumber,
    };

    try {
      final response = await dio.post('/user/patient', data: data);
      AddNewPatientModel addNewPatient =
          AddNewPatientModel.fromJson(response.data);
      getAllPatients(CacheHelper.getData(key: 'Token'));
      emit(AddNewPatientSuccessState(addNewPatient));
      Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ),
      );
    } catch (e) {
      emit(AddNewPatientErrorState(e.toString()));
      debugPrint('Error adding new patient: ${e.toString()}');
    }
  }

  GetAllPatientsModel? getAllPatientsModel;

  Future<void> getAllPatients(String token) async {
    emit(GetAllPatientsLoadingState());

    final dio = Dio(BaseOptions(
      baseUrl: 'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    try {
      final response = await dio.get('/user/patients');
      getAllPatientsModel = GetAllPatientsModel.fromJson(response.data);
      emit(GetAllPatientsSuccessState(getAllPatientsModel!));
    } catch (e) {
      emit(GetAllPatientsErrorState(e.toString()));
      debugPrint('Error getting patients: ${e.toString()}');
    }
  }
  Future<void> login1(String email, String password) async {
    emit(LoginLoadingState());
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/user',
        headers: {'Content-Type': 'application/json'},
      ),
    );

    try {
      final response = await dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      LoginModel loginModel = LoginModel.fromJson(response.data);

      CacheHelper.saveData(key: 'Token', value: '${loginModel.token}');

      emit(LoginSuccessState(loginModel));

    } catch (e) {
      // Handle any errors that may occur
      emit(LoginErrorState('Failed to login: ${e.toString()}'));
      debugPrint('Error during login: ${e.toString()}');
    }
  }

  Future<void> deletePatient(context, String token, String fullName) async {
    // emit(DeletePatientLoadingState());

    final dio = Dio(BaseOptions(
      baseUrl: 'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    final data = {'full_name': fullName};

    try {
      await dio.delete('user/patient/delete', data: data);
      // emit(DeletePatientSuccessState());
      Navigator.pop(context);
      getAllPatients(token);
    } catch (e) {
      // emit(DeletePatientErrorState(e.toString()));
      debugPrint('Error deleting patient: ${e.toString()}');
    }
  }

  Future<Response> searchPatients1(String token, String fullName) async {
    const String baseUrl = 'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/';
    final String endpoint = 'user/patient/$fullName';

    try {
      final Dio dio = Dio();
      dio.options.baseUrl = baseUrl;
      dio.options.headers = {'Authorization': 'Bearer $token'};

      final Response response = await dio.get(endpoint);

      return response;
    } catch (error) {
      throw Exception('Error fetching patient data: $error');
    }
  }

  Future<void> searchPatients(String token,String fullName) async {
    emit(SearchPatientsLoadingState());

    final dio = Dio(BaseOptions(
      baseUrl: 'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    try {
      final response = await dio.get('user/patient/$fullName');
      emit(SearchPatientsSuccessState());
    } catch (e) {
      emit(SearchPatientsErrorState(e.toString()));
      debugPrint('Error getting patients: ${e.toString()}');
    }
  }

  Future<void> forgetPassword(String email,context) async {
    emit(ForgetPasswordLoadingState());
    try {
      final response = await Dio().post(
        'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/user/forget-password',
        data: {'email': email},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ForgetPasswordSuccessState());
        ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OtpScreen(email: email,);
            },
          ),
        );
      } else {
        emit(ForgetPasswordErrorState('Unknown error occurred.'));
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.response) {
        emit(ForgetPasswordErrorState('Network error occurred.'));
      } else {
        emit(ForgetPasswordErrorState('Network error occurred.'));
      }
    }
  }
  Future<void> verifyCode(dynamic code, String email,context) async {
    emit(VerifyCodeLoadingState());
    try {
      final response = await Dio().post(
        'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/user/verify-code',
        data: {'verification_code': code},
        options: Options(headers: {'email': email}),
      );
      if (response.statusCode == 200) {
        emit(VerifyCodeSuccessState());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CreateNewPasswordScreen(email: email,);
            },
          ),
        );
      } else {
        emit(VerifyCodeErrorState('Unknown error occurred.'));
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.response) {
        emit(VerifyCodeErrorState('Network error occurred.'));
      } else {
        emit(VerifyCodeErrorState('Network error occurred.'));
      }
    }
  }

  Future<void> resetPassword(String password, String confirmPassword, String email,context) async {
    emit(ResetPassLoadingState());
    try {
      final response = await Dio().post(
        'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/user/reset-password',
        data: {'new_password': password, 'Confirm Password': confirmPassword},
        options: Options(headers: {'email': email}),
      );
      if (response.statusCode == 200) {
        emit(ResetPassSuccessState());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
      } else {
        emit(ResetPassErrorState('Unknown error occurred.'));
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.response) {
        emit(ResetPassErrorState('Network error occurred.'));
      } else {
        emit(ResetPassErrorState('Network error occurred.'));
      }
    }
  }

  Future<void> createMedicalRecord(
      context,
      String token,
      String result,
      String patientId,
      ) async {
    emit(CreateMedicalRecordLoadingState());

    final dio = Dio(BaseOptions(
      baseUrl: 'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    final data = {
      'result': result,
      'patient_id': patientId,
    };

    try {
      final response = await dio.post('/user/patient/medical_record', data: data);
      CreateMedicalRecordModel addNewPatient =
      CreateMedicalRecordModel.fromJson(response.data);
      emit(CreateMedicalRecordSuccessState(addNewPatient));
    } catch (e) {
      emit(CreateMedicalRecordErrorState(e.toString()));
      debugPrint('Error Creating Medical Record: ${e.toString()}');
    }
  }

  Future<void> readMedicalRecord(String patientId,token) async {
    emit(ReadMedicalRecordLoadingState());
    try {
      final dio = Dio();
      final response = await dio.get(
          "http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/user/patients/$patientId/medical_records",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        emit(ReadMedicalRecordSuccessState(response.data));
      } else {
        emit(ReadMedicalRecordErrorState(
            "Error reading medical record. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ReadMedicalRecordErrorState("Error reading medical record: $e"));
      debugPrint('Error during reading record: ${e.toString()}');

    }
  }

}