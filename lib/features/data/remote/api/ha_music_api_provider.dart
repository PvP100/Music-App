import 'dart:convert';

import 'package:music_app/core/constants/api_path_constants.dart';
import 'package:music_app/features/data/base/base_dio.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';
import 'package:music_app/features/domain/entities/request/register_request.dart';

import '../../models/models.dart';

abstract class HaMusicApiProvider {
  Future<Result<ImageModel>> getRandomImage();
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request);
  Future<Result<CategoriesModel>> getCategories();
  Future<Result<BaseListResponse<TrackModel>>> getTrack(String keyword);
  Future<Result<BaseObjectResponse<Profile>>> getProfile();
  Future<Result<BaseListResponse<HomeMenuModel>>> getHome();
  Future<Result<BaseObjectResponse<AlbumModel>>> getAlbum(String id);
  Future<Result<BaseObjectResponse<AlbumModel>>> getPlaylist(String id);
  Future<Result<BaseListResponse<AlbumModel>>> getListPlaylist(String keyword);
  Future<Result<BaseObjectResponse<SearchAllModel>>> searchAll(String keyword);
  Future<Result<BaseListResponse<AlbumModel>>> getListAlbum(String keyword);
  Future<Result<BaseListResponse<SingerModel>>> getListArtist(String keyword);
  Future<Result<BaseObjectResponse<SingerModel>>> getArtist(String id);
  Future<Result<bool>> logout(String refreshToken);
  Future<Result<bool>> register(RegisterRequest request);
}

class HaMusicApiProviderImpl implements HaMusicApiProvider {
  final IBaseDio _baseDio;

  HaMusicApiProviderImpl(this._baseDio);

  @override
  Future<Result<ImageModel>> getRandomImage() => _baseDio.request(
        'photos/random',
        fromJson: ImageModel.fromJson,
      );

