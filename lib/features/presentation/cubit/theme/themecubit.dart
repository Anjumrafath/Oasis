import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/apptheme.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/theme/themestate.dart';
import 'package:insta_cleanarchitecture/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Define the events for the ThemeCubit
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}


// Define the ThemeCubit
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(lightTheme));

  void toggleTheme() async {
    bool isLightTheme = state.themeData == lightTheme;

    final nextTheme = isLightTheme ? darkTheme : lightTheme;

    await prefs?.setBool('islighttheme', isLightTheme);

    //emit(ThemeState(nextTheme));
    //bool isDarkTheme = true;

    //if (state.themeData! == darkTheme) {
    //isDarkTheme = true;
    //} else {
    //isDarkTheme = false;
    //}

    //await prefs?.setBool('isDarkTheme', isDarkTheme);

    emit(ThemeState(nextTheme));
  }
}
