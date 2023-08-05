import '../../data/base/result.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> run(Params params);

  Future<Result<Type?>> call(Params params) async => await run(params);
}

class None {}
