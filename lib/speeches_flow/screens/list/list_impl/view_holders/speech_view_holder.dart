import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model.dart';

class SpeechViewHolder extends StatelessWidget {

  final SpeechItemViewModel _viewModel;

  const SpeechViewHolder(this._viewModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getThumbnail(theme),
        getItemCard(context, theme)
      ],
    );
  }

  Widget getThumbnail(ThemeData theme) {
    return Hero(
      tag: _viewModel.model.id,
      child: Container(
        margin: EdgeInsets.all(8),
        height: 40,
        width: 40,
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.network(
              _viewModel.model.thumbnailUrl,
              width: 40,
              errorBuilder:
                  (context, exception, stackTrace) => Icon(
                Icons.record_voice_over,
                color: theme.dividerColor,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getItemCard(BuildContext context, ThemeData theme) {
    return Expanded(
      child: InkWell(
        onTap: _viewModel.itemClick,
        child: Container(
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getNameWithDate(context, theme),
              getDescription(context, theme),
              TechnicalData(technicalId: _viewModel.model.id)
            ],
          ),
        ),
      ),
    );
  }

  Widget getNameWithDate(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              _viewModel.model.personName,
              style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          Text(
            DateFormat("d.M.y", "pl").format(_viewModel.model.date),
            style: TextStyle(
              color: theme.dividerColor,
              fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget getDescription(BuildContext context, ThemeData theme) {
    return _viewModel.model.desc != null
        ? Container(
      width: double.infinity,
      child: Text(
        _viewModel.model.desc,
        style: TextStyle(
            color: theme.dividerColor, fontSize: 14),
        textAlign: TextAlign.left,
      ),
    )
        : Container();
  }

}