import 'package:expenses_tracker/screens/expenses_tracker_main.dart';
import 'package:material_ui/material_ui.dart';

class ExpensesTrackerBase extends StatelessWidget {
  const ExpensesTrackerBase({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expenses Tracker',
      home: ExpensesTrackerMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}
