import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
  int currentIndex = 0;
  Color activeColor = Colors.grey[200] as Color;
  String result = '';
  String finalLevel = '';
  double height = 0.0;
  double weight = 0.0;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: isSwitched ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "BMI Calculator",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          actions: [
            Switch(
              activeColor: Colors.greenAccent,
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = !isSwitched;
                  activeColor =
                      (isSwitched ? Colors.grey[900] : Colors.grey[200])!;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    customButton('Man', Colors.blue, 0),
                    customButton('Woman', Colors.pink, 1),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Your Height in Cm',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Your Height in Cm',
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: activeColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Your Weight in Kg',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: weightController,
                  decoration: InputDecoration(
                    hintText: 'Your Weight in Kg',
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: activeColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        height = double.parse(heightController.value.text);
                        weight = double.parse(weightController.value.text);
                      });
                      calculateBMI(height, weight);
                    },
                    color: Colors.blue,
                    child: const Text(
                      'Calculate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Your BMI is: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    finalLevel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI(double height, double weight) {
    double finalResult = weight / (height * height / 10000);
    String bmi = finalResult.toStringAsFixed(2);
    String level = '';
    if (finalResult < 18.5) {
      level = 'Underweight';
    } else if (finalResult >= 18.5 && finalResult <= 24.9) {
      level = 'Normal weight';
    } else if (finalResult >= 25 && finalResult <= 29.9) {
      level = 'Overweight';
    } else if (finalResult >= 30) {
      level = 'Obesity';
    }
    setState(() {
      result = bmi;
      finalLevel = level;
    });
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget customButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
        child: MaterialButton(
          color: currentIndex == index ? color : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: currentIndex == index ? Colors.white : Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            changeIndex(index);
          },
        ),
      ),
    );
  }
}
