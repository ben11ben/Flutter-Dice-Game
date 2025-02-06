import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/images/dice-1.png';
  var activeDiceImage2 = 'assets/images/dice-1.png';

  var diceRoll = 0;
  var diceRoll2 = 0;

  var totalRollsd1 = 0;
  var totalRollsd2 = 0;

  var dice1Total = 0;
  var dice2Total = 0;

  String resultText = '';

  void rollDice1() {
    if (totalRollsd1 < 5) {
      setState(() {
        diceRoll = Random().nextInt(6) + 1;
        activeDiceImage = 'assets/images/dice-$diceRoll.png';
        totalRollsd1++;
        dice1Total += diceRoll;

        if (totalRollsd1 == 5 && totalRollsd2 == 5) {
          checkWinner();
        }
      });
    }
  }

  void rollDice2() {
    if (totalRollsd2 < 5) {
      setState(() {
        diceRoll2 = Random().nextInt(6) + 1;
        activeDiceImage2 = 'assets/images/dice-$diceRoll2.png';
        totalRollsd2++;
        dice2Total += diceRoll2;

        if (totalRollsd1 == 5 && totalRollsd2 == 5) {
          checkWinner();
        }
      });
    }
  }

  void checkWinner() {
    if (dice1Total > dice2Total) {
      resultText = 'Top die wins with a total of $dice1Total!';
    } else if (dice2Total > dice1Total) {
      resultText = 'Bottom die wins with a total of $dice2Total!';
    } else {
      resultText = 'It\'s a tie!';
    }
    setState(() {});
  }

  void resetGame() {
    setState(() {
      totalRollsd1 = 0;
      totalRollsd2 = 0;
      dice1Total = 0;
      dice2Total = 0;
      resultText = ''; // Clear the text
      activeDiceImage = 'assets/images/dice-1.png';
      activeDiceImage2 = 'assets/images/dice-1.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceImage,
          width: 200,
        ),
        Image.asset(
          activeDiceImage2,
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice1,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(top: 20),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text('Roll Dice 1'),
        ),
        TextButton(
          onPressed: rollDice2,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(top: 20),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text('Roll Dice 2'),
        ),
        const SizedBox(height: 20),
        Text(
          'Dice 1 rolled $totalRollsd1 times',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          'Dice 2 rolled $totalRollsd2 times',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          resultText,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        if (totalRollsd1 == 5 && totalRollsd2 == 5) ...[
          const SizedBox(height: 20),
          TextButton(
            onPressed: resetGame,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 147, 106, 218),
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text('Start Over'),
          ),
        ]
      ],
    );
  }
}
