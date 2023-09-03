import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/base/base_response.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel implements BaseDataModel {
  final int? width;
  final int? height;

  @JsonKey(name: "title")
  final String? altDescription;

  final UrlsModel? urls;

  const ImageModel({this.width, this.height, this.altDescription, this.urls});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      ImageModel.fromJson(json) as T;

  @override
  String toString() {
    return "width: $width - height: $height - altDescription: $altDescription";
  }
}

@JsonSerializable()
class UrlsModel {
  final String? raw;
  final String? full;
  final String? regular;
  final String? small;
  final String? thumb;

  @JsonKey(name: "small_s3")
  final String? smallS3;

  UrlsModel(
      this.raw, this.full, this.regular, this.small, this.thumb, this.smallS3);

  factory UrlsModel.fromJson(Map<String, dynamic> json) =>
      _$UrlsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsModelToJson(this);
}
