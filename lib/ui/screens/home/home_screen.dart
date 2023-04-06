import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import '../../../theme/my_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = BreatheCubit.get(context);
        return Scaffold(
          backgroundColor: MyTheme.lightBlue,
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: cubit.currentIndex,
            showElevation: true,
            containerHeight: 60,
            itemCornerRadius: 24,
            curve: Curves.easeIn,
            iconSize: 30,
            onItemSelected: (index) => cubit.changeBot(index),
            items: cubit.tabs,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          body: SafeArea(child: cubit.Screens[cubit.currentIndex]),
        );
      },
    );
  }
}
