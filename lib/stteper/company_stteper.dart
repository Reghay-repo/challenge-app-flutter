import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../Locale/locale.dart';

class Animal {
  final int? id;
  final String? name;

  Animal({
    this.id,
    this.name,
  });
}

class StepperCompany extends StatefulWidget {
  @override
  _StepperCompanyState createState() => _StepperCompanyState();
}

class _StepperCompanyState extends State<StepperCompany> {
  int _currentStep = 0;
  Color _underlineColor = Color(0xFFCCCCCC);
  StepperType stepperType = StepperType.vertical;
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
  var currentChoice = "Man";
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name!))
      .toList();

  List<Animal?> _selectedAnimals2 = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentChoice = "Man";
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 232, 28, 28),
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Account'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _underlineColor),
                              ),
                              labelText:
                                  AppLocalizations.of(context)!.fullName!,
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _underlineColor),
                              ),
                              labelText:
                                  AppLocalizations.of(context)!.phoneNumber!,
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _underlineColor),
                              ),
                              labelText: AppLocalizations.of(context)!.email!,
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('LCE'),
                    content: Column(
                      children: <Widget>[
                        DropdownButton(
                          isExpanded: true,
                          value: currentChoice,
                          items: const [
                            //add items in the dropdown
                            DropdownMenuItem(
                                child: Text(
                                  "Man",
                                ),
                                value: "Man"),

                            DropdownMenuItem(
                              child: Text("Woman"),
                              value: "Woman",
                            ),

                            DropdownMenuItem(
                              child: Text("Child"),
                              value: "Child",
                            )
                          ],
                          onChanged: (value) {
                            print("You selected $value");
                            setState(() => currentChoice = value!);
                          },
                        ),
                        MultiSelectBottomSheetField(
                          initialChildSize: 0.4,
                          listType: MultiSelectListType.CHIP,
                          searchable: true,
                          buttonText: Text("Favorite Animals",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5)),
                          title: Text("Animals"),
                          items: _items,
                          onConfirm: (values) {
                            // _selectedAnimals2 = values;
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (value) {
                              setState(() {
                                _selectedAnimals2.remove(value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('PassWord'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          obscureText: _obscureText,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: _underlineColor),
                            ),
                            labelText: AppLocalizations.of(context)!.password!,
                            labelStyle: TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                                icon: Icon(_iconVisible,
                                    color: Colors.white, size: 20),
                                onPressed: () {
                                  _toggleObscureText();
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