  @override
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request) =>
      _baseDio.request(
        ApiPathConstants.login,
        fromJson: (json) => BaseObjectResponse.fromJson(json, LoginModel()),
        method: ApiMethod.post,
        part: jsonEncode(request.toMap()),
      );

  @override
  Future<Result<CategoriesModel>> getCategories() => _baseDio
      .request(ApiPathConstants.categories, fromJson: CategoriesModel.fromJson);

  @override
  Future<Result<BaseListResponse<TrackModel>>> getTrack(String keyword) =>
      _baseDio.request(
        ApiPathConstants.tracks,
        queryParameters: {
          "fields[]": "*,singers.*,singers.Singer_id.*",
          "search": keyword
        },
        fromJson: (json) => BaseListResponse.fromJson(json, TrackModel()),
      );

  @override
  Future<Result<BaseObjectResponse<Profile>>> getProfile() =>
      _baseDio.request(ApiPathConstants.profile,
          fromJson: (json) => BaseObjectResponse.fromJson(json, Profile()));

  @override
  Future<Result<BaseListResponse<HomeMenuModel>>> getHome() => _baseDio.request(
        ApiPathConstants.home,
        queryParameters: {
          'fields[]': [
            '*',
            'songs.Song_id.*',
            'songs.Song_id.singers.Singer_id.*',
            'albums.Album_id.*',
            'playlists.Playlist_id.*',
            'albums.Album_id.singers.Singer_id.*',
            'playlists.Playlist_id.singers.Singer_id.*',
          ],
        },
        fromJson: (json) => BaseListResponse.fromJson(json, HomeMenuModel()),
      );

  @override
  Future<Result<BaseObjectResponse<AlbumModel>>> getAlbum(String id) =>
      _baseDio.request("${ApiPathConstants.album}/$id",
          queryParameters: {
            "fields[]": [
              '*,singers.*,singers.Singer_id.*',
              '*,songs.*,songs.Song_id.*',
              '*,songs.*,songs.Song_id.singers.Singer_id.*',
            ],
          },
          fromJson: (json) => BaseObjectResponse.fromJson(json, AlbumModel()));

  @override
  Future<Result<BaseObjectResponse<AlbumModel>>> getPlaylist(String id) =>
      _baseDio.request("${ApiPathConstants.playlist}/$id",
          queryParameters: {
            "fields[]": [
              '*,singers.*,singers.Singer_id.*',
              '*,songs.*,songs.Song_id.*',
              '*,songs.*,songs.Song_id.singers.Singer_id.*',
            ],
          },
          fromJson: (json) => BaseObjectResponse.fromJson(json, AlbumModel()));

  @override
  Future<Result<BaseObjectResponse<SearchAllModel>>> searchAll(
    String keyword,
  ) =>
      _baseDio.request(ApiPathConstants.search,
          method: ApiMethod.post,
          part: jsonEncode(<String, dynamic>{
            'query':
                'query Search(\$searchTerm: String!) { Singer(search: \$searchTerm) { id status sort  date_created  date_updated name gender birthday nation bio thumbnail { id storage filename_disk filename_download title type  uploaded_on  modified_on charset filesize width height duration embed description location tags metadata focal_point_x focal_point_y } songs { id Song_id { id status sort  date_created  date_updated name is_featured } } playlist { id Playlist_id { id status sort  date_created  date_updated name } } albums { id Album_id { id status sort  date_created  date_updated name } } } Song(search: \$searchTerm) { id status sort  date_created  date_updated name is_featured singers { id Singer_id { id status sort  date_created  date_updated name gender birthday nation bio } } playlist { id Playlist_id { id status sort  date_created  date_updated name } } liked { id directus_users_id } album { id Album_id { id status sort  date_created  date_updated name } } file { id storage filename_disk filename_download title type  uploaded_on  modified_on charset filesize width height duration embed description location tags metadata focal_point_x focal_point_y } thumbnail { id storage filename_disk filename_download title type  uploaded_on  modified_on charset filesize width height duration embed description location tags metadata focal_point_x focal_point_y } } Album(search: \$searchTerm) { id status sort  date_created  date_updated name thumbnail { id storage filename_disk filename_download title type  uploaded_on  modified_on charset filesize width height duration embed description location tags metadata focal_point_x focal_point_y } singers { id Singer_id { id status sort  date_created  date_updated name gender birthday nation bio } } songs { id Song_id { id status sort  date_created  date_updated name is_featured } } } Playlist(search: \$searchTerm) { id status sort  date_created  date_updated name thumbnail { id storage filename_disk filename_download title type  uploaded_on  modified_on charset filesize width height duration embed description location tags metadata focal_point_x focal_point_y } songs { id Song_id { id status sort  date_created  date_updated name is_featured } } singers { id Singer_id { id status sort  date_created  date_updated name gender birthday nation bio } } } }',
            'variables': {
              'searchTerm': keyword,
            }
          }),
          fromJson: (json) =>
              BaseObjectResponse.fromJson(json, SearchAllModel()));

  @override
  Future<Result<BaseListResponse<AlbumModel>>> getListAlbum(String keyword) =>
      _baseDio.request(ApiPathConstants.album,
          queryParameters: {
            "fields[]": [
              '*,singers.*,singers.Singer_id.*',
              '*,songs.*,songs.Song_id.*',
              '*,songs.*,songs.Song_id.singers.Singer_id.*',
            ],
            "search": keyword,
          },
          fromJson: (json) => BaseListResponse.fromJson(json, AlbumModel()));

  @override
  Future<Result<BaseListResponse<AlbumModel>>> getListPlaylist(
          String keyword) =>
      _baseDio.request(ApiPathConstants.playlist,
          queryParameters: {
            "fields[]": [
              '*,singers.*,singers.Singer_id.*',
              '*,songs.*,songs.Song_id.*',
              '*,songs.*,songs.Song_id.singers.Singer_id.*',
            ],
          },
          fromJson: (json) => BaseListResponse.fromJson(json, AlbumModel()));

  @override
  Future<Result<BaseListResponse<SingerModel>>> getListArtist(String keyword) =>
      _baseDio.request(ApiPathConstants.artist,
          queryParameters: {
            // "fields[]": "",
            "search": keyword,
          },
          fromJson: (json) => BaseListResponse.fromJson(json, SingerModel()));

  @override
  Future<Result<BaseObjectResponse<SingerModel>>> getArtist(String id) =>
      _baseDio.request("${ApiPathConstants.artist}/$id",
          queryParameters: {
            'fields[]': [
              '*',
              'songs.Song_id.*',
              'songs.Song_id.singers.*',
              'songs.Song_id.singers.Singer_id.*',
              'playlist.Playlist_id.*',
              'playlist.Playlist_id.singers.Singer_id.*'
            ]
          },
          fromJson: (json) => BaseObjectResponse.fromJson(json, SingerModel()));

  @override
  Future<Result<bool>> logout(String refreshToken) => _baseDio.request(
        ApiPathConstants.logout,
        fromJson: (json) => true,
        part: jsonEncode(<String, dynamic>{'refresh_token': refreshToken}),
        method: ApiMethod.post,
      );

  @override
  Future<Result<bool>> register(RegisterRequest request) => _baseDio.request(
        ApiPathConstants.register,
        method: ApiMethod.post,
        part: jsonEncode(request.toMap()),
        fromJson: (json) => true,
      );
}
