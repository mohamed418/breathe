import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit.dart';
import '../../../constants/components.dart';
import '../../../network/local/cache_helper.dart';

late String result;

// Define the states
abstract class PredictResultState {}

class PredictResultLoadingState extends PredictResultState {}

class PredictResultSuccessState extends PredictResultState {
  final String result;

  PredictResultSuccessState(this.result);
}

class PredictResultErrorState extends PredictResultState {
  final String error;

  PredictResultErrorState(this.error);
}

// Define the cubit
class PredictResultCubit extends Cubit<PredictResultState> {
  final Dio dio = Dio();
  final String baseUrl = 'http://68.183.77.77:8000/predict';

  PredictResultCubit() : super(PredictResultLoadingState());

  void predictAudio(File audioFile, context, patientId) async {
    emit(PredictResultLoadingState());
    buildSnackBar('Please wait for seconds', context, 2);

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(audioFile.path),
      });

      Response response = await dio.post(baseUrl, data: formData);

      if (response.statusCode == 200) {
        result = response.data['result'];

        emit(PredictResultSuccessState(result));
        debugPrint('patientId: $patientId');
      } else {
        emit(PredictResultErrorState('Error occurred during prediction.'));
      }
    } catch (error) {
      emit(PredictResultErrorState('Error occurred: $error'));
    }
  }
}

class ResultScreen extends StatelessWidget {
  final File audioFile;
  final dynamic patientId;

  ResultScreen({Key? key, required this.audioFile, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PredictResultCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Result Screen'),
        ),
        body: BlocConsumer<PredictResultCubit, PredictResultState>(
          listener: (context, state) {
            if (state is PredictResultSuccessState) {
              // Display the success result
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Prediction Result'),
                  content: Text(state.result),
                  actions: [
                    TextButton(
                      onPressed: () {
                        BreatheCubit.get(context).createMedicalRecord(
                          context,
                          CacheHelper.getData(key: 'Token'),
                          result,
                          patientId.toString(),
                        );
                      },
                      child: const Text('Create Medical Record'),
                    ),
                  ],
                ),
              );
            } else if (state is PredictResultErrorState) {
              // Display the error message
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selected File: ${audioFile.path}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<PredictResultCubit>()
                            .predictAudio(audioFile, context, patientId);
                      },
                      child: const Text('Predict Audio'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
