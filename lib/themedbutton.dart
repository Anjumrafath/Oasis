import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/theme/themecubit.dart';

class ThemedButton extends StatelessWidget {
  const ThemedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return IconButton(
          icon: Icon(
            themeState.themeData.brightness == Brightness.light
                ? Icons.brightness_4 // Dark mode icon
                : Icons.brightness_7, // Light mode icon
          ),
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        );
      },
    );
  }
}
