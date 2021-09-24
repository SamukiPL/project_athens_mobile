import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/deputies_utils/data/network/response/full_deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class DeputyFullMapper extends DataMapper<FullDeputyResponse, DeputyFull> {
  List<ParliamentClubModel> _clubs;

  final DeputyCvMapper _cvMapper = DeputyCvMapper();
  final ContactMapper _contactMapper = ContactMapper();
  late StatisticsMapper _statisticsMapper;

  DeputyFullMapper(this._clubs) {
    _statisticsMapper = StatisticsMapper(_clubs);
  }

  @override
  DeputyFull transform(FullDeputyResponse data) {
    final currentClub = _clubs.firstWhere((element) => element.id == data.parliamentClub);

    return DeputyFull(data.id, data.cadency, data.name, data.reversedName, data.photoUrl, data.politicalParty, currentClub, data.cardNumber, data.deputyId, data.isActive, _cvMapper.transform(data.cv), _contactMapper.transform(data.contact), _statisticsMapper.transform(data.statistics),  data.createAt, data.updateAt);
  }
}

class StatisticsMapper extends DataMapper<StatisticsBean, Statistics> {
  List<ParliamentClubModel> _clubs;

  late ClubVoteAccuracyMapper _voteAccuracyMapper;

  StatisticsMapper(this._clubs) {
    _voteAccuracyMapper = ClubVoteAccuracyMapper(_clubs);
  }

  @override
  Statistics transform(StatisticsBean data) {
    return Statistics(data.createAt, data.updateAt, data.cadency, data.cadencyDeputy, data.speechesCount, data.voteAbsencyCount, data.clubVoteAccuracy.map((e) => _voteAccuracyMapper.transform(e)).toList());
  }
}

class ClubVoteAccuracyMapper extends DataMapper<ClubVoteAccuracyBean, ClubVoteAccuracy> {
  List<ParliamentClubModel> _clubs;

  ClubVoteAccuracyMapper(this._clubs);

  @override
  ClubVoteAccuracy transform(ClubVoteAccuracyBean data) {
    final parliamentClub = _clubs.firstWhere((element) => element.id == data.parliamentClub);

    return ClubVoteAccuracy(data.compatibleVotes, parliamentClub);
  }
}

class DeputyCvMapper extends DataMapper<CvBean, DeputyCv> {
  DeputyCvMapper();

  @override
  DeputyCv transform(CvBean data) {
    return DeputyCv(data.born, data.education, data.finishedSchools, data.profession, data.parliamentExperience);
  }
}

class ContactMapper extends DataMapper<ContactBean, Contact> {
  ContactMapper();

  ContactOfficeMapper _officeMapper = ContactOfficeMapper();

  @override
  Contact transform(ContactBean data) {
    return Contact(data.offices.map((e) => _officeMapper.transform(e)).toList());
  }
}

class ContactOfficeMapper extends DataMapper<ContactOfficeBean, ContactOffice> {
  ContactOfficeMapper();

  @override
  ContactOffice transform(ContactOfficeBean data) {
    return ContactOffice(data.name, data.address, data.email, data.isPrimary, data.telephone);
  }
}