enum RevisionType {
  material,
  revision,
  quiz;

  String translate() {
    switch (this) {
      case revision:
        return 'Revisions';
      case quiz:
        return 'Quizzes';

      default:
        return 'Materials';
    }
  }
}
