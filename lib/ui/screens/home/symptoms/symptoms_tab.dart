import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:grad_proj_ui_test/ui/components/symptom_label.dart';

class SymptomsTab extends StatelessWidget {
  const SymptomsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8EE),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Text("Answer To Check",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ))),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: defaultFormField(
                label: '',
                type: TextInputType.text,
                controller: null,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  if (value.length > 11) {
                    return '';
                  }
                  return null;
                },
                hint: 'Search there...',
                prefix: Icons.search,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (buildContext, index) {
                    return SymptomLabel();
                  },
                  separatorBuilder: (buildContext, index) {
                    return const SizedBox(
                      width: 1,
                      height: 0.5,
                    );
                  },
                  itemCount: 20),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
