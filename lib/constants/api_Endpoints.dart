class APIEndpoints {
  APIEndpoints();

  String get baseURL {
    // return "http://localhost:9000/";
    return "http://192.168.0.104:3000/";
  }

  String get registerJudge{
    return "registerJudge";
  }
}