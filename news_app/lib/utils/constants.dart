class Constantss {
  static String allnews =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=72d64c74cea5445580c05874f4a3302b";

  static String search(String keyword) {
    return "https://newsapi.org/v2/everything?q=$keyword&apiKey=72d64c74cea5445580c05874f4a3302b";
  }
}
