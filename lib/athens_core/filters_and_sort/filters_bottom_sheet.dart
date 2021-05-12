import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/filters_bloc.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:provider/provider.dart';

void showFilterBottomSheet(BuildContext parentContext) {
  showModalBottomSheet(
    context: parentContext,
    builder: (childContext) => _FiltersBottomSheet(
      parentContext: parentContext,
    ),
    isScrollControlled: true
  );
}

class _FiltersBottomSheet extends StatelessWidget {

  final BuildContext parentContext;

  const _FiltersBottomSheet({Key key, this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);
    final filterableFacade = Provider.of<FilterableFacade>(parentContext);
    final bloc = FiltersBloc(filterableFacade);

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(parentContext).padding.top),
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: Text(localizations().filtersTitle()),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                bloc.acceptFilters();
                Navigator.pop(context);
              }
            )
          ],
        ),
        body: StreamProvider<WidgetState>.value(
          value: bloc.state,
          child: Consumer<WidgetState>(
            builder: (context, _, child) => ListView.builder(
              itemBuilder: (context, index) => bloc.filters[index].buildFilter(parentContext),
              itemCount: bloc.filters.length,
            ),
          ),
        ),
      ),
    );
  }

}