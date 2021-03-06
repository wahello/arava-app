import 'package:arava/blocs/global_context/global_context_bloc.dart';
import 'package:arava/blocs/navigation/navigation_bloc.dart';
import 'package:arava/i18n/app_localizations.dart';
import 'package:arava/widgets/app/app_configuration_provider.dart';
import 'package:arava/widgets/map/island_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class IslandSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IslandSelectorState();
}


class _IslandSelectorState extends State<IslandSelector> {
  List<Widget> _archipelagoWidgets;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _archipelagoWidgets = AppConfigurationProvider.of(context)
      .archipelagos
      .map((archipelago) {
        final islandCards = archipelago.islands
          .map((island) => IslandCard(
            island: island,
            onSelected: () {
              Modular.get<GlobalContextBloc>().updateSelectedIsland(island);
              Modular.get<NavigationBloc>().pop();
            },
          ))
          .toList();
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                archipelago.name.toUpperCase(),
                style: Theme.of(context).textTheme.headline
                  .copyWith(
                    fontSize: 16
                  ),
              ),
            ),
            StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: islandCards.length,
              itemBuilder: (BuildContext context, int index) => islandCards[index],
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            )
          ],
        );
      })
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).search_SelectIsland()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            children: _archipelagoWidgets,
          ),
        ),
      )
    );
  }
}