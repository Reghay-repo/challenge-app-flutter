import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brands_app/Locale/language_cubit.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Routes/routes.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late LanguageCubit _languageCubit;
  int? _selectedLanguage = -1;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
    _selectedLanguage = -1;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> languages = [
      'English',
      'عربى',
      'français',
    ];
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        _selectedLanguage = getCurrentLanguage(locale);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.changeLanguage!),
            backgroundColor: Colors.deepPurple,
          ),
          body: FadedSlideAnimation(
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) => RadioListTile(
                onChanged: (value) async {
                  setState(() {
                    _selectedLanguage = value;
                    Navigator.pushNamed(context, PageRoutes.loginpage);
                    print(index);
                  });
                  if (_selectedLanguage == 0) {
                    _languageCubit.selectEngLanguage();
                  } else if (_selectedLanguage == 1) {
                    _languageCubit.selectArabicLanguage();
                  } else if (_selectedLanguage == 2) {
                    _languageCubit.selectFrenchLanguage();
                  }
                },
                groupValue: _selectedLanguage,
                value: index,
                activeColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                toggleable: true,
                title: Text(
                  languages[index],
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int getCurrentLanguage(Locale locale) {
    if (locale == Locale('en')) {
      return 0;
    } else if (locale == Locale('ar')) {
      return 1;
    } else if (locale == Locale('fr')) {
      return 2;
    } else {
      return -1;
    }
  }
}
