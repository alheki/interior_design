import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';
import '../../logic/settings_cubit.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("language".tr),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              RadioListTile<Locale>(
                title: Text("english".tr),
                value: const Locale('en', 'US'),
                groupValue: state.locale,
                onChanged: (locale) {
                  if (locale != null) {
                    context.read<SettingsCubit>().changeLanguage(locale);
                  }
                },
              ),
              RadioListTile<Locale>(
                title: Text("arabic".tr),
                value: const Locale('ar', 'SA'),
                groupValue: state.locale,
                onChanged: (locale) {
                  if (locale != null) {
                    context.read<SettingsCubit>().changeLanguage(locale);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}