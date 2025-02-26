///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsVi implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsVi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsVi _root = this; // ignore: unused_field

	// Translations
	@override String hello({required Object name}) => 'Xin chào ${name}';
	@override String get save => 'Lưu';
	@override late final _TranslationsLoginVi login = _TranslationsLoginVi._(_root);
	@override String get done => 'Xong';
	@override String get screenNotFound => 'Không tìm thấy màn hình';
	@override String get noInternetConnection => 'Không có kết nối mạng';
	@override String get badRequest => 'Yêu cầu không hợp lệ';
	@override String get dataNotFound => 'Không tìm thấy URL đã chỉ định';
	@override String get serverError => 'Lỗi máy chủ';
	@override String get unauthorized => 'Không được phép';
}

// Path: login
class _TranslationsLoginVi implements TranslationsLoginEn {
	_TranslationsLoginVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get success => 'Đăng nhập thành công';
	@override String get fail => 'Đăng nhập thất bại';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsVi {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return ({required Object name}) => 'Xin chào ${name}';
			case 'save': return 'Lưu';
			case 'login.success': return 'Đăng nhập thành công';
			case 'login.fail': return 'Đăng nhập thất bại';
			case 'done': return 'Xong';
			case 'screenNotFound': return 'Không tìm thấy màn hình';
			case 'noInternetConnection': return 'Không có kết nối mạng';
			case 'badRequest': return 'Yêu cầu không hợp lệ';
			case 'dataNotFound': return 'Không tìm thấy URL đã chỉ định';
			case 'serverError': return 'Lỗi máy chủ';
			case 'unauthorized': return 'Không được phép';
			default: return null;
		}
	}
}

