import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_information_module.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_speeches_module.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_votings_module.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_information_details_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_speeches_details_tab.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_votings_details_tab.dart';
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
    return DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) => [
                  SliverAppBar(
                    leading: Consumer<DestinationManager>(
                        builder: (context, destinationManager, _) => BackButton(
                              color: Colors.white,
                              onPressed: () {
                                destinationManager.goBack();
                                Navigator.pop(context);
                              },
                            )),
                    key: Key("app-bar"),
                    expandedHeight: 250,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Column(
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
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                      ),
                      background: Container(
                        color: theme.primaryColor,
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(_deputyModel.thumbnailUrl)),
                        ),
                      ),
                    ),
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
                buildDeputyInformationTab(context),
                buildDeputySpeechesTab(context),
                buildDeputyVotingsTab(context),
              ],
            )));
  }

  @override
  String get appBarTitle => _deputyModel.name;

  @override
  BottomNavItem get currentBottomBarItem => _currentBottomBarItem;

  @override
  Widget buildFloatingActionButton(
          BuildContext context, DeputyDetailsBloc bloc) =>
      null;

  @override
  Widget buildAppBar(BuildContext context, DeputyDetailsBloc bloc) => null;

  Widget buildBaseTabContainer(Widget tab) {
    return SingleChildScrollView(
        child: Container(color: Colors.grey.shade200, child: tab));
  }

  Widget buildDeputyInformationTab(BuildContext context) {
    return DeputyInformationDetailsTab();
  }

  Widget buildDeputySpeechesTab(BuildContext context) {
    return DeputySpeechesDetailsTab();
  }

  Widget buildDeputyVotingsTab(BuildContext context) {
    return DeputyVotingsDetailsTab();
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
