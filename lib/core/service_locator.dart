import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

// Core Models
import 'package:prac12/core/models/transaction_model.dart';

// Data Sources
import 'package:prac12/data/datasources/transaction_local_datasource.dart';
import 'package:prac12/data/datasources/auth_local_datasource.dart';
import 'package:prac12/data/datasources/card_local_datasource.dart';
import 'package:prac12/data/datasources/news_local_datasource.dart';
import 'package:prac12/data/datasources/motivation_local_datasource.dart';
import 'package:prac12/data/datasources/social_local_datasource.dart';

// Repositories
import 'package:prac12/data/repositories/transaction_repository_impl.dart';
import 'package:prac12/data/repositories/auth_repository_impl.dart';
import 'package:prac12/data/repositories/card_repository_impl.dart';
import 'package:prac12/data/repositories/news_repository_impl.dart';
import 'package:prac12/data/repositories/motivation_repository_impl.dart';
import 'package:prac12/data/repositories/social_repository_impl.dart';

// Domain Repositories (interfaces)
import 'package:prac12/domain/repositories/transaction_repository.dart';
import 'package:prac12/domain/repositories/auth_repository.dart';
import 'package:prac12/domain/repositories/card_repository.dart';
import 'package:prac12/domain/repositories/news_repository.dart';
import 'package:prac12/domain/repositories/motivation_repository.dart';
import 'package:prac12/domain/repositories/social_repository.dart';

// Use Cases
import 'package:prac12/domain/usecases/transactions/get_transactions_usecase.dart';
import 'package:prac12/domain/usecases/transactions/add_transaction_usecase.dart';
import 'package:prac12/domain/usecases/transactions/update_transaction_usecase.dart';
import 'package:prac12/domain/usecases/transactions/delete_transaction_usecase.dart';
import 'package:prac12/domain/usecases/transactions/get_transactions_by_type_usecase.dart';
import 'package:prac12/domain/usecases/auth/login_usecase.dart';
import 'package:prac12/domain/usecases/auth/register_usecase.dart';
import 'package:prac12/domain/usecases/auth/logout_usecase.dart';
import 'package:prac12/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:prac12/domain/usecases/cards/get_cards_usecase.dart';
import 'package:prac12/domain/usecases/cards/add_card_usecase.dart';
import 'package:prac12/domain/usecases/cards/delete_card_usecase.dart';
import 'package:prac12/domain/usecases/news/get_news_usecase.dart';
import 'package:prac12/domain/usecases/news/get_currency_rates_usecase.dart';
import 'package:prac12/domain/usecases/motivation/get_random_motivation_usecase.dart';
import 'package:prac12/domain/usecases/social/get_friends_usecase.dart';

// Presentation Stores
import 'package:prac12/ui/features/transactions/state/transaction_form_store.dart';
import 'package:prac12/ui/features/transactions/state/edit_transaction_store.dart';
import 'package:prac12/ui/features/transactions/state/statistics_store.dart';
import 'package:prac12/ui/features/transactions/state/transaction_details_store.dart';
import 'package:prac12/ui/features/onboarding/state/onboarding_store.dart';
import 'package:prac12/ui/features/auth/state/auth_store.dart';
import 'package:prac12/ui/features/cards/state/cards_store.dart';
import 'package:prac12/ui/features/calculator/state/calculator_store.dart';
import 'package:prac12/ui/features/motivation/state/motivation_store.dart';
import 'package:prac12/ui/features/social/state/social_store.dart';
import 'package:prac12/ui/features/news/state/news_store.dart';

