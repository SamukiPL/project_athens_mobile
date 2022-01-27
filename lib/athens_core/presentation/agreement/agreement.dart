import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

@immutable
class Agreement extends StatelessWidget {
  final bool readonly;
  final bool shouldHandleAccept;
  final AppLocalizations l10n;
  final void Function(bool isConfirmed)? onConfirm;
  final void Function()? hasReachedEndFn;
  final AgreementBloc bloc;

  Agreement({
    required this.shouldHandleAccept,
    required this.bloc,
    required this.l10n,
    this.onConfirm,
    this.readonly = false,
    this.hasReachedEndFn
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: bloc,
      child: Consumer<AgreementBloc>(
        builder: (context, bloc, _) =>
            bloc.isLoaded
              ? _getPDFView(context)
              : _buildLoader(bloc.downloadProgress == 0.0 ? null : bloc.downloadProgress)
      ),
    );
  }

  Widget _buildLoader(double? progress) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: progress
            ),
            Text(l10n.getText().universalDownloadingData())
          ],
        )
    );
  }

  Widget _getPDFView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: SingleChildScrollView(
                      controller: bloc.scrollController,
                      child: HtmlWidget(
                          bloc.html!,
                          onErrorBuilder: (context, element, err) => _buildHtmlWidgetError(err),
                          onLoadingBuilder: (context, element, loadingProgress) => _buildLoader(loadingProgress),
                      )
                  )
              )
          ),
          readonly ? Container() : _buildBottomBar(l10n, Theme.of(context))
        ],
      )
    );
  }

  Widget _buildHtmlWidgetError(err) {
    return Center(
      child: Column(
        children: [
          Text(l10n.getText().universalErrorUnknown()),
          GestureDetector(
            child: Text(l10n.getText().universalAgreementOrTryToOpenInBrowser()),
            onTap: () => bloc.tryToLaunchInBrowser(),
          )
          //
        ],
      ),
    );
  }

  Widget _buildBottomBar(AppLocalizations l10n, ThemeData theme) {
    return Column(
      children: [
        _getScrollStatus(l10n, theme),
        _getButton(l10n, theme)
      ],
    );
  }

  _getScrollStatus(AppLocalizations l10n, ThemeData theme) {
    return StreamProvider<double>.value(
        value: bloc.scrollProgressStream,
        initialData: 0,
        child: Consumer<double>(
          builder: (context, scrollPercentage, _) => Container(
            width: double.infinity,
            child: LinearProgressIndicator(
              value: scrollPercentage,
              color: theme.primaryColor,
              minHeight: 2,
            ),
          )

        ),
    );
  }

  ElevatedButton _getButton(AppLocalizations l10n, ThemeData theme) {
    return ElevatedButton(
        onPressed: () async {
          if (shouldHandleAccept) {
            await bloc.updatePolicyVersion();
          }

          if (onConfirm != null) {
            onConfirm!(true);
          }
        },
        child: Text(
          shouldHandleAccept
              ? l10n.getText().universalAccept()
              : l10n.getText().universalClose()
        ),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) =>
            bloc.hasReachedEnd || !shouldHandleAccept ? Colors.white : Colors.black26
          ),
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
          bloc.hasReachedEnd || !shouldHandleAccept ? theme.primaryColor : Colors.grey
          ),
          splashFactory:
          bloc.hasReachedEnd || !shouldHandleAccept ? InkSplash.splashFactory : NoSplash.splashFactory
        ),
    );
  }
}