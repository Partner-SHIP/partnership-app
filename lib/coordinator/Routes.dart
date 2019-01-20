abstract class Routes {
  static const String root = "/";
  static const String loginPage = "/login_page";
  static const String profilePage = "/profile_page";
  static const String testingPage = "/testing_page";
  static List<String> get routesList => const <String>[root, loginPage, profilePage, testingPage];
}