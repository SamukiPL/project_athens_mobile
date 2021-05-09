import 'dart:math';

import 'package:project_athens/athens_core/data/word_model/word_model.dart';

import 'noun_tag.dart';

List<WordModel> mapToWordModel(List<NounTag> tags) {
  final List<WordModel> finalWords = [];
  final List<NounTag> nouns = [...tags];

  if (tags.length > 0) {
    tags.sort((a, b) => b.hits.compareTo(a.hits));
    final minValueAllowed = (tags.length > 75) ? tags[75] : tags.last;
    final minimisedNouns = nouns
      ..removeWhere(
              (tag) => tag.hits < minValueAllowed.hits || tag.key == "to");

    minimisedNouns.forEach((tag) {
      finalWords
          .add(WordModel(tag.hits / (minValueAllowed.hits / 5), tag.key));
    });
  }

  finalWords.shuffle(Random(97518234));

  final res = finalWords.cast<WordModel>();

  return res;
}