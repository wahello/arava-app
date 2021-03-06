import 'package:arava/model/poi/poi.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'search_response.g.dart';

@JsonSerializable()
@immutable
class SearchResponse {
  final List<Poi> pois;
  final int count;

  SearchResponse({this.pois, this.count});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}