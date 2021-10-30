import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_flow/screens/details/presentation/subscribed_deputy_bar_view.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_information_details_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_speeches_details_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_votings_details_tab.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyDetailsScreen extends BaseScreen<DeputyDetailsBloc> {
  final SubscribedDeputyModel _deputyModel;

  DeputyDetailsScreen(this._deputyModel);

  @override
  Widget buildBody(BuildContext context, DeputyDetailsBloc bloc) {
    final theme = Theme.of(context);
    final localizations = Provider.of<AppLocalizations>(context);
    return DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) => [
                  SliverAppBar(
                    leading: Consumer<DestinationManager>(
                      builder: (context, destinationManager, _) =>
                        BackButton(
                          color: Colors.white,
                          onPressed: () {
                            destinationManager.goBack(context);
                          },
                        )
                    ),
                    key: Key("app-bar"),
                    expandedHeight: 250,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _deputyModel.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  _deputyModel.club ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                      ),
                      background: Container(
                        // color: theme.primaryColor,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: Image.asset("resources/images/parliament/parliament_gathering_512px.jpg").image,
                            fit: BoxFit.cover,
                          )
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4.4, sigmaY: 4.4),
                          child: Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: Image.network(_deputyModel.thumbnailUrl ?? "")),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    toolbarHeight: 0,
                    collapsedHeight: 0,
                    expandedHeight: 0,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(35),
                      child: Container(),
                    ),
                    flexibleSpace: Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: ChangeNotifierProvider<SubscribedDeputyNotificationsNotifier>.value(
                          value: bloc.deputyModel.notifications,
                          child: Consumer<SubscribedDeputyNotificationsNotifier>(
                            builder: (context, notifier, _) => bloc.deputyModel.notifications.isSubscribed
                              ? SubscribedDeputyBarView(bloc.deputyModel)
                              : notObservedDeputyView(bloc, context),
                          ),
                        )
                      ),
                    ),
                    backgroundColor: Colors.white,
                    pinned: true,
                    elevation: 0,
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(TabBar(
                      tabs: [
                        Tab(
                          text: localizations.getText().deputiesInformation(),
                        ),
                        Tab(
                          text: localizations.getText().deputiesSpeeches(),
                        ),
                        Tab(
                          text: localizations.getText().deputiesVotings(),
                        )
                      ],
                    )),
                    pinned: true,
                  )
                ],
            body: TabBarView(
              children: <Widget>[
                buildDeputyInformationTab(context, bloc),
                buildDeputySpeechesTab(context),
                buildDeputyVotingsTab(context),
              ],
            )));
  }

  @override
  String get appBarTitle => _deputyModel.name;

  @override
  Widget? buildFloatingActionButton(
          BuildContext context, DeputyDetailsBloc bloc) =>
      null;

  @override
  Widget? buildAppBar(BuildContext context, DeputyDetailsBloc bloc) => null;

  Widget buildBaseTabContainer(Widget tab) {
    return SingleChildScrollView(
        child: Container(color: Colors.grey.shade200, child: tab));
  }

  Widget buildDeputyInformationTab(BuildContext context, DeputyDetailsBloc bloc) {
    return DeputyInformationDetailsTab(bloc.deputyModel);
  }

  Widget buildDeputySpeechesTab(BuildContext context) {
    return DeputySpeechesDetailsTab();
  }

  Widget buildDeputyVotingsTab(BuildContext context) {
    return DeputyVotingsDetailsTab();
  }

  Widget notObservedDeputyView(DeputyDetailsBloc bloc, BuildContext context) {
    final theme = Theme.of(context);
    final localizations = Provider.of<AppLocalizations>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            localizations.getText().deputiesNotSubscribingDeputy(),
            style: TextStyle(
                color: theme.dividerColor,
                fontSize: 14
            ),
          ),
          MaterialButton(
            onPressed: () => bloc.deputyModel.notifications.setIsSubscribed(!bloc.deputyModel.notifications.isSubscribed),
            child: Row(
              children: [
                Text(
                  localizations.getText().deputiesSubscribe(),
                  style: TextStyle(color: theme.primaryColor),
                ),
                Icon(MdiIcons.bookmarkPlusOutline, color: theme.primaryColor,)
              ]
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: theme.primaryColor)
            ),
          ),
        ]
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
      color: Colors.white,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
