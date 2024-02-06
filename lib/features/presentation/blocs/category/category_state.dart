part of 'category_bloc.dart';

class CategoryState extends BaseState<CategoryState> {
  const CategoryState({super.isLoading, super.error});

  @override
  CategoryState copyWith({bool isLoading = false, Failure? error}) {
    return CategoryState(
      error: error,
      isLoading: isLoading,
    );
  }
}
