import 'package:flutter/cupertino.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_speeches_details_tab_bloc.dart';

class DeputySpeechesDetailsTab extends StatelessWidget {
  final DeputySpeechesDetailsTabBloc bloc;

  DeputySpeechesDetailsTab(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('speeches')
        ],
      ),
    );
  }
}