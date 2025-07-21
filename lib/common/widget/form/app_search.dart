import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

class AppSearchDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String? hintText;
  final T? selectedItem;
  final ValueChanged<T>? onChanged;
  final void Function(String)? onSubmitted;
  final String Function(T)? itemToString;

  const AppSearchDropdown({
    super.key,
    required this.items,
    this.hintText,
    this.selectedItem,
    this.onChanged,
    this.itemToString,
    this.onSubmitted,
  });

  @override
  State<AppSearchDropdown<T>> createState() => _AppSearchDropdownState<T>();
}

class _AppSearchDropdownState<T> extends State<AppSearchDropdown<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late final AppInputController _controller;
  late final ListController<T> listController = ListController<T>(
      enablePullDown: false, defaultItems: widget.items, autoInit: true);
  late OverlayEntry _overlayEntry;
  bool _isDropdownOpen = false;
  List<T> _filteredItems = [];

  // 添加动画控制器
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AppInputController(
      initialValue: widget.selectedItem?.toString() ?? '',
    );
    _filteredItems = widget.items;

    // 初始化动画控制器
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _heightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
    setState(() => _isDropdownOpen = true);
    // 启动动画
    _animationController.forward();
  }

  void _closeDropdown() {
    // 反向运行动画，然后移除遮罩
    _animationController.reverse().then((_) {
      _overlayEntry.remove();
      setState(() => _isDropdownOpen = false);
    });
    FocusScope.of(context).unfocus();
  }

  void _onTap(T item) {
    _controller.text = item.toString();
    widget.onChanged?.call(item);
    FocusScope.of(context).unfocus();
    _closeDropdown();
  }

  void _onSubmitted(String value) {
    widget.onSubmitted?.call(value);
    _closeDropdown();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final inputHeight = size.height;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 上半部分遮罩（输入框上方）
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: offset.dy,
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // 下半部分遮罩（下拉菜单下方）
          Positioned(
            left: 0,
            top: offset.dy + inputHeight + 5 + 212.h, // 输入框底部 + 间距 + 最大下拉高度
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // 左侧遮罩
          Positioned(
            left: 0,
            top: offset.dy,
            width: offset.dx,
            height: inputHeight + 5 + 212.h,
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // 右侧遮罩
          Positioned(
            left: offset.dx + size.width,
            top: offset.dy,
            right: 0,
            height: inputHeight + 5 + 212.h,
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            width: size.width,
            left: offset.dx,
            top: offset.dy + inputHeight + 5,
            child: CompositedTransformFollower(
              offset: Offset(0.0, size.height + 5),
              link: _layerLink,
              showWhenUnlinked: false,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: ClipRect(
                      child: Align(
                        heightFactor: _heightAnimation.value,
                        alignment: Alignment.topCenter,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Material(
                  elevation: 0,
                  shadowColor:
                      AppColors.colors.bordersAndSeparators.defaultColor,
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.colors.background.elementBackground,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 212.h),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppColors.colors.background.elementBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors
                                .colors.bordersAndSeparators.defaultColor,
                            width: 1.w),
                      ),
                      child: AppRefreshWrapper(
                          controller: listController,
                          separator: const SizedBox.shrink(),
                          itemBuilder: (context, item, index) {
                            return TapEffect(
                              enableRipple: true,
                              borderRadius: BorderRadius.circular(8),
                              splashColor:
                                  AppColors.colors.background.layer2Background,
                              bgColor:
                                  AppColors.colors.background.elementBackground,
                              onTap: () => _onTap(item),
                              child: SizedBox(
                                width: size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 16.w),
                                  child: Row(
                                    spacing: 12.w,
                                    children: [
                                      AppSvg(path: 'assets/icons/Trending.svg'),
                                      AppText(
                                        item.toString(),
                                        style: AppTextStyle.poppinMedium400(
                                          color: AppColors
                                              .colors.typography.heading,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(String value) {
    setState(() {
      _filteredItems = widget.items
          .where((item) => (widget.itemToString?.call(item) ?? item.toString())
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
      listController.addData(_filteredItems,
          insertAtBeginning: true, append: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    if (_isDropdownOpen) _overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink,
        child: AppInput(
          controller: _controller,
          hintText: 'search...',
          prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 4.w, 12.h),
            child: AppSvg(
              path: 'assets/icons/Search.svg',
              color: AppColors.colors.icon.light,
              width: 24.w,
              height: 24.w,
            ),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: _onSubmitted,
          onChanged: _onChanged,
          onTap: () {
            if (!_isDropdownOpen) _openDropdown();
          },
        ));
  }
}
