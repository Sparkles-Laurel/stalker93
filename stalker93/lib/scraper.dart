import 'package:html/parser.dart' as html_engine;

/// Keeps a scraper engine.
class Scraper {
  /// Parses suffixes such as M, B and K.
  int approxFromSuffix(String str) {
    if (str.endsWith('M')) {
      return (double.parse(str.substring(0, str.length - 1)) * 1000000).toInt();
    } else if (str.endsWith('B')) {
      return (double.parse(str.substring(0, str.length - 1)) * 1000000000)
          .toInt();
    } else if (str.endsWith('K')) {
      return (double.parse(str.substring(0, str.length - 1)) * 1000).toInt();
    } else {
      return int.parse(str);
    }
  }

  /// Scrapes the followers count from the OpenGraph meta tags.
  int scrapeFollowers(String html) {
    var document = html_engine.parse(html);
    var meta = document.head!.querySelector('meta[name="description"]')!;
    var content = meta.attributes['content']!;
    var parts = content.split(' ');
    return approxFromSuffix(parts[1]);
  }

  /// Scrapes the following count from the OpenGraph meta tags.
  int scrapeFollowing(String html) {
    var document = html_engine.parse(html);
    var meta = document.head!.querySelector('meta[name="description"]')!;
    var content = meta.attributes['content']!;
    var parts = content.split(' ');
    return approxFromSuffix(parts[3]);
  }

  /// Scrapes the posts count from the OpenGraph meta tags.
  int scrapePosts(String html) {
    var document = html_engine.parse(html);
    var meta = document.head!.querySelector('meta[name="description"]')!;
    var content = meta.attributes['content']!;
    var parts = content.split(' ');
    return approxFromSuffix(parts[5]);
  }
}
