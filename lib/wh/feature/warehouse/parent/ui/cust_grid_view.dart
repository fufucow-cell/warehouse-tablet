import 'package:flutter/material.dart';

/// 自定义网格视图，支持自适应高度的懒加载网格布局
class CustGridView extends StatelessWidget {
  /// 总 item 数量
  final int itemCount;

  /// 构建每个 item 的 builder
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// 每行的列数，默认为 3
  final int crossAxisCount;

  /// 内边距
  final EdgeInsets? padding;

  /// 水平间距（列之间的间距）
  final double crossAxisSpacing;

  /// 垂直间距（行之间的间距）
  final double mainAxisSpacing;

  /// 滚动物理效果
  final ScrollPhysics? physics;

  /// 是否收缩包装
  final bool shrinkWrap;

  const CustGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 3,
    this.padding,
    this.crossAxisSpacing = 32.0,
    this.mainAxisSpacing = 32.0,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final rowCount = (itemCount / crossAxisCount).ceil();
    final defaultPadding = padding ?? EdgeInsets.zero;

    return CustomScrollView(
      physics: physics ?? const ClampingScrollPhysics(),
      shrinkWrap: shrinkWrap,
      slivers: [
        SliverPadding(
          padding: defaultPadding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, rowIndex) {
                final startIndex = rowIndex * crossAxisCount;
                final rowItems = <Widget>[];

                for (int i = 0; i < crossAxisCount; i++) {
                  final itemIndex = startIndex + i;

                  if (i > 0) {
                    rowItems.add(SizedBox(width: crossAxisSpacing));
                  }

                  if (itemIndex < itemCount) {
                    rowItems.add(
                      Expanded(
                        child: itemBuilder(context, itemIndex),
                      ),
                    );
                  } else {
                    // 如果这一行不满 crossAxisCount 个，用空的 Expanded 填充
                    rowItems.add(const Expanded(child: SizedBox()));
                  }
                }

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: rowIndex < rowCount - 1 ? mainAxisSpacing : 0,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: rowItems,
                    ),
                  ),
                );
              },
              childCount: rowCount,
            ),
          ),
        ),
      ],
    );
  }
}
