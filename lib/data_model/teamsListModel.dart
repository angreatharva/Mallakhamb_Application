class TeamsListModel {
  int? teamId;
  String? teamName;
  String? coachName;
  String? contactNo;
  String? emailAddress;
  String? gender;
  String? players;
  int? totalMarks;
  int? avgMarks;

  TeamsListModel({
    this.teamId,
    this.teamName,
    this.coachName,
    this.contactNo,
    this.emailAddress,
    this.gender,
    this.players,
    this.totalMarks,
    this.avgMarks,
  });

  TeamsListModel.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'];
    teamName = json['teamName'];
    coachName = json['coachName'];
    contactNo = json['contactNo'];
    emailAddress = json['emailAddress'];
    gender = json['gender'];
    players = json['players'];
    totalMarks = json['totalMarks'];
    avgMarks = json['avgMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teamId'] = teamId;
    data['teamName'] = teamName;
    data['coachName'] = coachName;
    data['contactNo'] = contactNo;
    data['emailAddress'] = emailAddress;
    data['gender'] = gender;
    data['players'] = players;
    data['totalMarks'] = totalMarks;
    data['avgMarks'] = avgMarks;
    return data;
  }
}