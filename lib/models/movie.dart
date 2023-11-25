class Movie {
  final int id;
  final String name;
  final String summary;
  final String imageUrl;
  final List<String> genres;
  final String status;
  final int runtime;
  final String premiered;
  final String language;
  final List<String> actors;
  final String officialSite;
  final String scheduleTime;
  final List<String> scheduleDays;

  Movie({
    required this.id,
    required this.name,
    required this.summary,
    required this.imageUrl,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.premiered,
    required this.language,
    required this.actors,
    required this.officialSite,
    required this.scheduleTime,
    required this.scheduleDays,
  });
}
