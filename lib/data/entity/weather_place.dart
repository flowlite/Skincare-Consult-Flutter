import 'package:json_annotation/json_annotation.dart';

part 'weather_place.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true, ignoreUnannotated: true)
class WeatherPlace {
  @JsonKey(name: "id") int? id;
  @JsonKey(name: "title") String? title;
  @JsonKey(name: "content") String? content;
  @JsonKey(name: "type") String? type;
  @JsonKey(name: "image") String? image;
  @JsonKey(name: "media") List<String>? media;

  WeatherPlace({
    this.id,
    this.title,
    this.content,
    this.type,
    this.image,
    this.media,
  });

  /// Connect the generated [_$WeatherPlaceFromJson] function to the `fromJson`
  /// factory.
  factory WeatherPlace.fromJson(Map<String,dynamic> json) => _$WeatherPlaceFromJson(json);

  /// Connect the generated [_$WeatherPlaceToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WeatherPlaceToJson(this);
}