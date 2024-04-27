import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<dynamic> numbers = [
    'C',
    '()',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '+',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    'x',
    '+/-',
    '0',
    '.',
    '='
  ];
final Calculator1 calculator = Calculator1(); // Instantiate the calculator logic



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                                    '${calculator.show}',
                                    style: TextStyle(color: Colors.white,fontSize: 60),
                                  ),
                    ],
                  )),
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: numbers.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: _getBackgroundColor(numbers[index]),
                    child: InkWell(
                      onTap: () {
                     // Call handleButtonPress of the calculator logic
calculator.handleButtonPress(numbers[index]);
// Update UI when button is pressed
setState(() {});
                      },
                      borderRadius: BorderRadius.circular(45),
                      child: Center(
                        child: Text(
                          '${numbers[index]}',
                          style: TextStyle(
                            color: _getTextColor(numbers[index]),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(dynamic item) {
    if (item == 'C' ||
        item == '()' ||
        item == '%' ||
        item == '÷' ||
        item == '+' ||
        item == '-' ||
        item == 'x' ||
        item == '+/-' ||
        item == '.' ||
        item == '=') {
      return Colors.orangeAccent[400]!;
    }
    return const Color.fromARGB(255, 193, 193, 193);
  }

  Color _getTextColor(dynamic item) {
    return item == 'C' ||
            item == '()' ||
            item == '%' ||
            item == '÷' ||
            item == '+' ||
            item == '-' ||
            item == 'x' ||
            item == '+/-' ||
            item == '.' ||
            item == '='
        ? Colors.white
        : Colors.black;
  }


}









 // Define a class for the calculator logic
class Calculator1 {
  String show = '';
  double num1 = 0;
  double num2 = 0;
  String op = '';

  String get display => show;

  void handleButtonPress(String input) {
    // Handle button press based on the input
    if (_isNumeric(input)) {
      _appendToDisplay(input);
    } else if (_isOperator(input)) {
      _applyOperator(input);
    } else if (input == '=') {
      _performOperation();
    } else if (input == 'C') {
      _clear();
    }
  }

  bool _isNumeric(String input) {
    return double.tryParse(input) != null || input == '.';
  }

  bool _isOperator(String input) {
    return ['+', '-', 'x', '÷', '%'].contains(input);
  }

  void _appendToDisplay(String value) {
    show += value;
  }

  void _applyOperator(String operator) {
    if (op.isNotEmpty) {
      _performOperation();
    }
    op = operator;
    num1 = double.tryParse(show) ?? 0;
    _appendToDisplay(' $operator ');
  }

  void _performOperation() {
    if (op.isEmpty || show.isEmpty) return;

    List<String> parts = show.split(' ');
    if (parts.length != 3) return; // Invalid expression

    num2 = double.tryParse(parts[2]) ?? 0;
    switch (op) {
      case '+':
        show = (num1 + num2).toString();
        break;
      case '-':
        show = (num1 - num2).toString();
        break;
      case 'x':
        show = (num1 * num2).toString();
        break;
      case '%':
        show = (num1 % num2).toString();
        break;
      case '÷':
        if (num2 == 0) {
          show = 'Error';
        } else {
          show = (num1 / num2).toString();
        }
        break;
      default:
        break;
    }
    op = '';
  }

  void _clear() {
    show = '';
    num1 = 0;
    num2 = 0;
    op = '';
  }
}