// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AuthState extends Equatable {
  const AuthState(this._type);

  factory AuthState.loading() = Loading;

  factory AuthState.anonymous() = Anonymous;

  factory AuthState.authenticated({@required User user}) = Authenticated;

  final _AuthState _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(Loading) loading,
      @required FutureOr<R> Function(Anonymous) anonymous,
      @required FutureOr<R> Function(Authenticated) authenticated}) {
    assert(() {
      if (loading == null || anonymous == null || authenticated == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _AuthState.Loading:
        return loading(this as Loading);
      case _AuthState.Anonymous:
        return anonymous(this as Anonymous);
      case _AuthState.Authenticated:
        return authenticated(this as Authenticated);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(Loading) loading,
      FutureOr<R> Function(Anonymous) anonymous,
      FutureOr<R> Function(Authenticated) authenticated,
      @required FutureOr<R> Function(AuthState) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _AuthState.Loading:
        if (loading == null) break;
        return loading(this as Loading);
      case _AuthState.Anonymous:
        if (anonymous == null) break;
        return anonymous(this as Anonymous);
      case _AuthState.Authenticated:
        if (authenticated == null) break;
        return authenticated(this as Authenticated);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(Loading) loading,
      FutureOr<void> Function(Anonymous) anonymous,
      FutureOr<void> Function(Authenticated) authenticated}) {
    assert(() {
      if (loading == null && anonymous == null && authenticated == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _AuthState.Loading:
        if (loading == null) break;
        return loading(this as Loading);
      case _AuthState.Anonymous:
        if (anonymous == null) break;
        return anonymous(this as Anonymous);
      case _AuthState.Authenticated:
        if (authenticated == null) break;
        return authenticated(this as Authenticated);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Loading extends AuthState {
  const Loading._() : super(_AuthState.Loading);

  factory Loading() {
    _instance ??= Loading._();
    return _instance;
  }

  static Loading _instance;
}

@immutable
class Anonymous extends AuthState {
  const Anonymous._() : super(_AuthState.Anonymous);

  factory Anonymous() {
    _instance ??= Anonymous._();
    return _instance;
  }

  static Anonymous _instance;
}

@immutable
class Authenticated extends AuthState {
  const Authenticated({@required this.user}) : super(_AuthState.Authenticated);

  final User user;

  @override
  String toString() => 'Authenticated(user:${this.user})';
  @override
  List get props => [user];
}
