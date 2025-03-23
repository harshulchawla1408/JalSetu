import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, phone, password];
}

class UpdateProfileEvent extends AuthEvent {
  final String name;
  final String phone;
  final File? profileImage;

  const UpdateProfileEvent({
    required this.name,
    required this.phone,
    this.profileImage,
  });

  @override
  List<Object?> get props => [name, phone, profileImage];
}

class LogoutEvent extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Models
class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
  });

  User copyWith({
    String? name,
    String? phone,
    String? profileImage,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // TODO: Implement actual login logic
      await Future.delayed(const Duration(seconds: 1));
      emit(const AuthAuthenticated(
        User(
          id: 'user-123',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '1234567890',
        ),
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // TODO: Implement actual registration logic
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthAuthenticated(
        User(
          id: 'user-123',
          name: event.name,
          email: event.email,
          phone: event.phone,
        ),
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // TODO: Implement actual profile update logic
      await Future.delayed(const Duration(seconds: 1));
      if (state is AuthAuthenticated) {
        final currentUser = (state as AuthAuthenticated).user;
        emit(AuthAuthenticated(
          currentUser.copyWith(
            name: event.name,
            phone: event.phone,
            profileImage: event.profileImage?.path,
          ),
        ));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // TODO: Implement actual logout logic
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
} 