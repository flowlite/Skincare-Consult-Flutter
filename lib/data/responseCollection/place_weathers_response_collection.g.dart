// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_weathers_response_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceWeathersResponseCollection _$PlaceWeathersResponseCollectionFromJson(
        Map<String, dynamic> json) =>
    PlaceWeathersResponseCollection(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PlaceWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceWeathersResponseCollectionToJson(
        PlaceWeathersResponseCollection instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
