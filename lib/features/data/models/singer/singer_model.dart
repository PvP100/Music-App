import 'package:music_app/features/data/base/base_response.dart';

part 'singer_model.g.dart';

class SingerModel implements BaseDataModel {
  final String? id;

  final String? name;

  final String? thumbnail;

  SingerModel({this.id, this.name, this.thumbnail});

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      _$SingerModelFromJson(json) as T;

  factory SingerModel.fromJson(Map<String, dynamic> json) =>
      _$SingerModelFromJson(json);
}
