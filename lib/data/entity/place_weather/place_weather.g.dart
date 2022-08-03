// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceWeather _$PlaceWeatherFromJson(Map<String, dynamic> json) => PlaceWeather(
      id: json['id'] as int?,
      name: json['name'] as String?,
      uvIndex: json['uvIndex'] as int?,
      humidity: json['humidity'] as int?,
      pollution: json['pollution'] as int?,
    );

Map<String, dynamic> _$PlaceWeatherToJson(PlaceWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'uvIndex': instance.uvIndex,
      'humidity': instance.humidity,
      'pollution': instance.pollution,
    };
