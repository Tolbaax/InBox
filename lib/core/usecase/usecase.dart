import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

abstract class StreamUseCase<T, Parameters> {
  Stream<T> call(Parameters parameters);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
