import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/ads/domain/are_ads_enabled_use_case.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_provider.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ads.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list_bloc.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_flow/data/deputies_easy_filters_repository.dart';
import 'package:project_athens/deputies_flow/data/deputies_list_data_source.dart';
import 'package:project_athens/deputies_flow/domain/deputie_list_facade.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputy_item_view_model_factory.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:provider/provider.dart';

class DeputiesListModule extends Module {
  DeputiesListModule(BuildContext context) : super(context);

  late final BaseListBloc _bloc;
  late final EasyFiltersListBloc _filtersListBloc;

  @override
  List<SingleChildWidget> getProviders() {
    final clubsCache = Provider.of<ParliamentClubsCache>(context);
    final subscribedDeputiesCache = Provider.of<SubscribedDeputiesCache>(
        context);
    final _localizations = Provider.of<AppLocalizations>(context);

    final deputiesDataSource = DeputiesListDataSource(subscribedDeputiesCache);
    final deputiesEasyFiltersRepository = DeputiesEasyFiltersRepository(
        clubsCache, _localizations);

    final deputiesListRepository = ItemsRepositoryImpl(deputiesDataSource);
    final listFacade = DeputiesListFacade(
        deputiesListRepository, deputiesEasyFiltersRepository);
    final itemFactory = DeputyItemViewModelFactory();

    _bloc = BaseListBloc(listFacade, itemFactory);
    _filtersListBloc = EasyFiltersListBloc(listFacade);

    return [
      Provider<BaseListBloc>.value(
        value: _bloc,
      ),
      Provider<SearchAppBarFacade>.value(value: listFacade),
      Provider<EasyFiltersListBloc>.value(
          value: _filtersListBloc),
      Provider<NativeAdProvider>(
        create: (_) {
          final areAdsEnabledUseCase = Provider.of<AreAdsEnabledUseCase>(context, listen: false);

          return NativeAdProvider(NativeAds.deputyAd, areAdsEnabledUseCase);
        },
        dispose: (_, provider) => provider.dispose(),
      )
    ];
  }

  @override
  void dispose() {
    _bloc.dispose();
    _filtersListBloc.dispose();
  }
}
