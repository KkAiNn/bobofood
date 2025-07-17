import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/utils/utils.dart';
import 'package:flutter/material.dart';

/// 底部导航栏项目模型
class NavBottomItem {
  final IconData? icon;
  final IconData? activeIcon;
  final String? label;
  final Widget page;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? svgPath;

  const NavBottomItem({
    this.icon,
    this.label,
    this.activeIcon,
    required this.page,
    this.activeColor,
    this.inactiveColor,
    this.svgPath,
  });
}

/// 通用底部导航栏组件
class CustomNavBottom extends StatefulWidget {
  /// 导航项列表
  final List<NavBottomItem> items;

  /// 当前选中的索引
  final int currentIndex;

  /// 点击回调
  final Function(int index) onTap;

  /// 导航栏背景色
  final Color? backgroundColor;

  /// 选中项颜色
  final Color? selectedItemColor;

  /// 未选中项颜色
  final Color? unselectedItemColor;

  /// 导航栏类型
  final BottomNavigationBarType type;

  /// 导航栏高度
  final double? height;

  /// 图标大小
  final double iconSize;

  /// 文字样式
  final TextStyle? labelStyle;

  /// 是否显示标签
  final bool showLabels;

  /// 是否启用阴影
  final bool enableShadow;

  /// 圆角半径
  final double borderRadius;

  /// 边距
  final EdgeInsets? margin;

  /// 是否安全区域
  final bool useSafeArea;

  const CustomNavBottom({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.type = BottomNavigationBarType.fixed,
    this.height,
    this.iconSize = 32.0,
    this.labelStyle,
    this.showLabels = true,
    this.enableShadow = true,
    this.borderRadius = 0.0,
    this.margin,
    this.useSafeArea = true,
  });

  @override
  State<CustomNavBottom> createState() => _CustomNavBottomState();
}

class _CustomNavBottomState extends State<CustomNavBottom>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animationControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _animations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut),
      );
    }).toList();

    // 初始化当前选中项的动画
    if (widget.currentIndex < _animationControllers.length) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void didUpdateWidget(CustomNavBottom oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentIndex != widget.currentIndex) {
      // 重置之前的动画
      if (oldWidget.currentIndex < _animationControllers.length) {
        // 使用动画控制器的animateBack方法来实现平滑的还原动画
        _animationControllers[oldWidget.currentIndex].animateBack(
          0.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      }

      // 启动新的动画
      if (widget.currentIndex < _animationControllers.length) {
        _animationControllers[widget.currentIndex].forward();
      }
    }
  }

  Widget _buildIcon(NavBottomItem item, bool isSelected, Color itemColor) {
    return item.svgPath != null
        ? AppSvg(
            path: item.svgPath!,
            width: widget.iconSize,
            height: widget.iconSize,
            color: itemColor,
          )
        : Icon(
            isSelected && item.activeIcon != null
                ? item.activeIcon!
                : item.icon,
            size: widget.iconSize,
            color: itemColor,
          );
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBgColor =
        theme.bottomNavigationBarTheme.backgroundColor ?? theme.canvasColor;
    final defaultSelectedColor =
        theme.bottomNavigationBarTheme.selectedItemColor ?? theme.primaryColor;
    final defaultUnselectedColor =
        theme.bottomNavigationBarTheme.unselectedItemColor ??
            theme.unselectedWidgetColor;

    Widget navBar = Container(
      height: widget.height ?? (widget.showLabels ? 70.0 : 60.0),
      margin: widget.margin,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? defaultBgColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: widget.enableShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, -2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = index == widget.currentIndex;

          final itemColor = isSelected
              ? (item.activeColor ??
                  widget.selectedItemColor ??
                  defaultSelectedColor)
              : (item.inactiveColor ??
                  widget.unselectedItemColor ??
                  defaultUnselectedColor);

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTap(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animations[index].value *
                            Utils.degreesToRadians((isSelected ? -20 : 0)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIcon(item, isSelected, itemColor),
                            if (widget.showLabels) ...[
                              const SizedBox(height: 4.0),
                              Text(
                                item.label ?? '',
                                style: (widget.labelStyle ??
                                        theme.textTheme.bodySmall)
                                    ?.copyWith(
                                  color: itemColor,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animations[index].value,
                        child: AppSvg(
                          path: 'assets/tabbar/arrow_up.svg',
                          width: 8,
                          height: 6,
                          color: AppColors.colors.icon.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );

    if (widget.useSafeArea) {
      navBar = SafeArea(
        top: false,
        child: navBar,
      );
    }

    return navBar;
  }
}
