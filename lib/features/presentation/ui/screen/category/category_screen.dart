import 'package:flutter/material.dart';
import 'package:music_app/config/app_routes.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/search/search_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState
    extends BaseScreenState<CategoryScreen, SearchBloc, SearchState>
    with SingleTickerProviderStateMixin {
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
          padding: EdgeInsets.fromLTRB(15, 0, 15, context.bottomBarHeight),
          sliver: SliverGrid.builder(
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 16 / 10,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        child:
                            "https://cdn.tgdd.vn/Files/2021/09/27/1386105/11-ban-nhac-edm-giup-tao-dong-luc-manh-me-cho-viec-tap-luyen-tai-nha-202109280002110993.jpg"
                                .loadImageUrl(),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Text(
                        "EDM",
                        style: AppTextStyles.bold.copyWith(fontSize: 18),
                      ),
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }

  @override
  bool get safeAreaBottom => false;
}
