// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) {
  return SearchResponse(
    pois: (json['pois'] as List)
        ?.map((e) => e == null ? null : Poi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'pois': instance.pois,
      'count': instance.count,
    };
