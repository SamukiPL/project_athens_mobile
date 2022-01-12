import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_athens/athens_core/ads/native_ad/internal_native_ad.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_provider.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:provider/provider.dart';

class AdTimelineViewHolder extends StatelessWidget with RedirectionDelegate {
  final bool showTopLine;
  final bool showBottomLine;

  const AdTimelineViewHolder(this.showTopLine, this.showBottomLine,
      {Key? key})
      : super(key: key);

  final double lineThickness = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final adProvider = Provider.of<NativeAdProvider>(context);

    return ChangeNotifierProvider<InternalNativeAd>.value(
      value: adProvider.provide(),
      child: Consumer<InternalNativeAd>(
        builder: (context, bloc, _) => (bloc.isLoaded) ? Column(children: <Widget>[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  getHourWidget(context, theme),
                  getIcon(context, theme),
                  getRowText(context, theme, bloc),
              ],
            ),
          ),
        ]) : Container()
      ),
    );
  }

  Widget getHourWidget(BuildContext context, ThemeData theme) {
    return Container(
      width: 60,
      margin: EdgeInsets.only(left: 4, right: 4),
    );
  }

  Widget getIcon(BuildContext context, ThemeData theme) {
    return Container(
      width: 60,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Visibility(
                  visible: showTopLine,
                  child: VerticalDivider(
                      thickness: lineThickness, color: theme.dividerColor),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Visibility(
                  visible: showBottomLine,
                  child: VerticalDivider(
                      thickness: lineThickness, color: theme.dividerColor),
                ),
              ),
            ]
          ),
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              margin: EdgeInsets.all(8),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: theme.dividerColor, width: lineThickness)),
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "Ad",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFF19938)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget getRowText(BuildContext context, ThemeData theme, InternalNativeAd bloc) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
          child: Container(
                child: AdWidget(ad: bloc.ad),
                height: 60,
          )
        ),
      ),
    );
  }
}
