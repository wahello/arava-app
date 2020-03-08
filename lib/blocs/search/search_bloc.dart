import 'package:arava/blocs/navigation/navigation_bloc.dart';
import 'package:arava/blocs/search/event/search_event.dart';
import 'package:arava/blocs/search/state/search_state.dart';
import 'package:arava/exception/app_exception.dart';
import 'package:arava/model/island/island.dart';
import 'package:arava/model/poi/poi.dart';
import 'package:arava/service/poi_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PoiService poiService;

  GoogleMapController _mapController;

  SearchBloc({@required this.poiService});

  @override
  SearchState get initialState => SearchState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) => event.when(
    searchSubmitEvent: _submit,
    searchSelectIslandEvent: _selectIsland,
    searchMapLoadedEvent: _mapLoaded,
    searchUpdateRequestEvent: _updateSearchRequest,
    searchCameraPositionUpdatedEvent: _cameraUpdated,
    searchSelectPoiEvent: _selectPoi
  );

  void search() {
    add(SearchEvent.searchSubmitEvent());
  }

  void mapLoaded(GoogleMapController googleMapController) {
    add(SearchEvent.searchMapLoadedEvent(
      mapController: googleMapController
    ));
  }

  void selectIsland(Island island) {
    add(SearchEvent.searchSelectIslandEvent(island: island));
  }

  void cameraUpdated(CameraPosition cameraUpdate) {

  }

  void selectPoi(Poi poi) {
    add(SearchEvent.searchSelectPoiEvent(poi: poi));
  }

  void clearSelectedPoi() {
    add(SearchEvent.searchSelectPoiEvent(poi: null));
  }

  Stream<SearchState> _updateSearchRequest(SearchUpdateRequestEvent event) async* {

  }

  Stream<SearchState> _selectPoi(SearchSelectPoiEvent event) async* {
    yield state.withSelectedPoi(event.poi);
  }

  Stream<SearchState> _submit(SearchSubmitEvent event) async* {
    yield state
      .withLoading(true)
      .withResponse(null)
      .withSelectedPoi(null);
    try {
      final searchResponse = await poiService.search(state.request);
      yield state
        .withLoading(false)
        .withResponse(searchResponse);
      if (searchResponse.count > 0) {
        debugPrint(_boundsContainingPois(searchResponse.pois).toString());
        _mapController.animateCamera(CameraUpdate.newLatLngBounds(
          _boundsContainingPois(searchResponse.pois), 16
        ));
      }
    } on AppException catch (exception) {
      yield state
        .withLoading(false)
        .withException(exception);
    }

  }

  Stream<SearchState> _selectIsland(SearchSelectIslandEvent event) async* {
    Modular.get<NavigationBloc>().pop();
    yield state
      .withLoading(true)
      .withIsland(event.island)
      .withRequest(state.request.withIsland(event.island.id));
    if (_mapController != null) {
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(event.island.center.latitude, event.island.center.longitude),
        event.island.zoom
      ));
    }
    try {
      final searchResponse = await poiService.search(state.request);
      yield state
        .withLoading(false)
        .withResponse(searchResponse);
    } on AppException catch (exception) {
      yield state
        .withLoading(false)
        .withException(exception);
    }
  }

  Stream<SearchState> _mapLoaded(SearchMapLoadedEvent event) async* {
    _mapController = event.mapController;
  }

  Stream<SearchState> _cameraUpdated(SearchCameraPositionUpdatedEvent event) async* {

  }

  LatLngBounds _boundsContainingPois(List<Poi> pois) {
    final west = pois
      .reduce((lhs, rhs) => lhs.coordinate.longitude < rhs.coordinate.longitude ? lhs : rhs)
      .coordinate
      .longitude;
    final east = pois
      .reduce((lhs, rhs) => lhs.coordinate.longitude > rhs.coordinate.longitude ? lhs : rhs)
      .coordinate
      .longitude;
    final south = pois
      .reduce((lhs, rhs) => lhs.coordinate.latitude < rhs.coordinate.latitude ? lhs : rhs)
      .coordinate
      .latitude;
    final north = pois
      .reduce((lhs, rhs) => lhs.coordinate.latitude > rhs.coordinate.latitude ? lhs : rhs)
      .coordinate
      .latitude;
    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }
}