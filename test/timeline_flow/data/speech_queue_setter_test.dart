import 'package:flutter_test/flutter_test.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/utils/preconditions.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/timeline_flow/data/speech_queue_setter.dart';

void main() {
  test("create queue setter and check method exsistion", () {
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    queueSetter.setQueues(_mockSpeechList());
  });

  test("provide next person speech last index test", (){
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    final list = _mockSpeechList();

    final shouldBeNull = queueSetter.provideNextPersonModel(list.length - 1, list);
    expect(shouldBeNull, null);
  });

  test("provide next person speech empty list test", (){
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());

    final shouldBeNull = queueSetter.provideNextPersonModel(0, []);
    expect(shouldBeNull, null);
  });

  test("provide next person speech correct data test", () {
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    final list = _mockSpeechList();
    final secondItem = list[1];

    PersonSpeechModel forFirstItem = requiredNotNull(queueSetter.provideNextPersonModel(0, list));
    expect(forFirstItem.speechId, secondItem.id);
    expect(forFirstItem.thumbnailUrl, secondItem.thumbnailUrl);
    expect(forFirstItem.name, secondItem.personName);
  });

  test("provide previous person speech first index test", (){
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    final list = _mockSpeechList();

    final shouldBeNull = queueSetter.providePreviousPersonModel(0, list);
    expect(shouldBeNull, null);
  });

  test("provide previous person speech empty list test", (){
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());

    final shouldBeNull = queueSetter.providePreviousPersonModel(5, []);
    expect(shouldBeNull, null);
  });

  test("provide previous person speech correct data test", () {
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    final list = _mockSpeechList();
    final firstItem = list.first;

    final forSecondItem = requiredNotNull(queueSetter.providePreviousPersonModel(1, list));
    expect(forSecondItem.speechId, firstItem.id);
    expect(forSecondItem.thumbnailUrl, firstItem.thumbnailUrl);
    expect(forSecondItem.name, firstItem.personName);
  });

  test("should add nextPersonSpeech", () {
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    final list = queueSetter.setQueues(_mockSpeechList());

    expect(list[0].nextPersonSpeech!.speechId, list[1].id);
    expect(list[1].nextPersonSpeech!.speechId, list[2].id);
    expect(list[2].nextPersonSpeech!.speechId, list[3].id);
    expect(list[3].nextPersonSpeech!.speechId, list[4].id);
    expect(list[4].nextPersonSpeech, null);
  });

  test("should add previousPersonSpeech", () {
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    final list = queueSetter.setQueues(_mockSpeechList());

    expect(list[0].previousPersonSpeech, null);
    expect(list[1].previousPersonSpeech!.speechId, list[0].id);
    expect(list[2].previousPersonSpeech!.speechId, list[1].id);
    expect(list[3].previousPersonSpeech!.speechId, list[2].id);
    expect(list[4].previousPersonSpeech!.speechId, list[3].id);
  });

  test("timeline models test", () {
    final queueSetter = SpeechQueueSetter(_mockSpeechCache());
    final list = queueSetter.createQueues(_mockTimelineList());

    expect(list.length, _mockTimelineList().length);

    final speeches = list.where((element) => element is SpeechModel).map((e) => e as SpeechModel).toList();

    expect(speeches[0].nextPersonSpeech!.speechId, speeches[1].id);
    expect(speeches[0].previousPersonSpeech, null);

    expect(speeches[4].nextPersonSpeech, null);
    expect(speeches[4].previousPersonSpeech!.speechId, speeches[3].id);
  });
}

SpeechCache _mockSpeechCache() => SpeechCache();

List<SpeechModel> _mockSpeechList() => [
  SpeechModel(id: "1", previousPersonSpeech: PersonSpeechModel(speechId: '', name: ''), personName: '', date: DateTime.now().add(Duration(hours: 1)), videoUrl: ''),
  SpeechModel(id: "2", previousPersonSpeech: PersonSpeechModel(speechId: '', name: ''), personName: '', date: DateTime.now().add(Duration(hours: 2)), videoUrl: ''),
  SpeechModel(id: "3", previousPersonSpeech: PersonSpeechModel(speechId: '', name: ''), personName: '', date: DateTime.now().add(Duration(hours: 3)), videoUrl: ''),
  SpeechModel(id: "4", previousPersonSpeech: PersonSpeechModel(speechId: '', name: ''), personName: '', date: DateTime.now().add(Duration(hours: 4)), videoUrl: ''),
  SpeechModel(id: "5", previousPersonSpeech: PersonSpeechModel(speechId: '', name: ''), personName: '', date: DateTime.now().add(Duration(hours: 5)), videoUrl: ''),
];

List<TimelineModel> _mockTimelineList() => [
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
  SpeechModel(id: "1", previousPersonSpeech: PersonSpeechModel(speechId: '', name: ''), date: DateTime.now().add(Duration(hours: 5)), videoUrl: '', personName: ''),
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
  SpeechModel(id: "2", date: DateTime.now().add(Duration(hours: 4)), videoUrl: '', personName: ''),
  SpeechModel(id: "3", date: DateTime.now().add(Duration(hours: 3)), videoUrl: '', personName: ''),
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
  SpeechModel(id: "4", date: DateTime.now().add(Duration(hours: 2)), videoUrl: '', personName: ''),
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
  SpeechModel(id: "5", nextPersonSpeech: PersonSpeechModel(speechId: '', name: ''), date: DateTime.now().add(Duration(hours: 1)), videoUrl: '', personName: ''),
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
  VotingModel(votingType: VotingType.REQUEST_OF_CLOSING_MEETING, votes: [], results: VoteResultModel(0,0,0,0), clubVotes: [], id: '', title: '', votingDesc: '', date: DateTime.now()),
];