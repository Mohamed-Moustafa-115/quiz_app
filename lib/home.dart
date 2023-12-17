import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> isSelected = [false, false, false, false];
  int? selectedAnswer;
  int progress = 0;
  int score = 0;
  List<Question> quest = getQuestions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Question ${progress + 1}/${quest.length}",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width * .9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        quest[progress].text,
                        style: const TextStyle(fontSize: 15),
                      ),
                    )),
                const Positioned(
                    left: -20,
                    top: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                    )),
                const Positioned(
                    right: -20,
                    top: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                    )),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 300,
              width: MediaQuery.sizeOf(context).width * .8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    answerButton(0),
                    const SizedBox(
                      height: 10,
                    ),
                    answerButton(1),
                    const SizedBox(
                      height: 10,
                    ),
                    answerButton(2),
                    const SizedBox(
                      height: 10,
                    ),
                    answerButton(3),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            nextButton(),
          ],
        ),
      ),
    );
  }

  Widget answerButton(int index) {
    return AnimatedButton(
      color: isSelected[index] ? Colors.orange : Colors.blue,
      child: Text(
        quest[progress].answerList[index].text,
        style: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        setState(() {
          selectedAnswer = index;
        });
        bool check = false;
        for (int i = 0; i < quest.length; i++) {
          for (int j = 0; j < quest.length; j++) {
            if (i != j) {
              isSelected[i] = false;
              isSelected[index] = true;
              check = true;
              break;
            }
          }
        }
      },
    );
  }

  Widget nextButton() {
    return AnimatedButton(
        onPressed: () {
          if (selectedAnswer != null) {
            setState(() {
              if (quest[progress].answerList[selectedAnswer!].isCorrect) {
                setState(() {
                  score++;
                });
              }
              isSelected[selectedAnswer!] = false;
              selectedAnswer = null;
              if (progress != quest.length - 1) {
                progress++;
              } else {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("Your Score is $score",
                            style: TextStyle(
                                color: score >= (quest.length / 2)
                                    ? Colors.green
                                    : Colors.red)),
                        content: SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              Text(
                                score >= (quest.length / 2)
                                    ? "Passed"
                                    : "Failed",
                                style: TextStyle(
                                    color: score >= (quest.length / 2)
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: AnimatedButton(
                                  child: Text("Restart"),
                                  onPressed: () {
                                    setState(() {
                                      progress = 0;
                                      score = 0;
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            });
          }
        },
        child: const Text(
          "Next",
          style: TextStyle(fontSize: 20),
        ));
  }
}
