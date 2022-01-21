import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list_bloc.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/dashboard_flow/data/dashboard_notifications_easy_filters_repository.dart';
import 'package:project_athens/dashboard_flow/data/dashboard_notifications_list_data_source.dart';
import 'package:project_athens/dashboard_flow/data/get_notifications_repository_impl.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_list_facade.dart';
import 'package:project_athens/dashboard_flow/domain/notifications/get_notifications_use_case.dart';
import 'package:project_athens/dashboard_flow/screens/notifications_screen/list_impl/notification_item_view_model_factory.dart';
import 'package:provider/provider.dart';

class DashboardNotificationsModule extends Module {
  DashboardNotificationsModule(BuildContext context) : super(context);

  late final BaseListBloc _bloc;
  late final EasyFiltersListBloc _filtersListBloc;

  @override
  List<SingleChildWidget> getProviders() {
    final _localizations = Provider.of<AppLocalizations>(context);

    final GetNotificationsRepositoryImpl _repository = GetNotificationsRepositoryImpl();
    final GetNotificationsUseCase _getNotificationUseCase = GetNotificationsUseCase(_repository);

    final notificationsListDataSource = DashboardNotificationsListDataSource(_getNotificationUseCase);
    final notificationsEasyFiltersRepository = DashboardNotificationsEasyFiltersRepository(
        _localizations);

    final notificationsListRepository = ItemsRepositoryImpl(notificationsListDataSource);
    final listFacade = DashboardNotificationsListFacade(
        notificationsListRepository, notificationsEasyFiltersRepository);
    final itemFactory = NotificationItemViewModelFactory();

    _bloc = BaseListBloc(listFacade, itemFactory);
    _filtersListBloc = EasyFiltersListBloc(listFacade);

    return [
      Provider<BaseListBloc>.value(
        value: _bloc,
      ),
      Provider<SearchAppBarFacade>.value(value: listFacade),
      Provider<EasyFiltersListBloc>.value(
          value: _filtersListBloc)
    ];
  }

  @override
  void dispose() {
    _bloc.dispose();
    _filtersListBloc.dispose();
  }
}
