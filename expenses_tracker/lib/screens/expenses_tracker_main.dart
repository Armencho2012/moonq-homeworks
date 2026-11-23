import 'package:expenses_tracker/models/category.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/screens/edit_expense_page.dart';
import 'package:expenses_tracker/widgets/expense_tile.dart';
import 'package:material_ui/material_ui.dart';

class ExpensesTrackerMain extends StatefulWidget {
  const ExpensesTrackerMain({super.key});

  @override
  State<ExpensesTrackerMain> createState() => _ExpensesTrackerMainState();
}

class _ExpensesTrackerMainState extends State<ExpensesTrackerMain> {
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController amountInputController = TextEditingController();
  Category? selectedCategory = Category.food;
  Category? filterCategory;
  List<Expense> expenses = [];

  @override
  void dispose() {
    nameInputController.dispose();
    amountInputController.dispose();
    super.dispose();
  }

  void addExpense() {
    final title = nameInputController.text.trim();
    final amount = double.tryParse(amountInputController.text);

    if (title.isEmpty || amount == null || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Մուտքագրեք անվանումը, ճիշտ գումար և ընտրեք կատեգորիա'),
        ),
      );
      return;
    }

    setState(() {
      expenses.add(Expense(
        id: expenses.length + 1,
        title: title,
        amount: amount,
        category: selectedCategory!,
      ));
      nameInputController.clear();
      amountInputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleExpenses = expenses
        .where((e) => filterCategory == null || e.category == filterCategory)
        .toList();

    final total = visibleExpenses.fold(0.0, (sum, e) => sum + e.amount);

    final totalText = total.toStringAsFixed(total % 1 == 0 ? 0 : 2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ընդամենը՝ $totalText դր.'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Անվանում', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                TextField(
                  controller: nameInputController,
                  decoration: InputDecoration(
                    hintText: 'Մուտքագրիր քո անունը',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      gapPadding: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text('Գումար', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                TextField(
                  controller: amountInputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Մուտքագրիր գումարի չափը',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      gapPadding: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: Category.values.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = Category.values[index];
                      return ChoiceChip(
                        label: Text(category.displayName),
                        selected: selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = selected ? category : null;
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 5);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: addExpense,
                    icon: const Icon(Icons.add),
                    label: const Text('Ավելացնել'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ծախսեր',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: Category.values.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ChoiceChip(
                          label: const Text('Բոլորը'),
                          selected: filterCategory == null,
                          onSelected: (_) {
                            setState(() {
                              filterCategory = null;
                            });
                          },
                        );
                      }

                      final category = Category.values[index - 1];
                      return ChoiceChip(
                        label: Text(category.displayName),
                        selected: filterCategory == category,
                        onSelected: (_) {
                          setState(() {
                            filterCategory = category;
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                if (visibleExpenses.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text('Դեռ ծախսեր չկան'),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visibleExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = visibleExpenses[index];
                      return Dismissible(
                        key: ObjectKey(expense),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          final originalIndex = expenses.indexOf(expense);
                          final removedExpense = expense;
                          setState(() {
                            expenses.removeAt(originalIndex);
                          });

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Ծախսը ջնջվեց'),
                              action: SnackBarAction(
                                label: 'Վերադարձնել',
                                onPressed: () {
                                  setState(() {
                                    expenses.insert(
                                      originalIndex,
                                      removedExpense,
                                    );
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: ExpenseTile(
                          expense: expense,
                          onTap: () async {
                            final newAmount = await Navigator.push<double>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditExpensePage(
                                  initialAmount: expense.amount,
                                ),
                              ),
                            );

                            if (newAmount == null) {
                              return;
                            }

                            final originalIndex = expenses.indexOf(expense);
                            if (originalIndex == -1) {
                              return;
                            }

                            setState(() {
                              expenses[originalIndex] = Expense(
                                id: expense.id,
                                title: expense.title,
                                amount: newAmount,
                                category: expense.category,
                              );
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
