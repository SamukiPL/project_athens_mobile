import 'package:flutter/cupertino.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_votings_details_tab_bloc.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';

class DeputyVotingsDetailsTab extends StatelessWidget {
  final DeputyVotingsDetailsTabBloc bloc;
  
  DeputyVotingsDetailsTab(this.bloc) {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text('votings'),
      ])
    );
  }
}