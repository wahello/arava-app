import 'package:arava/blocs/global_context/global_context_bloc.dart';
import 'package:arava/blocs/global_context/state/global_context_state.dart';
import 'package:arava/blocs/navigation/navigation_bloc.dart';
import 'package:arava/blocs/search/search_bloc.dart';
import 'package:arava/blocs/search/state/search_state.dart';
import 'package:arava/i18n/app_localizations.dart';
import 'package:arava/model/poi/poi.dart';
import 'package:arava/widgets/app/app_configuration_provider.dart';
import 'package:arava/widgets/poi/poi_details.dart';
import 'package:arava/widgets/poi/poi_preview.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatefulWidget {
  Map({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Map();
}


class _Map extends State<Map> {
  final SearchBloc _searchBloc = Modular.get();
  final GlobalContextBloc _globalContextBloc = Modular.get();
  final Key _selectedPoiDismissibleKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _searchBloc.search();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: BlocListener<GlobalContextBloc, GlobalContextState>(
        bloc: _globalContextBloc,
        condition: (previous, current) {
          return previous.selectedIsland.id != current.selectedIsland.id;
        },
        listener: (context, state) {
          final selectedIsland = state.selectedIsland;
          _searchBloc.selectIsland(selectedIsland);
        },
        child: BlocBuilder<GlobalContextBloc, GlobalContextState>(
          bloc: _globalContextBloc,
          builder: (context, globalContext) {
            final selectedIsland = globalContext.selectedIsland;
            return BlocListener<SearchBloc, SearchState>(
              bloc: _searchBloc,
              listener: (context, state) {
                if (state.exception != null) {
                  FlushbarHelper.createError(
                    message: state.exception.getLocalizedMessage(context)
                  )..show(context);
                }
              },
              child: BlocBuilder<SearchBloc, SearchState>(
                bloc: _searchBloc,
                builder: (context, state) => Stack(
                  children: <Widget>[
                    GoogleMap(
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          selectedIsland.center.latitude,
                          selectedIsland.center.longitude
                        ),
                        zoom: selectedIsland.zoom
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _searchBloc.mapLoaded(controller);
                        String brightness = MediaQuery.of(context).platformBrightness == Brightness.dark ?
                        "dark" :
                        "light";
                        rootBundle.loadString("assets/map_styles/$brightness.json")
                          .then((string) => controller.setMapStyle(string));
                      },
                      onCameraIdle: () => _searchBloc.cameraIdle(),
                      myLocationEnabled: true,
                      markers: state.response?.pois
                        ?.map((poi) => Marker(
                        markerId: MarkerId(poi.id),
                        position: LatLng(
                          poi.coordinate.latitude,
                          poi.coordinate.longitude
                        ),
                        onTap: () => _searchBloc.selectPoi(poi),
                        icon: _iconForPoi(globalContext, poi)
                      ))
                        ?.toSet(),
                    ),
                    if (state.loading)
                      Positioned(
                        top: 0, right: 0, left: 0, height: 4,
                        child: LinearProgressIndicator()
                      ),
                    Positioned(
                      bottom: 16, right: 16,
                      child: FloatingActionButton.extended(
                        onPressed: () => Modular.get<NavigationBloc>().push("/search/filters"),
                        label: Text(AppLocalizations.of(context).search_Filter()),
                        icon: Icon(Icons.filter_list),
                      ),
                    ),
                    if (state.regionDidChange)
                      Positioned(
                        top: 8, left: 8, right: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                              ),
                              onPressed: () => _searchBloc.search(),
                              color: Theme.of(context)
                                .primaryColor,
                              label: Text(AppLocalizations.of(context).search_SearchThisArea()),
                              icon: Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      ),
                    if (state.selectedPoi != null)
                      Positioned(
                        bottom: 8, left: 8, right: 8,
                        child: GestureDetector(
                          onTap: () {
                            Modular.get<NavigationBloc>().pushRoute(MaterialPageRoute(
                              builder: (BuildContext context) => PoiDetails(poi: state.selectedPoi)
                            ));
                          },
                          child: Dismissible(
                            key: _selectedPoiDismissibleKey,
                            direction: DismissDirection.down,
                            onDismissed: (_) => _searchBloc.clearSelectedPoi(),
                            child: Stack(
                              children: <Widget>[
                                PoiPreview(poi: state.selectedPoi),
                                Positioned(
                                  top: 16, left: 16, right: 16,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 4,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: Theme.of(context).textTheme.title.color
                                        ),
                                      )
                                    ],
                                  )
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        ),
      )
    );
  }

  BitmapDescriptor _iconForPoi(GlobalContextState globalContext, Poi poi) {
    final pinsMap = globalContext.configuration.pinsMap;
    final sponsoredPinsMap = globalContext.configuration.sponsoredPinsMap;
    if (poi.sponsored) {
      return sponsoredPinsMap.containsKey(poi.theme.id) ?
        sponsoredPinsMap[poi.theme.id] :
        AppConfigurationProvider.of(context).defaultSponsoredPinBitmapDescriptor;
    }
    return pinsMap.containsKey(poi.theme.id) ?
      pinsMap[poi.theme.id] :
      AppConfigurationProvider.of(context).defaultPinBitmapDescriptor;
  }
}