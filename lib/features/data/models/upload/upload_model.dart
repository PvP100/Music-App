import 'package:music_app/features/data/base/base_response.dart';

part 'upload_model.g.dart';

class UploadModel extends BaseDataModel {
  final String? id;

  UploadModel({this.id});

  factory UploadModel.fromJson(Map<String, dynamic> json) =>
      _$UploadModelFromJson(json);

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      UploadModel.fromJson(json) as T;
}
