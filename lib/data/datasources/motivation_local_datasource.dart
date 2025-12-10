import 'package:prac12/core/models/motivation_model.dart';

class MotivationLocalDataSource {
  final List<MotivationContent> _content = [];

  Future<MotivationContent> getRandomContent(ContentType type) async {
    final filtered = _content.where((c) => c.type == type).toList();
    if (filtered.isEmpty) {
      throw Exception('No content found for type: $type');
    }
    final random = DateTime.now().millisecondsSinceEpoch % filtered.length;
    return filtered[random];
  }

  Future<List<MotivationContent>> getFavorites() async {
    return _content.where((c) => c.isFavorite).toList();
  }

  Future<void> toggleFavorite(String id) async {
    final index = _content.indexWhere((c) => c.id == id);
    if (index != -1) {
      _content[index] = _content[index].copyWith(
        isFavorite: !_content[index].isFavorite,
      );
    }
  }

  Future<void> initializeMockData() async {
    _content.addAll([
      MotivationContent(
        id: '1',
        text: 'Единственный способ сделать что-то очень хорошо — любить то, что ты делаешь.',
        author: 'Стив Джобс',
        type: ContentType.quote,
        category: 'Успех',
      ),
      MotivationContent(
        id: '2',
        text: 'Я достоин успеха и процветания',
        type: ContentType.affirmation,
        category: 'Уверенность',
      ),
      MotivationContent(
        id: '3',
        text: 'Начните свой день с 15 минут медитации',
        type: ContentType.tip,
        category: 'Утро',
      ),
    ]);
  }
}

