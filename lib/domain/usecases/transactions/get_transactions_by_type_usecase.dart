import '../../repositories/transaction_repository.dart';
import '../../entities/transaction_entity.dart';
import 'package:prac12/core/constants/categories.dart';

class GetTransactionsByTypeUseCase {
  final TransactionRepository repository;

  GetTransactionsByTypeUseCase(this.repository);

  Future<List<TransactionEntity>> call(TransactionType type) {
    return repository.getTransactionsByType(type);
  }
}

