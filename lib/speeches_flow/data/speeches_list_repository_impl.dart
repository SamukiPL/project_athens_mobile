import 'dart:async';
import 'dart:convert';

import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/domain/list/speeches_list_repository.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';
import 'package:rxdart/rxdart.dart';

class SpeechesListRepositoryImpl extends SpeechesListRepository {

  final SpeechesApi _speechesApi;

  final SpeechesNetworkMapper _networkMapper;

  final StreamController<Result<List<SpeechModel>>> _speechesSubject =
      BehaviorSubject<Result<List<SpeechModel>>>();

  SpeechesListRepositoryImpl(this._speechesApi, this._networkMapper);

  @override
  void dispose() {
    _speechesSubject.close();
  }

  @override
  Future<void> fetchItems(int limit, int offset) async {}

  @override
  Stream<Result<List<SpeechModel>>> getItems(BaseParams params) {
    mockData();

    return _speechesSubject.stream;
  }

  @override
  Future<void> refreshItems() async {}

  Future<void> mockData() async {
    final response = SpeechResponse.fromJson(json.decode(mockSpeech));
    final response1 = SpeechResponse.fromJson(json.decode(mockSpeech2));
    final model = await _networkMapper.transform(response);
    final model1 = await _networkMapper.transform(response1);
    List<SpeechModel> test = [model, model1];
    final result = Success(test);
    _speechesSubject.add(result);
  }

  final String mockSpeech = "{\"agenda\":{\"eventDateTime\":\"2020-10-07T10:47:20.000Z\",\"msgDateTime\":\"2020-10-07T10:53:41.000Z\",\"title\":\"2) Sprawozdanie Komisji o rządowym projekcie ustawy o zmianie ustawy budżetowej na rok 2020 (druki nr 572 i 636) (5-minutowe oświadczenia w imieniu klubów i koła)\"},\"cisInfo\":{\"person\":{\"name\":\"Grzegorz\",\"surname\":\"Braun\",\"gender\":\"male\",\"function\":null,\"other\":null,\"deputyCardNumber\":34,\"termOfficeNumber\":9},\"eventDateTime\":\"2020-10-07T11:17:54.000Z\",\"msgDateTime\":\"2020-10-07T12:14:09.000Z\",\"rangeId\":\"jsBHdKRzQQCxWluw2DB1Dw\",\"refId\":\"jsBHdKRzQQCxWluw2DB1Dw:speechbegin\"},\"riskyMatch\":false,\"createAt\":\"2020-09-20T20:45:05.830Z\",\"_id\":\"5f7daddb9b46698da9845f7c\",\"deputyCardIdentifier\":34,\"fileName\":\"jsBHdKRzQQCxWluw2DB1Dw-34.flv\",\"videoDownloadUrl\":\"https://n-22-1.dcs.redcdn.pl/nvr/o2/sejm/ENC01/live.livx?startTime=623755074872&stopTime=623755229872&name=jsBHdKRzQQCxWluw2DB1Dw-34.flv&\",\"length\":155000,\"personName\":\"Grzegorz Braun\",\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839eb4\",\"parliamentClub\":\"Koło Poselskie Konfederacja\",\"cadency\":9,\"rangeId\":\"jsBHdKRzQQCxWluw2DB1Dw\",\"__v\":0,\"id\":\"5f7daddb9b46698da9845f7c\"}";
  final String mockSpeech2 = "{\"agenda\":{\"eventDateTime\":\"2020-10-07T10:47:20.000Z\",\"msgDateTime\":\"2020-10-07T10:53:41.000Z\",\"title\":\"2) Sprawozdanie Komisji o rządowym projekcie ustawy o zmianie ustawy budżetowej na rok 2020 (druki nr 572 i 636) (5-minutowe oświadczenia w imieniu klubów i koła), 2) Sprawozdanie Komisji o rządowym projekcie ustawy o zmianie ustawy budżetowej na rok 2020 (druki nr 572 i 636) (5-minutowe oświadczenia w imieniu klubów i koła)\"},\"cisInfo\":{\"person\":{\"name\":\"Grzegorz\",\"surname\":\"Braun\",\"gender\":\"male\",\"function\":null,\"other\":null,\"deputyCardNumber\":34,\"termOfficeNumber\":9},\"eventDateTime\":\"2020-10-07T11:17:54.000Z\",\"msgDateTime\":\"2020-10-07T12:14:09.000Z\",\"rangeId\":\"jsBHdKRzQQCxWluw2DB1Dw\",\"refId\":\"jssBHdKRzQQCxWluw2DB1Dw:speechbegin\"},\"riskyMatch\":false,\"createAt\":\"2020-09-20T20:45:05.830Z\",\"_id\":\"5sf7daddb9b46698da9845f7c\",\"deputyCardIdentifier\":34,\"fileName\":\"jsBHdKRzQQCxWluw2DB1Dw-34.flv\",\"videoDownloadUrl\":\"https://n-22-1.dcs.redcdn.pl/nvr/o2/sejm/ENC01/live.livx?startTime=623755074872&stopTime=623755229872&name=jsBHdKRzQQCxWluw2DB1Dw-34.flv&\",\"length\":155000,\"personName\":\"Grzegorz Braun\",\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839eb4\",\"parliamentClub\":\"Koło Poselskie Konfederacja\",\"cadency\":9,\"rangeId\":\"jsBHdKRzQQCxWluw2DB1Dw\",\"__v\":0,\"id\":\"5sf7daddb9b46698da9845f7c\"}";
}
