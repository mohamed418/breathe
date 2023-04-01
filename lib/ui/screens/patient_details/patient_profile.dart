import 'package:flutter/material.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8EE),
      body: SafeArea(
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
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      "Name of Patient",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 26, color: Colors.white),
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
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "examine",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 17, color: Colors.black87),
                            ),
                            Text(
                              "8",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 18,
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
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "consulta",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 17, color: Colors.black87),
                            ),
                            Text(
                              "7",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 18,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "   examine :",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Column(
                  children: [
                    Text(
                      "Mon 13/11/2022  ",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "12:00 pm  ",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
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
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "   consulta :",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Column(
                  children: [
                    Text(
                      "Wed 15/11/2022  ",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "12:00 pm  ",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
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
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
