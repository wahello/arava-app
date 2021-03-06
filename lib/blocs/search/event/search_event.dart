import 'package:arava/model/island/island.dart';
import 'package:arava/model/poi/poi.dart';
import 'package:arava/model/search_filters/search_filters.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show GoogleMapController, LatLngBounds;
import 'package:super_enum/super_enum.dart';

part 'search_event.g.dart';

@superEnum
enum _SearchEvent {
  @object
  SearchSubmitEvent,
  @Data(fields: [
    DataField<Island>('island')
  ])
  SearchSelectIslandEvent,
  @Data(fields: [
    DataField<GoogleMapController>('mapController')
  ])
  SearchMapLoadedEvent,
  @Data(fields: [
    DataField<LatLngBounds>('cameraPosition')
  ])
  SearchCameraPositionUpdatedEvent,
  @Data(fields: [
    DataField<Poi>('poi')
  ])
  SearchSelectPoiEvent,
  @Data(fields: [
    DataField<SearchFilters>('searchFilters')
  ])
  SearchSetFiltersEvent
}