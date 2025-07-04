import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthStarted>((event, emit) async {
      final user = authRepository.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<AuthSignedUp>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUp(email: event.email, password: event.password);
        emit(AuthAuthenticated(authRepository.currentUser!));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<AuthLoggedIn>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signIn(email: event.email, password: event.password);
        emit(AuthAuthenticated(authRepository.currentUser!));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<AuthLoggedOut>((event, emit) async {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    });
  }
}