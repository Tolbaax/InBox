import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<T, Parameters> {
  Stream<T> call(Parameters parameters);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
