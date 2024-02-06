import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CommonTabBar extends StatelessWidget {
  const CommonTabBar({
    super.key,
    required this.tabController,
    required this.listTitle,
    this.padding = EdgeInsets.zero,
  });

  final TabController tabController;
  final List<String> listTitle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: padding,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      splashFactory: NoSplash.splashFactory,
      indicator: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: AppTextStyles.medium.copyWith(fontSize: 14),
      labelColor: Colors.white,
      unselectedLabelColor: AppColors.colorCACACA,
      isScrollable: true,
      tabs: listTitle
          .map(
            (value) => Text(
              value,
            ).paddingSymmetric(vertical: 5.5, horizontal: 16),
          )
          .toList(),
      controller: tabController,
    );
  }
}
