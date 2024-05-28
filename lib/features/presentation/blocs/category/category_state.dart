part of 'category_bloc.dart';

class CategoryState extends BaseState<CategoryState> {
  const CategoryState({super.isLoading, super.error, this.categories});

  final List<CategoryModel>? categories;

  @override
  CategoryState copyWith(
      {bool isLoading = false,
      Failure? error,
      List<CategoryModel>? categories}) {
    return CategoryState(
      error: error,
      isLoading: isLoading,
      categories: categories ?? this.categories,
    );
  }
}
