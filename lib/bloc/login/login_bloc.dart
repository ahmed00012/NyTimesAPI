import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:nytimes/repositories/authentication_repository.dart';
import 'login_state.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
 AuthenticationRepository _authenticationRepository;

  LoginBloc({@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository, super(LoginState.empty());

  @override
  LoginState get initialState => LoginState.empty();


  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is Login) {
      yield* _mapLoginWithCredentialsPressedToState();

    }
  }


  Stream<LoginState> _mapLoginWithCredentialsPressedToState() async* {
    yield LoginState.loading();

    try {
      await _authenticationRepository.signIn();

      yield LoginState.success();
    } catch (_) {
      LoginState.failure();
    }


  }
}