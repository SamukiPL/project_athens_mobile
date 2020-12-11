import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/no_data/no_data.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud_bloc.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud_state.dart';
import 'package:provider/provider.dart';

class NounCloud extends StatelessWidget {
  final NounCloudBloc bloc;

  const NounCloud({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: bloc.state,
      initialData: CloudLoading(),
      child: Container(
        margin: EdgeInsets.all(16),
        child: Consumer<NounCloudState>(
          builder: (context, state, _) => generateCurrentWidget(context, state),
        ),
      ),
    );
  }

  Widget generateCurrentWidget(BuildContext context, NounCloudState state) {
    switch (state.runtimeType) {
      case CloudReady:
        return generateReadyWidget(context, state);
      case CloudFail:
    }

    return generateLoadingWidget();
  }

  Widget generateLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget generateReadyWidget(BuildContext context, CloudReady state) {
    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    final localizations = Provider.of<AppLocalizations>(context);


    return InteractiveViewer(
      child: Transform.scale(
        scale: 0.85,
        child: state.nounsWidgets.length > 0 ?
        Scatter(
            fillGaps: true,
            delegate: ArchimedeanSpiralScatterDelegate(
              ratio: ratio,
              a: 1.0,
              b: 1.0,
            ),
            children: state.nounsWidgets,
            overflow: Overflow.visible)
        : NoData(
          text: localizations.getText().timelineNounCloudNoNouns(),
          color: Colors.white,
        ),
      ),
    );
  }


}
