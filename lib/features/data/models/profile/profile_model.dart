import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/base/base_response.dart';

part 'profile_model.g.dart';

class Profile implements BaseDataModel {
  @JsonKey(name: "fist_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  Profile({this.firstName, this.lastName});

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      _$ProfileFromJson(json) as T;
}
