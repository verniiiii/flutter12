import '../../domain/repositories/motivation_repository.dart';
import '../../domain/entities/motivation_entity.dart';
import '../datasources/motivation_local_datasource.dart';
import '../../core/models/motivation_model.dart';

class MotivationRepositoryImpl implements MotivationRepository {
  final MotivationLocalDataSource localDataSource;

  MotivationRepositoryImpl(this.localDataSource);

  MotivationContentEntity _modelToEntity(MotivationContent model) {
    return MotivationContentEntity(
      id: model.id,
      text: model.text,
      author: model.author,
      type: model.type,
      category: model.category,
      isFavorite: model.isFavorite,
    );
  }

  @override
  Future<MotivationContentEntity> getRandomContent(ContentType type) async {
    final model = await localDataSource.getRandomContent(type);
    return _modelToEntity(model);
  }

  @override
  Future<List<MotivationContentEntity>> getFavoriteContent() async {
    final models = await localDataSource.getFavorites();
    return models.map(_modelToEntity).toList();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    await localDataSource.toggleFavorite(id);
  }
}

