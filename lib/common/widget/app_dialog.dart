import 'package:flutter/material.dart';
import 'package:bobofood/common/widget/app_text.dart';

typedef AppDialogCallback = Future<void> Function()?;

/// 按钮配置类
class AppDialogButton {
  final String text;
  final bool isPrimary;
  final bool isLoading;
  final VoidCallback? onPressed;

  AppDialogButton({
    required this.text,
    this.isPrimary = false,
    this.isLoading = false,
    this.onPressed,
  });
}

class AppDialog extends StatefulWidget {
  final String? title;
  final Widget? content;
  final List<AppDialogButton>? actions;
  final bool barrierDismissible;
  final double width;
  final double borderRadius;

  const AppDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.barrierDismissible = true,
    this.width = 300,
    this.borderRadius = 12,
  });

  /// 输入框弹窗示例构造
  static Future<String?> showInputDialog({
    required BuildContext context,
    String title = '请输入',
    String hintText = '',
    String confirmText = '确定',
    String cancelText = '取消',
    bool barrierDismissible = true,
  }) async {
    final TextEditingController controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder:
          (context) => AppDialog(
            title: title,
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: hintText),
              autofocus: true,
            ),
            actions: [
              AppDialogButton(
                text: cancelText,
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              AppDialogButton(
                text: confirmText,
                isPrimary: true,
                onPressed: () {
                  Navigator.of(context).pop(controller.text);
                },
              ),
            ],
          ),
    );

    return result;
  }

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnim = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnim = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBackgroundTap() {
    if (widget.barrierDismissible) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dialogChild = _buildDialogContent(context);

    return FadeTransition(
      opacity: _opacityAnim,
      child: GestureDetector(
        onTap: _onBackgroundTap,
        behavior: HitTestBehavior.opaque,
        child: Material(
          type: MaterialType.transparency,
          child: Center(child: dialogChild),
        ),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTap: () {}, // 阻止事件穿透
        child: Container(
          width: widget.width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null) AppText(widget.title!, fontSize: 16),
              if (widget.content != null) ...[
                const SizedBox(height: 12),
                widget.content!,
              ],
              if (widget.actions != null && widget.actions!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.actions!.map(_buildButton).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(AppDialogButton btn) {
    final isPrimary = btn.isPrimary;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ElevatedButton(
        style:
            isPrimary
                ? null
                : ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black87,
                ),
        onPressed:
            btn.isLoading
                ? null
                : () {
                  btn.onPressed?.call();
                },
        child:
            btn.isLoading
                ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : Text(btn.text),
      ),
    );
  }
}
