abstract class DataMapper<FROM, TO> {
  List<TO> call(List<FROM> data) {
    return data.map((from) => transform(from)).toList();
  }

  TO transform(FROM data);
}

abstract class AsyncDataMapper<FROM, TO> {
  Future<List<TO>> call(List<FROM> data) async {
    return await Future.wait(data.map((from) async => await transform(from)).toList());
  }

  Future<TO> transform(FROM data);
}
