import 'package:project_athens/athens_core/ext/string_extension.dart';

final drukRegex = RegExp(
    r"\((druk|druki) (nr ){0,1}[A-Za-z0-9]{1,6}", multiLine: true);

int _getExtrasStartAt(String agenda) {
  if (drukRegex.hasMatch(agenda)) {
    // example:
    // Pkt. 18 Sprawozdanie Komisji o poselskim projekcie ustawy o zmianie
    // ustawy o podatku akcyzowym (druki nr 1510 i 1566) głosowanie nad całością projektu.
    return agenda.lastIndexOf(')');
  } else if (agenda.contains(' - głosowanie ')) {
    // example:
    // Pkt. 35 Informacja Ministra Zdrowia w sprawie organizacji Narodowego Programu Szczepień przy zwiększonej liczbie dostaw
    // szczepionek oraz informacji na temat zutylizowanych dawek - głosowanie wniosek o odrzucenie informacji
    return agenda.lastIndexOf('- głosowanie ');
  } else {
    return -1;
  }
}

/// Will return string without any extras in agenda
/// for example string at the end like 'Poprawka 1', ' - głosowanie' etc.
/// will be cut
String? getAgendaWithoutExtras(String? agenda) {
  if (agenda == null) {
    return null;
  }

  final int extrasStartAt = _getExtrasStartAt(agenda);

  // Quite often agenda startsWith 'Pkt. 18 ...' this part we would like to
  // cut off since we are showing this in title of timeline bubble
  int pointTextEndsAt = 0;
  final RegExp pointTextRegex = RegExp(r"Pkt(\.{0,1}) [0-9]{1,4}");
  if (agenda.startsWith(pointTextRegex)) {
    final firstMatch = pointTextRegex.firstMatch(agenda);

    pointTextEndsAt = firstMatch!.end;
  }

  if (extrasStartAt != -1) {
    // we want to show full agenda without texts like 'Poprawka 1' and 'Pkt. 1' etc. since
    // we want to only tell user what's about grouped vote
    final textWithoutExtras = agenda.substring(
        pointTextEndsAt, extrasStartAt + 1).trim();


    return textWithoutExtras;
  } else {
    return null;
  }
}

String? getAgendaExtras(String? agenda) {
  if (agenda == null) {
    return null;
  }

  final int extrasStartAt = _getExtrasStartAt(agenda);

  final extrasText = agenda.substring(extrasStartAt + 1).trim().toCapitalCase();

  return extrasText;
}
