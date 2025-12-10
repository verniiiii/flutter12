import 'package:mobx/mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:prac12/core/models/transaction_model.dart';

class TransactionLocalDataSource {
  ObservableList<Transaction> get transactions => 
      GetIt.I<ObservableList<Transaction>>();

  Future<List<Transaction>> getTransactions() async {
    return transactions.toList();
  }

  Future<Transaction?> getTransactionById(String id) async {
    try {
      return transactions.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    transactions.add(transaction);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final index = transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      transactions[index] = transaction;
    }
  }

  Future<void> deleteTransaction(String id) async {
    transactions.removeWhere((t) => t.id == id);
  }
}

