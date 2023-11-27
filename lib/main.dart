import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarApp(),
    );
  }
}

class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() => CalendarAppState();
}

class CalendarAppState extends State<CalendarApp> {
  TextEditingController dateController = TextEditingController();
  TextEditingController dateIosController = TextEditingController();
  String date = '';
  DateTime? dateFullWithSeconds;
  DateTime? dateIosFullWithSeconds;
  DateTime dateIos = DateTime.now();
  String dateOfBirthIos = '';

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1925),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        dateFullWithSeconds = DateTime.parse(dateController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Select the date for Android'),
                prefixIcon: Icon(Icons.calendar_month),
                hintText: 'Select the date',
              ),
              onTap: () {
                //dateFullWithSeconds= DateTime.parse(DateController.text);
                selectDate();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              '${dateController.text}',
              style: const TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
            ),
          ),
// ElevatedButton(onPressed: (){changeDateToFull(DateController.text.toString());},
//   child: const Text('Change to full date'),),
          Center(
            child: Text('${dateFullWithSeconds ?? 'no value'}'),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dateIosController,
              decoration: const InputDecoration(
                label: Text('Select the date for IoS'),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_month),
                hintText: 'Select Ios date',
              ),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: SizedBox(
                        height: 250,
                        child: CupertinoDatePicker(
                          backgroundColor: Colors.lightBlueAccent,
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: dateIos,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              dateIos = newDate;
                              dateIosController.text =
                                  DateFormat('yyyy-MM-dd').format(dateIos);
                              dateIosFullWithSeconds =
                                  DateTime.parse(dateIosController.text);
                            });
                          },
                        ),
                      ),
                    );

                  },
                );
                //dateFullWithSeconds= DateTime.parse(DateController.text);
                //showDialogCalendar;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              dateIosController.text,
              style: const TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Center(child: Text('${dateIosFullWithSeconds ?? 'Not value'}')),
        ],
      ),
    );
  }
}
