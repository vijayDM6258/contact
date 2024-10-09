import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int cs = 0;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Column(
        children: [
          Theme(
            data: ThemeData(
                textTheme: TextTheme(
                    bodyMedium: TextStyle(color: Colors.yellow, fontSize: 30)),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.black)),
            child: Column(
              children: [
                Text("Hello Good morning"),
                ListTile(
                  title: Text("Title"),
                  subtitle: Text("subtitle"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                )
              ],
            ),
          ),
          Stepper(
            currentStep: cs,
            steps: [
              Step(
                  title: Text("Title 1"),
                  content: TextFormField(
                    controller: controller,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  isActive: cs >= 0,
                  state: cs == 0
                      ? StepState.editing
                      : (controller.text.isEmpty
                          ? StepState.error
                          : StepState.complete),
                  label: Text("1")),
              Step(
                  title: Text("Title 2"),
                  content: Text("Sub Title 2"),
                  isActive: cs >= 1,
                  state: StepState.complete),
              Step(
                title: Text("Title 3"),
                content: Text("Sub Title 3"),
                isActive: cs >= 2,
              ),
              Step(
                title: Text("Title 4"),
                content: Text("Sub Title 4"),
                isActive: cs >= 3,
              ),
              Step(
                title: Text("Title 5"),
                content: Text("Sub Title 5"),
                isActive: cs >= 4,
              ),
            ],
            controlsBuilder: (context, details) {
              // details.
              return Row(
                children: [
                  if (details.currentStep != 0)
                    TextButton(
                        onPressed: details.onStepCancel, child: Text("Back")),
                  if (details.currentStep != 4)
                    TextButton(
                        onPressed: details.onStepContinue, child: Text("Next")),
                ],
              );
            },
            onStepContinue: () {
              if (cs < 4) {
                cs++;
                setState(() {});
              }

              print("onStepContinue");
            },
            onStepCancel: () {
              if (cs > 0) {
                cs--;
                setState(() {});
              }

              print("Cancel");
            },
            onStepTapped: (value) {
              cs = value;
              setState(() {});
              print("onStepTapped $value");
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.minimize),
      ),
    );
  }
}
