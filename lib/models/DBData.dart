class DBData {
  final int created;
  final String prompt;
  final String url;

  const DBData({
    required this.created,
    required this.prompt,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'created': created,
      'prompt': prompt,
      'url': url,
    };
  }

  @override
  String toString() {
    return 'DBData{created $created ,prompt $prompt , url $url}';
  }
}
