import 'package:json_annotation/json_annotation.dart';

import '../entity/place_weather/place_weather.dart';

part 'place_weathers_response_collection.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true, ignoreUnannotated: true)
class PlaceWeathersResponseCollection {
  @JsonKey(name: "data") List<PlaceWeather>? data;

  PlaceWeathersResponseCollection({
    this.data,
  });

  /// Connect the generated [_$PlaceWeathersResponseCollectionFromJson] function to the `fromJson`
  /// factory.
  factory PlaceWeathersResponseCollection.fromJson(Map<String,dynamic> json) => _$PlaceWeathersResponseCollectionFromJson(json);

  /// Connect the generated [_$PlaceWeathersResponseCollectionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlaceWeathersResponseCollectionToJson(this);
}