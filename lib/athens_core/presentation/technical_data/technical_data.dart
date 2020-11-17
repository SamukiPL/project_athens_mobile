import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/configuration/configuration.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data_bloc.dart';
import 'package:provider/provider.dart';

class TechnicalData extends StatelessWidget {
  final Widget child;
  final String technicalId;

  const TechnicalData({Key key, @required this.technicalId, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final configuration = Provider.of<Configuration>(context);

    return ChangeNotifierProvider<TechnicalDataBloc>(
        create: (_) => TechnicalDataBloc(technicalId: this.technicalId),
        child: Consumer<TechnicalDataBloc>(
            builder: (context, bloc, _) => StreamProvider.value(
                value: configuration.showTechnicalData,
                initialData: false,
                child: Consumer<bool>(
                  builder: (BuildContext context, bool value, Widget child) =>
                      value
                          ? Container(
                              width: double.infinity,
                              child: Text(
                                'Id:' + bloc.technicalId,
                                style: TextStyle(
                                    color: theme.accentColor, fontSize: 9),
                                textAlign: TextAlign.left,
                              ))
                          : Container(),
                ))));
  }
}
