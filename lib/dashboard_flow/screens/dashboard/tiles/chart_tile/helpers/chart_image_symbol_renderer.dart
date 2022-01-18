import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

/// Custom renderer for legend symbol. This way we for example we can put
/// deputy image for legend
class ChartImageSymbolRenderer extends charts.CustomSymbolRenderer {
  final Map<Color, SubscribedDeputyModel> colorToDeputyMap;

  ChartImageSymbolRenderer(this.colorToDeputyMap);

  @override
  Widget build(
      BuildContext context,
      {
        required Size size,
        Color? color,
        bool? enabled
      }) {
    final SubscribedDeputyModel deputy = colorToDeputyMap[color]!;

    return new SizedBox.fromSize(
        size: size,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color!, width: 1)
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: deputy.thumbnailUrl,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)
                      ),
                      child: Center(
                          child: Text(
                            deputy.name,
                            style: TextStyle(
                                fontSize: 12
                            ),
                          )
                      ),
                    ),
                width: min(size.width, size.height),
                height: min(size.width, size.height),
                memCacheHeight: 700,
                memCacheWidth: 700,
                alignment: Alignment.center,
              ),
            )
        )
    );
  }
}
