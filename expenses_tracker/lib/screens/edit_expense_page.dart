import 'package:material_ui/material_ui.dart';

class EditExpensePage extends StatefulWidget {
  const EditExpensePage({super.key, required this.initialAmount});

  final double initialAmount;

  @override
  State<EditExpensePage> createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    final initialAmount = widget.initialAmount;
    amountController = TextEditingController(
      text: initialAmount == initialAmount.roundToDouble()
          ? initialAmount.toStringAsFixed(0)
          : initialAmount.toString(),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _save() {
    final amount = double.tryParse(amountController.text.trim());
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Մուտքագրեք ճիշտ գումար'),
        ),
      );
      return;
    }

    Navigator.pop(context, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Խմբագրել գումարը'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Գումար', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Մուտքագրիր գումարի չափը',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Text('Պահպանել'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
