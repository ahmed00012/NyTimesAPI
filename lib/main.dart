import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/generated/codegen_loader.g.dart';
import 'package:nytimes/repositories/authentication_repository.dart';
import 'package:nytimes/ui/pages/home.dart';




import 'bloc/authentication/bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();



  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
    child: BlocProvider(
        create: (context) => AuthenticationBloc(authenticationRepository: _authenticationRepository)
          ..add(AppStarted()),
        child: Home()),
  ));
}
