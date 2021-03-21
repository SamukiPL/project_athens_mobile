import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/pagination/paging_list.dart';

class BaseListWidget extends StatelessWidget {

  final BaseListBloc listBloc;
  final String noDataText;

  const BaseListWidget({Key key, this.listBloc, this.noDataText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataLoadingWidget(
      listBloc.dataLoadingBloc,
      child: PagingList(
        listBloc.adapter,
        refreshable: true,
      ),
      noDataText: noDataText,
      onRetry: listBloc.refresh,
    );
  }

}