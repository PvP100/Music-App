import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/entities/home_menu_entity.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class GetHomeMenu extends UseCase<List<HomeMenuEntity>, None> {
  final HamusicRepository _repository;

  GetHomeMenu(this._repository);

  @override
  Future<Result<List<HomeMenuEntity>>> run(None params) async {
    Result<BaseListResponse<HomeMenuModel>> homeMenu =
        await _repository.getHomeMenu();
    final newMap = homeMenu.convert((data) {
      List<HomeMenuModel> apiData = data?.data ?? [];
      List<HomeMenuEntity> entities = apiData.map((e) {
        return HomeMenuEntity(
          id: e.id,
          title: e.title,
          data: _getList(e),
          isSong: e.songs?.isNotEmpty == true,
        );
      }).toList();

      return entities;
    });
    return newMap;
  }

  List<ChildHomeMenuEntity> _getList(HomeMenuModel menu) {
    if (menu.songs?.isNotEmpty == true) {
      return (menu.songs ?? [])
          .map(
            (e) => ChildHomeMenuEntity(
                id: e.data?.id,
                name: e.data?.name,
                thumbnail: e.data?.thumbnail.filePathUrl(),
                artists: e.data?.singers
                    ?.map((e) => e.data?.name)
                    .toList()
                    .join(', ')),
          )
          .toList();
    }
    if (menu.albums?.isNotEmpty == true) {
      return (menu.albums ?? [])
          .map((e) => ChildHomeMenuEntity(
                id: e.data?.id,
                name: e.data?.name,
                thumbnail: e.data?.thumbnail.filePathUrl(),
                artists: e.data?.singers
                    ?.map((e) => e.data?.name)
                    .toList()
                    .join(', '),
              ))
          .toList();
    }
    if (menu.playlist?.isNotEmpty == true) {
      return (menu.playlist ?? [])
          .map((e) => ChildHomeMenuEntity(
                id: e.data?.id,
                name: e.data?.name,
                isPlaylist: true,
                thumbnail: e.data?.thumbnail.filePathUrl(),
                artists: e.data?.singers
                    ?.map((e) => e.data?.name)
                    .toList()
                    .join(', '),
              ))
          .toList();
    }
    return [];
  }
}
