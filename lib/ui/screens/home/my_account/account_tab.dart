import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/ui/screens/login_screen.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8EE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                color: const Color(0xFF001B48),
                height: MediaQuery.of(context).size.height * 0.28,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/doctor_pic.png'),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            " Dr : Sayed Hashem",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 80,
                          width: 92,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "patients",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        fontSize: 17, color: Colors.black87),
                              ),
                              Text(
                                "+12",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        fontSize: 19,
                                        color: const Color(0xFF97CADB)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 80,
                          width: 92,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "experience",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        fontSize: 17, color: Colors.black87),
                              ),
                              Text(
                                "+4",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        fontSize: 19,
                                        color: const Color(0xFF97CADB)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Text(
                "   About :",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '''
    Name : Sayed Hashem
    Age : 21
    Mobile Number : 01120711950
                ''',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                "   Availability :",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '''
    bla bla bla 
    bla bla .....
                ''',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                "   Privacy",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "   Logout",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 25,
                          color: const Color(0xFF97CADB),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.logout,
                    size: 35,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
