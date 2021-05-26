import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud_bloc.dart';
import 'package:provider/provider.dart';

class NounCloud extends StatelessWidget {
  final NounCloudBloc bloc;

  const NounCloud({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);

    return StreamProvider<List<Widget>>.value(
      value: bloc.widgets,
      initialData: [],
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 220,
          maxWidth: double.infinity
        ),
        child: Center(
          child: DataLoadingWidget(
            bloc.dataLoadingBloc,
            child: Consumer<List<Widget>>(
              builder: (context, widgets, _) => generateReadyWidget(context, widgets),
            ),
            onRetry: null,
            noDataText: localizations.getText().timelineNounCloudNoNouns(),
            color: Colors.white,
            invertLoaderColor: true,
          ),
        )

      )

    );
  }

  Widget generateReadyWidget(BuildContext context, List<Widget> widgets) {
    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    return InteractiveViewer(
      child: Transform.scale(
        scale: 0.85,
        child: Scatter(
            fillGaps: true,
            delegate: ArchimedeanSpiralScatterDelegate(
              ratio: ratio,
              a: 1.0,
              b: 1.0,
            ),
            children: widgets,
            overflow: Overflow.visible),
      ),
    );
  }


}
