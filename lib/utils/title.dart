String titleHeader(String title) {
  return title.length > 30 ? "${title.substring(0, 27)}..." : title;
}
