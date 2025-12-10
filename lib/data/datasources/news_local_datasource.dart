import 'package:mobx/mobx.dart';
import 'package:prac12/core/models/news_model.dart';
import 'dart:math';

class NewsLocalDataSource {
  final ObservableList<NewsArticle> _articles = ObservableList<NewsArticle>();
  final ObservableList<CurrencyRate> _rates = ObservableList<CurrencyRate>();

  Future<List<NewsArticle>> getNews() async {
    return _articles.toList();
  }

  Future<NewsArticle?> getNewsById(String id) async {
    try {
      return _articles.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<CurrencyRate>> getCurrencyRates() async {
    return _rates.toList();
  }

  Future<void> markAsRead(String id) async {
    final index = _articles.indexWhere((a) => a.id == id);
    if (index != -1) {
      _articles[index] = _articles[index].copyWith(isRead: true);
    }
  }

  Future<void> initializeMockData() async {
    _rates.addAll([
      CurrencyRate(
        code: 'USD',
        name: 'Доллар США',
        rate: 92.45,
        change: 0.75,
        changePercent: 0.82,
        symbol: '\$',
      ),
      CurrencyRate(
        code: 'EUR',
        name: 'Евро',
        rate: 99.80,
        change: -0.32,
        changePercent: -0.32,
        symbol: '€',
      ),
      CurrencyRate(
        code: 'GBP',
        name: 'Фунт стерлингов',
        rate: 115.20,
        change: 1.10,
        changePercent: 0.96,
        symbol: '£',
      ),
    ]);

    _articles.addAll([
      NewsArticle(
        id: '1',
        title: 'ЦБ РФ сохранил ключевую ставку на уровне 16%',
        summary: 'Банк России принял решение сохранить ключевую ставку на уровне 16% годовых.',
        category: NewsCategory.finance,
        source: 'РБК',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NewsArticle(
        id: '2',
        title: 'Курс доллара обновил максимум с начала года',
        summary: 'Доллар США на Московской бирже подорожал до 93 рублей.',
        category: NewsCategory.finance,
        source: 'Коммерсантъ',
        publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ]);
  }
}

