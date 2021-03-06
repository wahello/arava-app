import 'package:arava/blocs/featured/event/featured_event.dart';
import 'package:arava/blocs/featured/state/featured_state.dart';
import 'package:arava/exception/app_exception.dart';
import 'package:arava/model/island/island.dart';
import 'package:arava/service/poi_service.dart';
import 'package:arava/service/session.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class FeaturedBloc extends Bloc<FeaturedEvent, FeaturedState> {
  final PoiService poiService;
  final Session session;

  FeaturedBloc({@required this.poiService, @required this.session});
  
  @override
  FeaturedState get initialState => FeaturedState.featuredLoadingState();

  @override
  Stream<FeaturedState> mapEventToState(FeaturedEvent event) => event.when(
    featuredLoadSponsoredEvent: _loadSponsored,
    featuredLoadActivitiesEvent: _loadActivities
  );
  
  void loadFeatured(Island island) {
    add(FeaturedEvent.featuredLoadSponsoredEvent(island: island));
  }

  void loadActivities(Island island) {
    add(FeaturedEvent.featuredLoadActivitiesEvent(island: island));
  }
  
  Stream<FeaturedState> _loadSponsored(FeaturedLoadSponsoredEvent event) async* {
    yield FeaturedState.featuredLoadingState();
    try {
      final pois = await poiService.getSponsored(event.island);
      yield FeaturedState.featuredReadyState(pois: pois);
    } on AppException catch (exception) {
      yield FeaturedState.featuredFailingState(exception: exception);
    }
  }

  Stream<FeaturedState> _loadActivities(FeaturedLoadActivitiesEvent event) async* {
    yield FeaturedState.featuredLoadingState();
    try {
      final pois = await poiService.getActivities(event.island);
      yield FeaturedState.featuredReadyState(pois: pois);
    } on AppException catch (exception) {
      yield FeaturedState.featuredFailingState(exception: exception);
    }
  }
}