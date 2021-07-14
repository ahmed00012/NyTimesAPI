import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nytimes/bloc/login/bloc.dart';
import 'package:nytimes/repositories/authentication_repository.dart';
import 'package:nytimes/ui/widgets/login_widget.dart';


class LoginPage extends StatelessWidget{
  final AuthenticationRepository _authenticationRepository;
  LoginPage({@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
                  authenticationRepository: _authenticationRepository,
                ),
            child: LoginWidget(),);
  }
}
