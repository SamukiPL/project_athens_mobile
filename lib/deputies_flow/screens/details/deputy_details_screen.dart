import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/async_once/async_once.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/full_card/full_card.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_information_details_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_information_details_tab_bloc.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_speeches_details_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_speeches_details_tab_bloc.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_votings_details_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_votings_details_tab_bloc.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyDetailsScreen extends BaseScreen<DeputyDetailsBloc> {

  final DeputyModel _deputyModel;

  final BottomNavItem _currentBottomBarItem;

  DeputyDetailsScreen(this._deputyModel, this._currentBottomBarItem);

  @override
  Widget buildBody(BuildContext context, DeputyDetailsBloc bloc) {
    final theme = Theme.of(context);
    final localizations = Provider.of<AppLocalizations>(context);

    final deputiesCache = Provider.of<DeputiesCache>(context);

    return DefaultTabController(length: 3, child:
      CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Consumer<DestinationManager>(
                builder: (context, destinationManager, _) => BackButton(
                  color: Colors.white,
                  onPressed: () {
                    destinationManager.goBack();
                    Navigator.pop(context);
                  },
                )
            ),
            key: Key("app-bar"),
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // collapseMode: CollapseMode.pin,
              title: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _deputyModel.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _deputyModel.club,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        )
                ),
              ),
              background: Container(
                color: theme.primaryColor,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(_deputyModel.thumbnailUrl)
                  ),
                ),
              ),
            ),
          ),
          SliverAppBar(
            leading: Container(),
            pinned: true,
            // deletes the top padding of AppBar that is created by SliverAppBar
            primary: false,
            toolbarHeight: 48.5,
            titleSpacing: 0,
            title:
            TabBar(
                tabs: [
                  Tab(
                    text: localizations.getText().deputiesInformation(),
                    // child: buildDeputyInformationTab(context),
                  ),
                  Tab(
                    text: localizations.getText().deputiesSpeeches(),
                    // child: buildDeputySpeechesTab(context),
                  ),
                  Tab(
                      text: localizations.getText().deputiesVotings(),

                  )
                ]
              ),
            backgroundColor: Colors.white,
            leadingWidth: 0,
          ),
          SliverFillRemaining(
            child:
              AsyncOnce<DeputyFull>(
                  asyncSource: deputiesCache.getDeputyFull(_deputyModel.id),
                  child: (context, deputyFull) => TabBarView(
                    children: <Widget>[
                      buildDeputyInformationTab(context, deputyFull),
                      buildDeputySpeechesTab(context, deputyFull),
                      buildDeputyVotingsTab(context, deputyFull),
                    ],
                  )

              )
            // FutureProvider(
            //   create: (context) => deputiesCache.getDeputyFull(_deputyModel.id),
            //   child: Consumer<Success<DeputyFull>>(
            //     builder: (providerContext, deputyFull, _) =>
            //       deputyFull != null ?
            //       TabBarView(
            //         children: <Widget>[
            //           buildDeputyInformationTab(context, deputyFull.value),
            //           buildDeputySpeechesTab(context, deputyFull.value),
            //           buildDeputyVotingsTab(context, deputyFull.value),
            //         ],
            //       ) : Container(),
            //   )
            // ),
          )
        ],
      )
    );
  }

  @override
  String get appBarTitle => _deputyModel.name;

  @override
  BottomNavItem get currentBottomBarItem => _currentBottomBarItem;

  @override
  Widget buildFloatingActionButton(
      BuildContext context, DeputyDetailsBloc bloc) => null;

  @override
  Widget buildAppBar(BuildContext context, DeputyDetailsBloc bloc) => null;

  Widget buildBaseTabContainer(Widget tab) {
    return SingleChildScrollView(
        child: Container(
            color: Colors.grey.shade200,
            child: tab
        )
    );
  }


  Widget buildDeputyInformationTab(BuildContext context, DeputyFull deputyFull) {
    final deputiesCache = Provider.of<DeputiesCache>(context);

    final bloc = DeputyInformationDetailsTabBloc(deputyFull, deputiesCache);
    return buildBaseTabContainer(
      DeputyInformationDetailsTab(bloc)
      // FullCard(
      //   // child: Expanded(
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: Column(
      //             children: [
      //               Text("Data urodzenia"),
      //               Text(deputyFull.cv.born)
      //             ],
      //           )
      //         ),
      //
      //         Expanded(
      //           child: Column(
      //           children: [
      //               Text("Wykształcenie"),
      //               Text(deputyFull.cv.education)
      //             ],
      //           )
      //         ),
      //         Expanded(
      //           child: Column(
      //             children: [
      //               Text("Zawód"),
      //               Text(deputyFull.cv.profession)
      //             ],
      //           )
      //         )
      //       ],
      //     )
      //   // )
      //
      // )
    );
  }

  Widget buildDeputySpeechesTab(BuildContext context, DeputyFull deputyFull) {
    final DeputySpeechesDetailsTabBloc bloc = DeputySpeechesDetailsTabBloc(deputyFull);
    return DeputySpeechesDetailsTab(bloc);
  }

  Widget buildDeputyVotingsTab(BuildContext context, DeputyFull deputyFull) {
    final DeputyVotingsDetailsTabBloc bloc = DeputyVotingsDetailsTabBloc(deputyFull);
    return DeputyVotingsDetailsTab(bloc);
  }

}

// class Delegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) =>
//       TabBar(
//                 tabs: [
//                   Tab(
//                     text: "Informacje",
//                     // child: buildDeputyInformationTab(context),
//                   ),
//                   Tab(
//                     text: "Wypowiedzi",
//                     // child: buildDeputySpeechesTab(context),
//                   ),
//                   Tab(
//                       text: "Głosowania",
//
//                   )
//                 ]
//               );
//
//   @override
//   double get maxExtent => 60;
//
//   @override
//   double get minExtent => 30;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }