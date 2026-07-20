class ApiConstants {
  static const String baseUrl = "https://onemansys.vampior.com/api";
  static const String imageBaseUrl = "https://onemansys.vampior.com/";

  static String imageUrl(String path) {
    return "$imageBaseUrl/$path";
  }
}
