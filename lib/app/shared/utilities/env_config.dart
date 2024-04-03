class EnvConfig {
  static late final String baseUrl;

  static void initialize({required String baseUrl}) {
    EnvConfig.baseUrl = baseUrl;
  }
}
