import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/voting_flow/screens/details/linear_vote_distribution/linear_vote_distribution_segment.dart';

enum FloatingLabelPosition {
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
  // a bit higher than TOP_LEFT
  TOP_PLUS_LEFT,
  // a bit higher than TOP_RIGHT
  TOP_PLUS_RIGHT
}

class LinearVoteDistributionPainter extends CustomPainter {
  // final VotingModel voting;
  final AppLocalizations localizations;

  final int rectHeight = 40;

  final List<FloatingLabelPosition> labelsLTR = [FloatingLabelPosition.TOP_PLUS_RIGHT, FloatingLabelPosition.TOP_RIGHT, FloatingLabelPosition.BOTTOM_RIGHT];
  final List<FloatingLabelPosition> labelsRTL = [FloatingLabelPosition.TOP_LEFT, FloatingLabelPosition.TOP_PLUS_LEFT, FloatingLabelPosition.BOTTOM_LEFT];
  final List<FloatingLabelPosition> labelsMid = [FloatingLabelPosition.TOP_LEFT, FloatingLabelPosition.TOP_RIGHT, FloatingLabelPosition.BOTTOM_LEFT];

  final List<LinearVoteDistributionSegment> segments;
  final int requiredVotes;

  Set<FloatingLabelPosition> usedLabelPostions = Set();

  LinearVoteDistributionPainter(this.localizations, this.segments, this.requiredVotes);

  void _drawFloatingLabel(Canvas canvas, Size canvasSize, double left, double top, double rectWidth, Size textSize, LinearVoteDistributionSegment segment) {
    // will overflow text when drawn from left
    FloatingLabelPosition drawingPosition;


    // check if label will overflow against the screen from left and right
    if (left - textSize.width < 0) {
      drawingPosition = labelsLTR.firstWhere((label) => !usedLabelPostions.contains(label));
    } else if (left + textSize.width > canvasSize.width) {
      drawingPosition = labelsRTL.firstWhere((label) => !usedLabelPostions.contains(label));
    } else {
      drawingPosition = labelsMid.firstWhere((label) => !usedLabelPostions.contains(label));
    }


    final isHigherTop = drawingPosition == FloatingLabelPosition.TOP_PLUS_RIGHT
        || drawingPosition == FloatingLabelPosition.TOP_PLUS_LEFT;

    final isBottom = drawingPosition == FloatingLabelPosition.BOTTOM_RIGHT
        || drawingPosition == FloatingLabelPosition.BOTTOM_LEFT;

    final isRightDir = drawingPosition == FloatingLabelPosition.TOP_RIGHT
        || drawingPosition == FloatingLabelPosition.BOTTOM_RIGHT
        || drawingPosition == FloatingLabelPosition.TOP_PLUS_RIGHT;

    int baseMargin = 10;
    if (isHigherTop) {
      baseMargin += ((textSize.height).toInt() + 5);
    } else if (isBottom) {
      baseMargin += (textSize.height).toInt();
    }

    // decides if we want to draw floating label on the bottom of chart or
    // on top of chart
    final yPositionMod = isBottom ? 1 : -1;

    // decides whether we paint from left to right or right to left
    final xPositionMod = isRightDir ? -1 : 1;

    final halfRectHeight = rectHeight / 2;
    final startY = top + (rectHeight / 2);
    final endY = startY + ((halfRectHeight + baseMargin) * yPositionMod);

    final halfRectWidth = rectWidth / 2;

    // vertical line of chart
    final lineStartOffset = Offset(left + halfRectWidth, startY);
    final lineEndOffset = Offset(left + halfRectWidth, endY);


    final horizontalEndX = left - (textSize.width * xPositionMod);
    // underline of text
    final horizontalLineEndOffset = Offset(horizontalEndX, endY);

    usedLabelPostions.add(drawingPosition);

    Paint labelLineBrush = new Paint()
      ..strokeWidth = 1
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    // draw vertical line from chart to top of chart
    canvas.drawLine(lineStartOffset, lineEndOffset, labelLineBrush);

    // draw horizontal line that will be underline of text
    canvas.drawLine(horizontalLineEndOffset, lineEndOffset, labelLineBrush);

    // draw floating label text
    final TextSpan floatingLabelVotesCountSpan = TextSpan(
        style: TextStyle(color: Colors.black),
        text: '${segment.label}: ${segment.votes}'
    );

    final TextPainter floatingTp = TextPainter(
        text: floatingLabelVotesCountSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    );

    floatingTp.layout();

    // if we are paiting fomr left to right (e.g. TOP_RIGHT) than we start
    // paiting text as vertical line of floating label, however if we paint
    // right to left (e.g. TOP_LEFT) we have to move start of X by the width
    // of text, to properly match the underline of floating label
    final xPositionTextMod = xPositionMod == -1 ? 0 : 1;

    final textStartX = left - (textSize.width * xPositionTextMod);

    final textOffset = Offset(textStartX, endY - textSize.height);

    // draw text
    floatingTp.paint(canvas, textOffset);
  }

