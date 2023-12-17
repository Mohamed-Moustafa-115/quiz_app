class Question {
  String text;
  List<Answer> answerList;
  Question(this.text, this.answerList);
}

class Answer {
  String text;
  bool isCorrect;
  Answer(this.text, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> questionList = [];
  questionList.add(Question("Who is owner of Flutter", [
    Answer("Nokia", false),
    Answer("Microsoft", false),
    Answer("Google", true),
    Answer("Apple", false),
  ]));
  questionList.add(Question("Who is owner of Windows", [
    Answer("Nokia", false),
    Answer("Microsoft", true),
    Answer("Google", false),
    Answer("Apple", false),
  ]));
  questionList.add(Question("Who is owner of MacOS", [
    Answer("Nokia", false),
    Answer("Microsoft", false),
    Answer("Google", false),
    Answer("Apple", true),
  ]));
  questionList.add(Question("Who is owner of the indestructible phones", [
    Answer("Nokia", true),
    Answer("Microsoft", false),
    Answer("Google", false),
    Answer("Apple", false),
  ]));
  return questionList;
}
