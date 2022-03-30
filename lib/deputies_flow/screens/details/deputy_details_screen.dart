import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_flow/screens/details/presentation/subscribed_deputy_bar_view.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_acitivities_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_information_details_tab.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:project_athens/guest_flow/domain/logged_state.dart';
import 'package:provider/provider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

class DeputyDetailsScreen extends BaseScreen<DeputyDetailsBloc> {
  final SubscribedDeputyModel _deputyModel;

  DeputyDetailsScreen(this._deputyModel);

  @override
  Widget buildBody(BuildContext context, DeputyDetailsBloc bloc) {
    final localizations = Provider.of<AppLocalizations>(context);

    final double statusBarHeight = MediaQuery.of(context).padding.top;
//var tabBarHeight = primaryTabBar.preferredSize.height;
    var pinnedHeaderHeight =
//statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            (kToolbarHeight * 2);

    return DefaultTabController(
        length: 2,
        child: ExtendedNestedScrollView(
            // onlyOneScrollInBody: true,
            pinnedHeaderSliverHeightBuilder: () {
              return pinnedHeaderHeight;
            },
            headerSliverBuilder: (context, value) => [
                  SliverAppBar(
                    leading: Consumer<DestinationManager>(
                        builder: (context, destinationManager, _) => BackButton(
                              color: Colors.white,
                              onPressed: () {
                                destinationManager.goBack(context);
                              },
                            )),
                    key: Key("app-bar"),
                    expandedHeight: 250,
                    pinned: true,
                    primary: true,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: 6),
                      title: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: _deputyModel.name,
                              style: TextStyle(
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                              children: [
                                TextSpan(
                                    text: _deputyModel.club != null ? '\n' + _deputyModel.club! : "",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w400))
                              ])),
                      background: Container(
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                          image: Image.asset("resources/images/parliament/parliament_gathering_512px.jpg").image,
                          fit: BoxFit.cover,
                        )),
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
                  buildObserverDeputyView(bloc, context),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(TabBar(
                      tabs: [
                        Tab(
                          text: localizations.getText().deputiesInformation(),
                        ),
                        Tab(text: localizations.getText().deputiesActivities())
                      ],
                    )),
                    pinned: true,
                  )
                ].where((element) => element != null).cast<Widget>().toList(),
            body: TabBarView(
              children: <Widget>[
                buildDeputyInformationTab(context, bloc),
                buildDeputyActivitiesTab(context, bloc),
              ],
            )));
  }

  @override
  String get appBarTitle => _deputyModel.name;

  @override
  Widget? buildFloatingActionButton(BuildContext context, DeputyDetailsBloc bloc) => null;

  @override
  Widget? buildAppBar(BuildContext context, DeputyDetailsBloc bloc) => null;

  Widget buildBaseTabContainer(Widget tab) {
    return SingleChildScrollView(child: Container(color: Colors.grey.shade200, child: tab));
  }

  Widget buildDeputyInformationTab(BuildContext context, DeputyDetailsBloc bloc) {
    return DeputyInformationDetailsTab(bloc.deputyModel);
  }

  Widget buildDeputyActivitiesTab(BuildContext context, DeputyDetailsBloc bloc) {
    return DeputyActivitiesTab(bloc.deputyModel);
  }

  Widget? buildObserverDeputyView(DeputyDetailsBloc bloc, BuildContext context) {
    final loggedState = Provider.of<LoggedState>(context);
    if (loggedState.isGuest) return null;

    return SliverAppBar(
      toolbarHeight: 0,
      collapsedHeight: 0,
      expandedHeight: 0,
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
            )),
      ),
      backgroundColor: Colors.white,
      pinned: true,
      elevation: 0,
    );
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
              style: TextStyle(color: theme.dividerColor, fontSize: 14),
            ),
            MaterialButton(
              onPressed: () =>
                  bloc.deputyModel.notifications.setIsSubscribed(!bloc.deputyModel.notifications.isSubscribed),
              child: Row(children: [
                Text(
                  localizations.getText().deputiesSubscribe(),
                  style: TextStyle(color: theme.primaryColor),
                ),
                Icon(
                  MdiIcons.bookmarkPlusOutline,
                  color: theme.primaryColor,
                )
              ]),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32), side: BorderSide(color: theme.primaryColor)),
            ),
          ]),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