  double _drawDashedLine(Canvas canvas, int offset, int dashWidth, double startX, double startY, double endY) {
    final Paint linePaint = Paint()
      ..strokeWidth = 1
      ..color = Colors.black.withAlpha(60)
      ..style = PaintingStyle.stroke;

    double currentY = startY;
    final space = offset + dashWidth;

    while (currentY < endY) {
      canvas.drawLine(
          Offset(startX, currentY),
          Offset(startX, currentY + dashWidth),
          linePaint
      );

      currentY += space;
    }

    return endY;
  }

  double _drawVotesRequiredToPassLine(Canvas canvas, Size size, int summedValues) {
    final double perctangeToPass = requiredVotes / summedValues;

    // make it a little bit overflowing from rect
    final heightMargin = 5;

    final double startX = size.width * perctangeToPass;
    final double startY = ((size.height / 2) - (rectHeight / 2)) - heightMargin;
    final double endY = (size.height / 2) + (rectHeight / 2) + heightMargin;

    final double lastEndY = _drawDashedLine(canvas, 1, 4, startX, startY, endY);

    // draw triangle pointer
    final triangleMargin = 5;
    final triangleSize = 10;

    final triangleStartY = lastEndY + triangleMargin;
    final triangleBottomY = triangleStartY + triangleSize;

    final Path trianglePath = Path()
      ..moveTo(startX, triangleStartY)
      ..lineTo(startX + triangleSize, triangleBottomY)
      ..lineTo(startX - triangleSize, triangleBottomY)
      ..close();

    final triangleBrush = Paint()
      ..strokeWidth = 0
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    canvas.drawPath(trianglePath, triangleBrush);

    // draw text
    final requiredTextSpan = TextSpan(
        text: '${requiredVotes.toString()} ${localizations.getText().votingsVotesNeededToPass()}',
        style: TextStyle(color: Colors.black)
    );
    final TextPainter requiredTextPainter = TextPainter(
        text: requiredTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    );

    requiredTextPainter.layout();

    requiredTextPainter.paint(canvas, Offset(startX - (requiredTextPainter.size.width / 2), triangleBottomY + triangleMargin));

    return triangleBottomY + triangleMargin + requiredTextPainter.size.height;
  }

  @override
  void paint(Canvas canvas, Size size) {
    usedLabelPostions = new Set();

    final int summedValues = segments
        .where((element) => element.isBeingUsed)
        .map((s) => s.votes)
        .reduce((prev, curr) => prev += curr);

    double leftShift = 0;

    segments
        .where((element) => element.isBeingUsed)
        .forEach((segment) {
      final double percentage = segment.votes / summedValues;

      Paint segmentBrush = new Paint()
        ..color = segment.color;

      final rectWidth = size.width * percentage;

      final top = (size.height / 2) - (this.rectHeight / 2);
      final bottom = top + this.rectHeight;
      final left = leftShift;
      final right = leftShift + rectWidth;

      Rect segmentRect = new Rect.fromLTRB(left, top, right, bottom);

      canvas.drawRect(segmentRect, segmentBrush);

      // draw votes count on bar
      final TextSpan votesCountSpan = TextSpan(
          style: TextStyle(color: Colors.white),
          text: '${segment.label}: ${segment.votes}'
      );

      final TextPainter tp = TextPainter(
          text: votesCountSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr
      )
        ..layout();

      final textSize = tp.size;

      if (textSize.width > rectWidth) {
        _drawFloatingLabel(canvas, size, left, top, rectWidth, textSize, segment);
      } else {
        final textStartX = (left + (rectWidth / 2)) - tp.size.width / 2;
        final textStartY = (top + (rectHeight / 2)) - tp.size.height / 2;
        tp.paint(canvas, Offset(textStartX, textStartY));
      }


      // set next left shift to draw next rect
      leftShift = right;
    });

    _drawVotesRequiredToPassLine(canvas, size, summedValues);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
