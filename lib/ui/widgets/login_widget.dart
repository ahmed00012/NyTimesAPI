
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nytimes/bloc/authentication/authentication_bloc.dart';
import 'package:nytimes/bloc/authentication/bloc.dart';
import 'package:nytimes/bloc/login/bloc.dart';
import 'package:nytimes/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../constants.dart';



class LoginWidget extends StatefulWidget {

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  LoginBloc _loginBloc;


  _onSubmit() async {
    _loginBloc.add(Login());
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state.isFailure)
            return Text('failed');
          else if (state.isSubmitting)
            return CircularProgressIndicator();
          else if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());


          }
        }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: HexColor(color),

        body: Center(
          child: GestureDetector(
            onTap: () async{
              await _onSubmit();
            },
            child: Container(
              width: size.width * 0.5,
              height: size.height * 0.05,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(size.height * 0.05),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.login.tr(),
                  style: TextStyle(
                      fontSize: size.height * 0.02,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }
}
