import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CommonTabBar extends StatelessWidget {
  const CommonTabBar({
    super.key,
    required this.tabController,
    required this.listTitle,
    this.padding = EdgeInsets.zero,
    required this.onTabChanged,
  });

  final TabController tabController;
  final List<String> listTitle;
  final EdgeInsets padding;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.start,
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
      onTap: onTabChanged,
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
