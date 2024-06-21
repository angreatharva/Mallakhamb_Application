class APIEndpoints {
  APIEndpoints();

  String get baseURL {
    // return "http://localhost:9000/";
    return "http://192.168.0.105:3000/";
  }

  String get registerJudge{
    return "registerJudge";
  }
  String get login{
    return "login";
  }
  String get getTeamList{
    return "getTeamList";
  }
  String get playersData{
    return "playersData";
  }
}