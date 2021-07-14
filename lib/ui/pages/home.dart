import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/bloc/authentication/authentication_bloc.dart';
import 'package:nytimes/bloc/authentication/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nytimes/repositories/authentication_repository.dart';
import 'package:nytimes/ui/pages/posts_list.dart';

import 'login.dart';

class Home extends StatelessWidget {
AuthenticationRepository _authenticationRepository= AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return LoginPage(
              authenticationRepository: _authenticationRepository,
            );
          }
          if (state is Authenticated) {
            return PostsList();
          }

          if (state is Unauthenticated) {
            return LoginPage(
             authenticationRepository: _authenticationRepository,
            );
          } else
            return Container();
        },
      ),
    );
  }
}