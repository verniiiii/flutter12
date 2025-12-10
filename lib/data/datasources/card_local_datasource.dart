import 'package:mobx/mobx.dart';
import 'package:prac12/core/models/card_model.dart';

class CardLocalDataSource {
  final ObservableList<CardModel> _cards = ObservableList<CardModel>();

  Future<List<CardModel>> getCards() async {
    // Имитация загрузки
    await Future.delayed(const Duration(seconds: 1));
    return _cards.toList();
  }

  Future<CardModel?> getCardById(String id) async {
    try {
      return _cards.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addCard(CardModel card) async {
    _cards.add(card);
  }

  Future<void> updateCard(CardModel card) async {
    final index = _cards.indexWhere((c) => c.id == card.id);
    if (index != -1) {
      _cards[index] = card;
    }
  }

  Future<void> deleteCard(String id) async {
    _cards.removeWhere((c) => c.id == id);
  }

  void initializeMockData() {
    _cards.clear();
    _cards.addAll([
      CardModel(
        id: '1',
        cardNumber: '1234567812345678',
        cardHolderName: 'ИВАН ИВАНОВ',
        expiryDate: DateTime(2026, 12, 1),
        cvv: '123',
        cardType: CardType.debit,
        bankName: 'Тинькофф',
        balance: 15432.50,
        cardColor: CardColor.blue,
        createdAt: DateTime(2023, 1, 15),
      ),
      CardModel(
        id: '2',
        cardNumber: '8765432187654321',
        cardHolderName: 'ИВАН ИВАНОВ',
        expiryDate: DateTime(2025, 8, 1),
        cvv: '456',
        cardType: CardType.credit,
        bankName: 'Сбербанк',
        balance: 12500.00,
        creditLimit: 150000.00,
        cardColor: CardColor.green,
        createdAt: DateTime(2023, 3, 20),
      ),
    ]);
  }
}

