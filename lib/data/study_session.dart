class StudySession {
  final int id;
  final String deckName;
  final String date;
  final int reviewed;
  final int correct;

  const StudySession(
      this.id, this.deckName, this.date, this.reviewed, this.correct);
}