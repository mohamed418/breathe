import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/ui/components/custom_button.dart';

import '../../../../bloc/states.dart';
import '../../../../constants/components.dart';
import '../../../../network/local/cache_helper.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BreatheCubit, BreatheStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final searchController = TextEditingController();
          Size size = MediaQuery.of(context).size;
          var cubit = BreatheCubit.get(context);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    label: '',
                    type: TextInputType.visiblePassword,
                    controller: searchController,
                    hint: 'Search there...',
                    prefix: Icons.search,
                    //onTap: ()=>print('ldlk'),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      if (value.length > 11) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * .1),
                  CustomButton(
                    text: 'search',
                    onTap: () {
                      print('${CacheHelper.getData(key: 'Token')}');
                      print(searchController.text);
                      cubit.searchPatients(
                        CacheHelper.getData(key: 'Token'),
                        searchController.text,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
