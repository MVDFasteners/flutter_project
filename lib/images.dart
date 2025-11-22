import 'dart:math';

class Images {
  ///----------------- Brand -----------------------------------//
  static String logoIcon = 'assets/images/logo/left_bar_mvd_logo.png';
  static String ethLogoIcon = 'assets/images/logo/ethereum-eth-logo.png';

  ///----------------- Dummy Image -----------------------------------//

  static List<String> marketplaceImages =
      List.generate(3, (index) => 'assets/images/dummy/m-${index + 1}.jpg');

  static List<String> avatars = List.generate(
      12, (index) => 'assets/images/dummy/avatar-${index + 1}.jpg');

  static List<String> squareImages =
      List.generate(15, (index) => 'assets/images/dummy/${index + 1}.jpg');

  static List<String> landscapeImages =
      List.generate(4, (index) => 'assets/images/dummy/l${index + 1}.jpg');
  static List<String> portraitImages =
      List.generate(3, (index) => 'assets/images/dummy/p${index + 1}.jpg');

  static List<String> success =
      List.generate(1, (index) => 'assets/images/dummy/s-${index + 1}.jpg');

  static List<String> landing = List.generate(
      5, (index) => 'assets/images/dummy/landing-${index + 1}.jpg');

  static List<String> brand =
      List.generate(8, (index) => 'assets/images/dummy/brand-${index + 1}.jpg');

  static List<String> error =
      List.generate(5, (index) => 'assets/images/dummy/error-${index + 1}.jpg');

  static List<String> comingSoon = List.generate(
      1, (index) => 'assets/images/dummy/coming_soon-${index + 1}.jpg');

  static List<String> maintenance = List.generate(
      1, (index) => 'assets/images/dummy/maintenance-${index + 1}.jpg');

  /// Music
  static List<String> music =
      List.generate(14, (index) => 'assets/images/music/m${index + 1}.jpg');

  static String musicPoster = 'assets/images/music/music.jpg';

  static String randomImage(List<String> images) {
    return images[Random().nextInt(images.length)];
  }
}
