import 'package:flutter/material.dart';

class SymptomLabel extends StatefulWidget {
  @override
  State<SymptomLabel> createState() => _SymptomLabelState();
}

class _SymptomLabelState extends State<SymptomLabel> {
  bool isSelected = false;
  bool isNotSelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              "_ is patient feel ............ ?",
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 24,
                  ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    // Color(0xFF001B48).withOpacity(0.85),
                    setState(() {
                      isSelected = true;
                      isNotSelected = false;
                    });
                  },
                  child: Container(
                    width: 90,
                    height: 45,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF001B48).withOpacity(0.85)
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                        child: Text(
                      "Yes",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Color(0xFF001B48).withOpacity(0.85),
                    setState(() {
                      isNotSelected = true;
                      isSelected = false;
                    });
                  },
                  child: Container(
                    width: 90,
                    height: 45,
                    decoration: BoxDecoration(
                      color: isNotSelected
                          ? const Color(0xFF001B48).withOpacity(0.85)
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                        child: Text(
                      "No",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
