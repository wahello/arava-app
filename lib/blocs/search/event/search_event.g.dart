// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent(this._type);

  factory SearchEvent.searchSubmitEvent() = SearchSubmitEvent;

  factory SearchEvent.searchSelectIslandEvent({@required Island island}) =
      SearchSelectIslandEvent;

  factory SearchEvent.searchMapLoadedEvent(
      {@required GoogleMapController mapController}) = SearchMapLoadedEvent;

  factory SearchEvent.searchCameraPositionUpdatedEvent(
          {@required LatLngBounds cameraPosition}) =
      SearchCameraPositionUpdatedEvent;

  factory SearchEvent.searchSelectPoiEvent({@required Poi poi}) =
      SearchSelectPoiEvent;

  factory SearchEvent.searchSetFiltersEvent(
      {@required SearchFilters searchFilters}) = SearchSetFiltersEvent;

  final _SearchEvent _type;

//ignore: missing_return
  R when<R>(
      {@required
          FutureOr<R> Function(SearchSubmitEvent) searchSubmitEvent,
      @required
          FutureOr<R> Function(SearchSelectIslandEvent) searchSelectIslandEvent,
      @required
          FutureOr<R> Function(SearchMapLoadedEvent) searchMapLoadedEvent,
      @required
          FutureOr<R> Function(SearchCameraPositionUpdatedEvent)
              searchCameraPositionUpdatedEvent,
      @required
          FutureOr<R> Function(SearchSelectPoiEvent) searchSelectPoiEvent,
      @required
          FutureOr<R> Function(SearchSetFiltersEvent) searchSetFiltersEvent}) {
    assert(() {
      if (searchSubmitEvent == null ||
          searchSelectIslandEvent == null ||
          searchMapLoadedEvent == null ||
          searchCameraPositionUpdatedEvent == null ||
          searchSelectPoiEvent == null ||
          searchSetFiltersEvent == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SearchEvent.SearchSubmitEvent:
        return searchSubmitEvent(this as SearchSubmitEvent);
      case _SearchEvent.SearchSelectIslandEvent:
        return searchSelectIslandEvent(this as SearchSelectIslandEvent);
      case _SearchEvent.SearchMapLoadedEvent:
        return searchMapLoadedEvent(this as SearchMapLoadedEvent);
      case _SearchEvent.SearchCameraPositionUpdatedEvent:
        return searchCameraPositionUpdatedEvent(
            this as SearchCameraPositionUpdatedEvent);
      case _SearchEvent.SearchSelectPoiEvent:
        return searchSelectPoiEvent(this as SearchSelectPoiEvent);
      case _SearchEvent.SearchSetFiltersEvent:
        return searchSetFiltersEvent(this as SearchSetFiltersEvent);
    }
  }

  R whenOrElse<R>(
      {FutureOr<R> Function(SearchSubmitEvent) searchSubmitEvent,
      FutureOr<R> Function(SearchSelectIslandEvent) searchSelectIslandEvent,
      FutureOr<R> Function(SearchMapLoadedEvent) searchMapLoadedEvent,
      FutureOr<R> Function(SearchCameraPositionUpdatedEvent)
          searchCameraPositionUpdatedEvent,
      FutureOr<R> Function(SearchSelectPoiEvent) searchSelectPoiEvent,
      FutureOr<R> Function(SearchSetFiltersEvent) searchSetFiltersEvent,
      @required FutureOr<R> Function(SearchEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _SearchEvent.SearchSubmitEvent:
        if (searchSubmitEvent == null) break;
        return searchSubmitEvent(this as SearchSubmitEvent);
      case _SearchEvent.SearchSelectIslandEvent:
        if (searchSelectIslandEvent == null) break;
        return searchSelectIslandEvent(this as SearchSelectIslandEvent);
      case _SearchEvent.SearchMapLoadedEvent:
        if (searchMapLoadedEvent == null) break;
        return searchMapLoadedEvent(this as SearchMapLoadedEvent);
      case _SearchEvent.SearchCameraPositionUpdatedEvent:
        if (searchCameraPositionUpdatedEvent == null) break;
        return searchCameraPositionUpdatedEvent(
            this as SearchCameraPositionUpdatedEvent);
      case _SearchEvent.SearchSelectPoiEvent:
        if (searchSelectPoiEvent == null) break;
        return searchSelectPoiEvent(this as SearchSelectPoiEvent);
      case _SearchEvent.SearchSetFiltersEvent:
        if (searchSetFiltersEvent == null) break;
        return searchSetFiltersEvent(this as SearchSetFiltersEvent);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(SearchSubmitEvent) searchSubmitEvent,
      FutureOr<void> Function(SearchSelectIslandEvent) searchSelectIslandEvent,
      FutureOr<void> Function(SearchMapLoadedEvent) searchMapLoadedEvent,
      FutureOr<void> Function(SearchCameraPositionUpdatedEvent)
          searchCameraPositionUpdatedEvent,
      FutureOr<void> Function(SearchSelectPoiEvent) searchSelectPoiEvent,
      FutureOr<void> Function(SearchSetFiltersEvent) searchSetFiltersEvent}) {
    assert(() {
      if (searchSubmitEvent == null &&
          searchSelectIslandEvent == null &&
          searchMapLoadedEvent == null &&
          searchCameraPositionUpdatedEvent == null &&
          searchSelectPoiEvent == null &&
          searchSetFiltersEvent == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _SearchEvent.SearchSubmitEvent:
        if (searchSubmitEvent == null) break;
        return searchSubmitEvent(this as SearchSubmitEvent);
      case _SearchEvent.SearchSelectIslandEvent:
        if (searchSelectIslandEvent == null) break;
        return searchSelectIslandEvent(this as SearchSelectIslandEvent);
      case _SearchEvent.SearchMapLoadedEvent:
        if (searchMapLoadedEvent == null) break;
        return searchMapLoadedEvent(this as SearchMapLoadedEvent);
      case _SearchEvent.SearchCameraPositionUpdatedEvent:
        if (searchCameraPositionUpdatedEvent == null) break;
        return searchCameraPositionUpdatedEvent(
            this as SearchCameraPositionUpdatedEvent);
      case _SearchEvent.SearchSelectPoiEvent:
        if (searchSelectPoiEvent == null) break;
        return searchSelectPoiEvent(this as SearchSelectPoiEvent);
      case _SearchEvent.SearchSetFiltersEvent:
        if (searchSetFiltersEvent == null) break;
        return searchSetFiltersEvent(this as SearchSetFiltersEvent);
    }
  }

  @override
  List get props => const [];
}

@immutable
class SearchSubmitEvent extends SearchEvent {
  const SearchSubmitEvent._() : super(_SearchEvent.SearchSubmitEvent);

  factory SearchSubmitEvent() {
    _instance ??= SearchSubmitEvent._();
    return _instance;
  }

  static SearchSubmitEvent _instance;
}

@immutable
class SearchSelectIslandEvent extends SearchEvent {
  const SearchSelectIslandEvent({@required this.island})
      : super(_SearchEvent.SearchSelectIslandEvent);

  final Island island;

  @override
  String toString() => 'SearchSelectIslandEvent(island:${this.island})';
  @override
  List get props => [island];
}

@immutable
class SearchMapLoadedEvent extends SearchEvent {
  const SearchMapLoadedEvent({@required this.mapController})
      : super(_SearchEvent.SearchMapLoadedEvent);

  final GoogleMapController mapController;

  @override
  String toString() =>
      'SearchMapLoadedEvent(mapController:${this.mapController})';
  @override
  List get props => [mapController];
}

@immutable
class SearchCameraPositionUpdatedEvent extends SearchEvent {
  const SearchCameraPositionUpdatedEvent({@required this.cameraPosition})
      : super(_SearchEvent.SearchCameraPositionUpdatedEvent);

  final LatLngBounds cameraPosition;

  @override
  String toString() =>
      'SearchCameraPositionUpdatedEvent(cameraPosition:${this.cameraPosition})';
  @override
  List get props => [cameraPosition];
}

@immutable
class SearchSelectPoiEvent extends SearchEvent {
  const SearchSelectPoiEvent({@required this.poi})
      : super(_SearchEvent.SearchSelectPoiEvent);

  final Poi poi;

  @override
  String toString() => 'SearchSelectPoiEvent(poi:${this.poi})';
  @override
  List get props => [poi];
}

@immutable
class SearchSetFiltersEvent extends SearchEvent {
  const SearchSetFiltersEvent({@required this.searchFilters})
      : super(_SearchEvent.SearchSetFiltersEvent);

  final SearchFilters searchFilters;

  @override
  String toString() =>
      'SearchSetFiltersEvent(searchFilters:${this.searchFilters})';
  @override
  List get props => [searchFilters];
}
