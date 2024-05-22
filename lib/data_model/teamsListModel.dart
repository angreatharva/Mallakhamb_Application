class TeamsListModel {
  int? teamId;
  String? teamName;
  String? coachName;
  String? contactNo;
  String? emailAddress;
  String? gender;
  String? ageGroup;
  int? totalMarks;
  int? avgMarks;

  TeamsListModel(
      {this.teamId,
        this.teamName,
        this.coachName,
        this.contactNo,
        this.emailAddress,
        this.gender,
        this.ageGroup,
        this.totalMarks,
        this.avgMarks});

  TeamsListModel.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'];
    teamName = json['teamName'];
    coachName = json['coachName'];
    contactNo = json['contactNo'];
    emailAddress = json['emailAddress'];
    gender = json['gender'];
    ageGroup = json['ageGroup'];
    totalMarks = json['totalMarks'];
    avgMarks = json['avgMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamId'] = this.teamId;
    data['teamName'] = this.teamName;
    data['coachName'] = this.coachName;
    data['contactNo'] = this.contactNo;
    data['emailAddress'] = this.emailAddress;
    data['gender'] = this.gender;
    data['ageGroup'] = this.ageGroup;
    data['totalMarks'] = this.totalMarks;
    data['avgMarks'] = this.avgMarks;
    return data;
  }
}
