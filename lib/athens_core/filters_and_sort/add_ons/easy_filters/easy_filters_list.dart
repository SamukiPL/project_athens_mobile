import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:provider/provider.dart';

class EasyFiltersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EasyFiltersListBloc>(
        builder: (context, bloc, _) => StreamProvider<WidgetState>.value(
              value: bloc.state,
              initialData: WidgetState.empty(),
              child: Consumer<WidgetState>(
                builder: (context, _, child) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(bloc.easyFiltersItems.length, (index) =>
                      bloc.easyFiltersItems[index].buildWidget(index, bloc.easyFiltersItems.length)
                    ),
                  ),
                ),
              ),
            ));
  }
}
