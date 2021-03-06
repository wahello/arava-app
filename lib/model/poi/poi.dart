import 'package:arava/model/comment/comment.dart';
import 'package:arava/model/lat_lng/lat_lng.dart';
import 'package:arava/model/media/media.dart';
import 'package:arava/model/poi_details/poi_details.dart';
import 'package:arava/model/poi_type/poi_type.dart';
import 'package:arava/model/ratings/ratings.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'poi.g.dart';

@JsonSerializable()
@immutable
class Poi {
  final String id;
  final String island;
  final String title;
  final PoiDetails details;
  final PoiTheme theme;
  final String description;
  final bool featured;
  final bool sponsored;
  final LatLng coordinate;
  final Media mainImage;
  final List<Media> medias;
  final List<Comment> comments;
  final Ratings ratings;

  Poi({
    this.id, this.island, this.featured, this.details,
    this.sponsored, this.title, this.mainImage,
    this.theme, this.coordinate, this.description,
    this.medias, this.comments, this.ratings
  });

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);
  Map<String, dynamic> toJson() => _$PoiToJson(this);
}