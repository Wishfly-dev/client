class Unit {
  const Unit._();
}

const voidUnit = Unit._();

/// Alias for [Result]
typedef ResultOf<E, S> = Result<E, S>;

/// Base Result class
///
/// Receives two values [E] and [S]
/// as [E] is an error and [S] is a success.
abstract class Result<E, S> {
  /// Default constructor.
  const Result();

  /// Build a [Result] that returns a [Error].
  factory Result.success(S s) => Success(s);

  /// Build a [Result] that returns a [Error].
  factory Result.error(E e) => Error(e);

  factory Result.loading() => const Loading();

  /// Returns the value of [S] if any.
  S? get getOrElse;

  /// Returns the value of [E] if any.
  E? getOrFail();

  /// Returns true if the current result is an [Error].
  bool get isError;

  /// Returns true if the current result is a [Success].
  bool get isSuccess;

  /// Return the result in one of these functions.
  ///
  /// if the result is an error, it will be returned in
  /// [whenError],
  /// if it is a success it will be returned in [whenSuccess].
  W when<W>(
    W Function(S success) whenSuccess,
    W Function(E error) whenError,
    W Function() whenLoading,
  );

  /// Execute [whenSuccess] if the [Result] is a success.
  R? whenSuccess<R>(
    R Function(S success) whenSuccess,
  );

  /// Execute [whenError] if the [Result] is an error.
  R? whenError<R>(
    R Function(E error) whenError,
  );

  /// Execute [whenSuccess] if the [Result] is a success.
  R? whenLoading<R>(
    R Function() whenLoading,
  );
}

/// Success Result.
///
/// return it when the result of a [Result] is
/// the expected value.
class Success<E, S> extends Result<E, S> {
  /// Receives the [S] param as
  /// the successful result.
  const Success(
    this._success,
  );

  /// Build a `Success` with `Unit` value.
  /// ```dart
  /// Success.unit() == Success(unit)
  /// ```
  static Success<E, Unit> unit<E>() {
    return Success<E, Unit>(voidUnit);
  }

  final S _success;

  @override
  bool get isError => false;

  @override
  bool get isSuccess => true;

  @override
  int get hashCode => _success.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Success && other._success == _success;
  }

  @override
  W when<W>(
    W Function(S success) whenSuccess,
    W Function(E error) whenError,
    W Function() whenLoading,
  ) {
    return whenSuccess(_success);
  }

  @override
  E? getOrFail() => null;

  @override
  S get getOrElse => _success;

  @override
  R? whenError<R>(R Function(E error) whenError) => null;

  @override
  R whenSuccess<R>(R Function(S success) whenSuccess) {
    return whenSuccess(_success);
  }

  @override
  R? whenLoading<R>(R Function() whenLoading) => null;
}

class Error<E, S> extends Result<E, S> {
  const Error(this._error);

  static Error<Unit, Unit> unit<S>() {
    return const Error<Unit, Unit>(voidUnit);
  }

  final E _error;

  @override
  bool get isError => true;

  @override
  bool get isSuccess => false;

  @override
  int get hashCode => _error.hashCode;

  @override
  bool operator ==(Object other) => other is Error && other._error == _error;

  @override
  W when<W>(
    W Function(S success) whenSuccess,
    W Function(E error) whenError,
    W Function() whenLoading,
  ) {
    return whenError(_error);
  }

  @override
  E getOrFail() => _error;

  @override
  S? get getOrElse => null;

  @override
  R whenError<R>(R Function(E error) whenError) => whenError(_error);

  @override
  R? whenSuccess<R>(R Function(S success) whenSuccess) => null;

  @override
  R? whenLoading<R>(R Function() whenLoading) => null;
}

class Loading<E, S> extends Result<E, S> {
  const Loading();

  static Loading<S, Unit> unit<S>() {
    return Loading<S, Unit>();
  }

  @override
  bool get isError => false;

  @override
  bool get isSuccess => false;

  @override
  int get hashCode => this.hashCode;

  @override
  bool operator ==(Object other) => other is Loading;

  @override
  W when<W>(
    W Function(S success) whenSuccess,
    W Function(E error) whenError,
    W Function() whenLoading,
  ) {
    return whenLoading();
  }

  @override
  E? getOrFail() => null;

  @override
  S? get getOrElse => null;

  @override
  R? whenError<R>(R Function(E error) whenError) => null;

  @override
  R? whenSuccess<R>(R Function(S success) whenSuccess) => null;

  @override
  R? whenLoading<R>(R Function() whenLoading) => whenLoading();
}
