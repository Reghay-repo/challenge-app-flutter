import 'package:brands_app/Auth/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../Auth/Login/UI/login_page.dart';
import '../Auth/firebase_helper.dart';
import '../BottomNavigation/bottom_navigation.dart';
import '../Locale/locale.dart';

class Animal {
  final int? id;
  final String? name;

  Animal({
    this.id,
    this.name,
  });
}

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController sexController = TextEditingController();
TextEditingController passwordController = TextEditingController();
var currentChoice;

class _StepperDemoState extends State<StepperDemo> {
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Form(
          key: _formKey,
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
                      title: new Text(AppLocalizations.of(context)!.account!),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: _underlineColor),
                                ),
                                labelText:
                                    AppLocalizations.of(context)!.fullName!,
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'telephone is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: _underlineColor),
                                ),
                                labelText:
                                    AppLocalizations.of(context)!.phoneNumber!,
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: _underlineColor),
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
                      title:
                          new Text(AppLocalizations.of(context)!.personality!),
                      content: Column(
                        children: <Widget>[
                          DropdownButton(
                            icon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.arrow_downward_outlined,
                                color: Colors.black,
                              ),
                            ),
                            style: const TextStyle(
                                color: Color.fromARGB(
                                    255, 20, 19, 21), //<-- SEE HERE
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            isExpanded: true,
                            value: currentChoice,
                            hint: Text(AppLocalizations.of(context)!.sex!),
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
                            onChanged: (var value) {
                              setState(() {
                                currentChoice = value!;
                                print(value);
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MultiSelectBottomSheetField(
                            initialChildSize: 0.4,
                            listType: MultiSelectListType.CHIP,
                            searchable: true,
                            buttonText: Text(
                              "Your category",
                              style: const TextStyle(
                                  color: Color.fromARGB(
                                      255, 0, 0, 0), //<-- SEE HERE
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
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
                      title: new Text(AppLocalizations.of(context)!.password!),
                      content: Column(
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                ImagePicker imagepicker = ImagePicker();
                                imagepicker.pickImage(
                                    source: ImageSource.gallery);
                              },
                              icon: Icon(Icons.camera_alt)),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password is required';
                              }
                              return null;
                            },
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
                              labelText:
                                  AppLocalizations.of(context)!.password!,
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
    if (!_formKey.currentState!.validate()) {
      'Fill form correctly';

      _currentStep < 2
          ? setState(() => _currentStep += 1)
          : FirebaseHelper()
              .signUp(
                  email: emailController.text.toString(),
                  password: passwordController.text.toString())
              .then((result) {
              if (result == "true") {
                FirebaseAuth.instance.currentUser!
                    .updateDisplayName(nameController.text.trim());

                return BottomNavigation();
              } else if (result != null) {
                return LoginPage();
              }
            });
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
