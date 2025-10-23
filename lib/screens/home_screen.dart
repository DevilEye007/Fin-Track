import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_card.dart';
import '../utils/colors.dart';
import '../utils/database_helper.dart';
import 'add_expense_screen.dart';
import 'chart_screen.dart';
import 'developer_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> _expenses = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final expenses = await _databaseHelper.getExpenses();
      setState(() {
        _expenses = expenses;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading expenses: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  double get _totalExpenses {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  void _navigateToChartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChartScreen(expenses: _expenses),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'FinTrack',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: _navigateToChartScreen,
            tooltip: 'View Analytics',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeveloperInfoScreen(),
                ),
              );
            },
            tooltip: 'About App',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          : Column(
              children: [
                // Modern header with total
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8)
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white70,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Total Spent',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₨${_totalExpenses.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_expenses.length} ${_expenses.length == 1 ? 'transaction' : 'transactions'}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Expenses list with modern design
                Expanded(
                  child: _expenses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.receipt_long_outlined,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'No expenses yet',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'Tap the + button below to add your first expense',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 16),
                                child: Text(
                                  'Recent Transactions',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: _loadExpenses,
                                  child: ListView.builder(
                                    itemCount: _expenses.length,
                                    itemBuilder: (context, index) {
                                      final expense = _expenses[index];
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 12),
                                        child: ExpenseCard(
                                          expense: expense,
                                          onDelete: () => _deleteExpense(expense.id),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }

  void _addExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpenseScreen(onExpenseAdded: _onExpenseAdded),
      ),
    );
  }

  void _onExpenseAdded(Expense expense) async {
    try {
      await _databaseHelper.insertExpense(expense);
      await _loadExpenses(); // Reload the list from database
    } catch (e) {
      print('Error adding expense: $e');
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to save expense'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteExpense(String id) async {
    try {
      await _databaseHelper.deleteExpense(id);
      await _loadExpenses(); // Reload the list from database
    } catch (e) {
      print('Error deleting expense: $e');
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to delete expense'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _databaseHelper.close();
    super.dispose();
  }
}