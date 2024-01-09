import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController costController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int selectedDays = 0;
  String resultText = '\$ 0';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: HomeScreenBody(
          costController: costController,
          daysController: daysController,
          fromDate: fromDate,
          toDate: toDate,
          selectedDays: selectedDays,
          resultText: resultText,
          onCalculate: _handleCalculate,
          onDatePick: _handleDatePick,
        ),
      ),
    );
  }

  void _handleCalculate() {
    double cost = double.tryParse(costController.text) ?? 0;
    int days = int.tryParse(daysController.text) ?? 0;
    double result = 8 * days * cost;

    setState(() {
      resultText = '\$ ${result.toStringAsFixed(0)}';
    });

    print('Result: $result');
  }

  void _handleDatePick() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
        selectedDays = (toDate.difference(fromDate).inDays) + 1;
        daysController.text = selectedDays.toString();
      });
    }
  }
}

class HomeScreenBody extends StatelessWidget {
  final TextEditingController costController;
  final TextEditingController daysController;
  final DateTime fromDate;
  final DateTime toDate;
  final int selectedDays;
  final String resultText;
  final VoidCallback onCalculate;
  final VoidCallback onDatePick;

  HomeScreenBody({
    required this.costController,
    required this.daysController,
    required this.fromDate,
    required this.toDate,
    required this.selectedDays,
    required this.resultText,
    required this.onCalculate,
    required this.onDatePick,
  });

@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoWidget(),
            SizedBox(height: 20),
            ContainerWidget(
              costController: costController,
              daysController: daysController,
              fromDate: fromDate,
              toDate: toDate,
              selectedDays: selectedDays,
              resultText: resultText,
              onCalculate: onCalculate,
              onDatePick: onDatePick,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 51,
            height: 51,
            margin: EdgeInsets.only(left: 15),
            child: Image.asset('assets/per2.png'),
          ),
          SizedBox(width: 20),
          UserInfoDetailsWidget(),
        ],
      ),
    );
  }
}

class UserInfoDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            'Hi, Ulyana!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'SrbijaSans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 7),
        SizedBox(
          child: Text(
            'hjkdjbdhdhjsk@gmail.com',
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 16,
              fontFamily: 'SrbijaSans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final TextEditingController costController;
  final TextEditingController daysController;
  final DateTime fromDate;
  final DateTime toDate;
  final int selectedDays;
  final String resultText;
  final VoidCallback onCalculate;
  final VoidCallback onDatePick;

  ContainerWidget({
    required this.costController,
    required this.daysController,
    required this.fromDate,
    required this.toDate,
    required this.selectedDays,
    required this.resultText,
    required this.onCalculate,
    required this.onDatePick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 342,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 7),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Positioned(
            left: 73,
            bottom: 15,
            height: 50,
            child: GestureDetector(
              onTap: onCalculate,
              child: CalculateButton(),
            ),
          ),
          Positioned(
            left: 15,
            top: 15,
            right: 15,
            child: CostPerHourTextField(costController: costController),
          ),
          Positioned(
            left: 15,
            top: 99,
            right: 15,
            height: 64,
            child: GestureDetector(
              onTap: onDatePick,
              child: DateRangePickerField(
                selectedDays: selectedDays,
                daysController: daysController,
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 203,
            child: ResultText(resultText: resultText),
          ),
        ],
      ),
    );
  }
}

class CalculateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Calculate',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Srbija Sans',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.30,
            ),
          ),
        ],
      ),
    );
  }
}

class CostPerHourTextField extends StatelessWidget {
  final TextEditingController costController;

  CostPerHourTextField({required this.costController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.only(left: 15),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontFamily: 'SrbijaSans',
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                hintText: 'Cost per hour',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                  fontFamily: 'SrbijaSans',
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateRangePickerField extends StatelessWidget {
  final int selectedDays;
  final TextEditingController daysController;

  DateRangePickerField({
    required this.selectedDays,
    required this.daysController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7, left: 15, right: 7, bottom: 7),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              selectedDays != 0 ? selectedDays.toString() : 'Days worked',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontFamily: 'SrbijaSans',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
              child: Image.asset('assets/botton.png')
          ),
        ],
      ),
    );
  }
}

class ResultText extends StatelessWidget {
  final String resultText;

  ResultText({required this.resultText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      child: Text(
        resultText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontFamily: 'Srbija Sans',
          fontWeight: FontWeight.w700,
          height: 0.24,
        ),
      ),
    );
  }
}