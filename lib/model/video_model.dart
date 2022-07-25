part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class VideoModel {
  final String Duration;
  final String Fee;
  final String VideoName;
  @JsonKey(name: "corse_id")
  final String corseid;
  @JsonKey(name: "course_name")
  final String coursename;
  final String image;
  final String vid;

  VideoModel({
    required this.Duration,
    required this.Fee,
    required this.VideoName,
    required this.corseid,
    required this.coursename,
    required this.image,
    required this.vid,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
