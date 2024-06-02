import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/base/base_response.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  @JsonKey(name: "categories")
  final BaseListResponse<CategoryModel>? categories;

  CategoriesModel({this.categories});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);
}

@JsonSerializable()
class CategoryModel implements BaseDataModel {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "icons")
  final List<IconCategory>? icons;

  CategoryModel({this.id, this.name, this.icons});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      CategoryModel.fromJson(json) as T;
}

@JsonSerializable()
class IconCategory {
  @JsonKey(name: "height")
  final int? height;

  @JsonKey(name: "url")
  final String? url;

  @JsonKey(name: "width")
  final int? width;

  IconCategory({this.height, this.url, this.width});

  factory IconCategory.fromJson(Map<String, dynamic> json) =>
      _$IconCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$IconCategoryToJson(this);
}