// New Clean Architecture Stores
import 'package:prac12/ui/features/transactions/state/transactions_list_store.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // ========== DATA SOURCES ==========
  final transactionLocalDataSource = TransactionLocalDataSource();
  final authLocalDataSource = AuthLocalDataSource();
  final cardLocalDataSource = CardLocalDataSource();
  final newsLocalDataSource = NewsLocalDataSource();
  final motivationLocalDataSource = MotivationLocalDataSource();
  final socialLocalDataSource = SocialLocalDataSource();

  getIt.registerSingleton<TransactionLocalDataSource>(transactionLocalDataSource);
  getIt.registerSingleton<AuthLocalDataSource>(authLocalDataSource);
  getIt.registerSingleton<CardLocalDataSource>(cardLocalDataSource);
  getIt.registerSingleton<NewsLocalDataSource>(newsLocalDataSource);
  getIt.registerSingleton<MotivationLocalDataSource>(motivationLocalDataSource);
  getIt.registerSingleton<SocialLocalDataSource>(socialLocalDataSource);

  // Initialize mock state
  cardLocalDataSource.initializeMockData();
  newsLocalDataSource.initializeMockData();
  motivationLocalDataSource.initializeMockData();
  socialLocalDataSource.initializeMockData();

  // ========== REPOSITORIES ==========
  final transactionRepository = TransactionRepositoryImpl(transactionLocalDataSource);
  final authRepository = AuthRepositoryImpl(authLocalDataSource);
  final cardRepository = CardRepositoryImpl(cardLocalDataSource);
  final newsRepository = NewsRepositoryImpl(newsLocalDataSource);
  final motivationRepository = MotivationRepositoryImpl(motivationLocalDataSource);
  final socialRepository = SocialRepositoryImpl(socialLocalDataSource);

  getIt.registerSingleton<TransactionRepository>(transactionRepository);
  getIt.registerSingleton<AuthRepository>(authRepository);
  getIt.registerSingleton<CardRepository>(cardRepository);
  getIt.registerSingleton<NewsRepository>(newsRepository);
  getIt.registerSingleton<MotivationRepository>(motivationRepository);
  getIt.registerSingleton<SocialRepository>(socialRepository);

  // ========== USE CASES ==========
  // Transactions
  getIt.registerLazySingleton<GetTransactionsUseCase>(
        () => GetTransactionsUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<AddTransactionUseCase>(
        () => AddTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<UpdateTransactionUseCase>(
        () => UpdateTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<DeleteTransactionUseCase>(
        () => DeleteTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetTransactionsByTypeUseCase>(
        () => GetTransactionsByTypeUseCase(getIt<TransactionRepository>()),
  );

  // Auth
  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
        () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  // Cards
  getIt.registerLazySingleton<GetCardsUseCase>(
        () => GetCardsUseCase(getIt<CardRepository>()),
  );
  getIt.registerLazySingleton<AddCardUseCase>(
        () => AddCardUseCase(getIt<CardRepository>()),
  );
  getIt.registerLazySingleton<DeleteCardUseCase>(
        () => DeleteCardUseCase(getIt<CardRepository>()),
  );

  // News
  getIt.registerLazySingleton<GetNewsUseCase>(
        () => GetNewsUseCase(getIt<NewsRepository>()),
  );
  getIt.registerLazySingleton<GetCurrencyRatesUseCase>(
        () => GetCurrencyRatesUseCase(getIt<NewsRepository>()),
  );

  // Motivation
  getIt.registerLazySingleton<GetRandomMotivationUseCase>(
        () => GetRandomMotivationUseCase(getIt<MotivationRepository>()),
  );

  // Social
  getIt.registerLazySingleton<GetFriendsUseCase>(
        () => GetFriendsUseCase(getIt<SocialRepository>()),
  );

  // ========== PRESENTATION STORES ==========
  // Clean Architecture Stores - теперь без параметров
  getIt.registerLazySingleton<TransactionsListStore>(
        () => TransactionsListStore(),
  );

  // Legacy Stores (keeping for backward compatibility)
  getIt.registerLazySingleton<TransactionFormStore>(() => TransactionFormStore());
  getIt.registerLazySingleton<EditTransactionStore>(() => EditTransactionStore());
  getIt.registerLazySingleton<StatisticsStore>(() => StatisticsStore());
  getIt.registerLazySingleton<TransactionDetailsStore>(() => TransactionDetailsStore());
  getIt.registerLazySingleton<OnboardingStore>(() => OnboardingStore());
  getIt.registerLazySingleton<AuthStore>(() => AuthStore());
  getIt.registerLazySingleton<CardsStore>(() => CardsStore());
  getIt.registerLazySingleton<CalculatorStore>(() => CalculatorStore());
  getIt.registerLazySingleton<MotivationStore>(() => MotivationStore());
  getIt.registerLazySingleton<SocialStore>(() => SocialStore());
  getIt.registerLazySingleton<NewsStore>(() => NewsStore());

  // Убираем ObservableList так как мы больше не используем MobX
  // getIt.registerSingleton<ObservableList<Transaction>>(ObservableList<Transaction>());
}