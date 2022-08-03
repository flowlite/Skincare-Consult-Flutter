import 'package:json_annotation/json_annotation.dart';

part 'place_weather.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true, ignoreUnannotated: true)
class PlaceWeather {
  @JsonKey(name: "id") int? id;
  @JsonKey(name: "name") String? name;
  @JsonKey(name: "uvIndex") int? uvIndex;
  @JsonKey(name: "humidity") int? humidity;
  @JsonKey(name: "pollution") int? pollution;

  PlaceWeather({
    this.id,
    this.name,
    this.uvIndex,
    this.humidity,
    this.pollution,
  });

  /// Connect the generated [_$PlaceWeatherFromJson] function to the `fromJson`
  /// factory.
  factory PlaceWeather.fromJson(Map<String,dynamic> json) => _$PlaceWeatherFromJson(json);

  /// Connect the generated [_$PlaceWeatherToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlaceWeatherToJson(this);
}