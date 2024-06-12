import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/config/app_routes.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState
    extends BaseScreenState<CategoryScreen, CategoryBloc, CategoryState>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    bloc.getCategories();
  }

  @override
  Widget buildContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.primaryBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          pinned: true,
          primary: false,
          toolbarHeight: 60,
          flexibleSpace: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: Row(children: [
              ImageConstants.iconSearch
                  .loadImageAsset(height: 20, width: 20)
                  .paddingOnly(left: 10, right: 8),
              Text(
                "Bạn muốn nghe gì",
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: AppColors.colorA4A4A4,
                ),
              )
            ]).onCupertinoClick(() {
              context.pushNamed(
                RouteConstants.search,
                transitionType: TransitionType.fade,
              );
            }),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, context.bottomBarHeight + 15),
          sliver: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return SliverGrid.builder(
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 16 / 10,
                  ),
                  itemBuilder: (context, index) {
                    final model = state.categories?[index];
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            child: model?.icons?.firstOrNull?.url
                                .loadImageUrl(fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Text(
                            model?.name ?? "",
                            style: AppTextStyles.bold.copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
        )
      ],
    );
  }

  @override
  bool get safeAreaBottom => false;
}
