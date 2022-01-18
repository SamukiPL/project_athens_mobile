import 'package:project_athens/athens_core/models/db_harvest_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class DeputyFull extends DbHarvestModel {
  final String id;
  final int cadency;
  final String name;
  final String reversedName;
  final String photoUrl;
  final String politicalParty;
  final ParliamentClubModel parliamentClub;
  final int cardNumber;
  final String deputyId;
  final bool isActive;
  final DeputyCv cv;
  final Contact contact;
  final Statistics statistics;

  DeputyFull(this.id, this.cadency, this.name, this.reversedName, this.photoUrl, this.politicalParty, this.parliamentClub, this.cardNumber, this.deputyId, this.isActive, this.cv, this.contact, this.statistics, DateTime createAt, DateTime updateAt) : super(createAt, updateAt);
}

class Contact {
  final List<ContactOffice> offices;

  Contact(this.offices);
}

class ContactOffice {
  final String address;
  final String name;
  final String telephone;
  final String email;
  final bool isPrimary;

  ContactOffice(this.name, this.address, this.email, this.isPrimary, this.telephone);
}

class DeputyCv {
  final String born;
  final String? education;
  final String? finishedSchools;
  final String? profession;
  final String parliamentExperience;

  DeputyCv(this.born, this.education, this.finishedSchools, this.profession, this.parliamentExperience);
}

class Statistics {
  final DateTime createAt;
  final DateTime updateAt;
  final int cadency;
  final String cadencyDeputy;
  final int speechesCount;
  final int voteAbsencyCount;
  final List<ClubVoteAccuracy> clubVoteAccuracy;

  Statistics(this.createAt, this.updateAt, this.cadency, this.cadencyDeputy, this.speechesCount, this.voteAbsencyCount, this.clubVoteAccuracy);
}

class ClubVoteAccuracy {
  final int compatibleVotes;
  final ParliamentClubModel? parliamentClub;

  ClubVoteAccuracy(this.compatibleVotes, this.parliamentClub);
}
