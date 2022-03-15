import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/alert_bottom_sheet/alert_bottom_sheet_mode.dart';

void showAlertBottomSheet(BuildContext parentContext,
    {required AlertBottomSheetMode mode,
    required String title,
    required String closeButtonTitle,
    String? description,
    void Function()? onClose}) {
  showModalBottomSheet(
    context: parentContext,
    builder: (childContext) => _AlertBottomSheet(
      description: description,
      mode: mode,
      title: title,
      onClose: onClose,
      closeButtonTitle: closeButtonTitle,
    ),
    enableDrag: false,
    isDismissible: true,
  ).whenComplete(() {
    if (onClose != null) {
      onClose();
    }
  });
}

class _AlertBottomSheet extends StatelessWidget {
  _AlertBottomSheet(
      {required this.mode,
      required this.title,
      required this.description,
      required this.closeButtonTitle,
      this.onClose});

  final AlertBottomSheetMode mode;
  final String title;
  final String? description;
  final void Function()? onClose;
  final String closeButtonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
        ),
        child: Wrap(
          children: <Widget>[_buildBottomSheetContent(context)],
        ));
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getIcon(Theme.of(context)),
            _getTitle(),
            _getDescription(),
            _buildCloseButton(context)
          ],
        ));
  }

  Widget _getIcon(ThemeData theme) {
    IconData icon;
    switch (mode) {
      case AlertBottomSheetMode.INFO:
        icon = Icons.info_outline;
        break;
      case AlertBottomSheetMode.WARNING:
        icon = Icons.warning_amber_outlined;
        break;
      case AlertBottomSheetMode.ERROR:
        icon = Icons.sentiment_dissatisfied_outlined;
        break;
      case AlertBottomSheetMode.SUCCESS:
        icon = Icons.sentiment_satisfied_outlined;
        break;
      default:
        throw UnimplementedError("Not recognized mode " + mode.toString());
    }

    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Icon(
        icon,
        color: theme.primaryColor,
        size: 50,
      ),
    );
  }

  Widget _getTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _getDescription() {
    if (description != null) {
      return Container(
        padding: EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
        child: Text(
          description!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: TextButton(
        child: Text(closeButtonTitle),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
