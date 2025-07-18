import 'package:bobofood/common/widget/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async'; // Added for Timer

/// 控制列表数据、刷新和加载
class ListController<T> {
  final List<T> items = [];
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  bool hasMore = true;
  int page = 1;
  int pageSize = 20;

  List<T>? defaultItems;

  /// 是否启用下拉刷新
  bool enablePullDown;

  bool enablePullUp;

  bool showPullUpText;

  // 是否已经完成首次加载
  bool hasLoaded = false;

  /// 页面更新回调（配合 GetX 的 update 使用）
  void Function()? onUpdate;

  /// 数据获取函数
  Future<List<T>> Function(int page, int pageSize)? onFetch;

  /// 是否在初始化时自动加载第一页
  final bool autoInit;

  /// 是否为聊天模式（影响数据加载顺序和滚动行为）
  final bool isChatMode;

  ListController({
    this.onUpdate,
    this.onFetch,
    this.autoInit = false,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.showPullUpText = true,
    this.isChatMode = false,
    this.defaultItems,
    this.pageSize = 20,
  }) {
    if (autoInit) {
      init();
    }
    if (onFetch == null) {
      enablePullUp = false;
    }
  }

  /// 主动触发初始化加载
  Future<void> init() async {
    if (defaultItems != null && defaultItems!.isNotEmpty) {
      items.addAll(defaultItems!);
    }
    await refresh();
  }

  Future<void> refresh() async {
    page = 1;
    hasMore = true;
    if (onFetch != null) {
      final data = await onFetch!(page, pageSize);
      addData(data, append: false);
      page++;
    } else {
      hasLoaded = true;
    }
    refreshCompleted();
  }

  Future<void> reload() async {
    reset();
    if (onFetch != null) {
      final data = await onFetch!(page, pageSize);
      addData(data, append: false);
      page++;
    } else {
      hasLoaded = true;
    }
    loadComplete();
  }

  Future<void> loadMore() async {
    if (onFetch != null) {
      final data = await onFetch!(page, pageSize);
      if (isChatMode) {
        // 聊天模式：历史消息插入到列表开头（最早的位置）
        addData(data, append: true, insertAtBeginning: true);
      } else {
        // 普通模式：新数据追加到列表末尾
        addData(data);
      }
      page++;
    }
    loadComplete();
  }

  void reset() {
    items.clear();
    page = 1;
    hasMore = true;
    notify();
  }

  void updateData(int index, T message) {
    items[index] = message;
    notify();
  }

  void removeData(T message) {
    items.remove(message);
    notify();
  }

  void addData(
    List<T> newItems, {
    bool append = true,
    bool insertAtBeginning = false,
  }) {
    if (!append) items.clear();

    if (insertAtBeginning) {
      // 在开头插入（用于聊天室加载历史消息）
      // items.insertAll(0, newItems);
      items.addAll(newItems);
    } else {
      // 在末尾追加
      items.addAll(newItems);
    }

    hasMore = newItems.length >= pageSize;
    hasLoaded = true;
    notify();
  }

  void insertData(int index, T message) {
    items.insert(index, message);
    notify();
  }

  /// 添加单个新消息（用于实时聊天）
  void addMessage(T message, {bool isScrollToBottom = true}) {
    items.add(message);
    notify();

    if (isScrollToBottom && isChatMode) {
      // 延迟滚动，确保界面已更新
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    }
  }

  void insertMessage(
    T message, {
    required int index,
    bool isScrollToBottom = true,
  }) {
    insertData(index, message);
    if (isScrollToBottom && isChatMode) {
      // 延迟滚动，确保界面已更新
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    }
  }

  /// 滚动到底部（最新消息）
  void scrollToBottom({Duration duration = const Duration(milliseconds: 300)}) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0, // reverse: true 时，0.0 是底部
        duration: duration,
        curve: Curves.easeOut,
      );
    }
  }

  /// 滚动到顶部（最早的消息）
  void scrollToTop({Duration duration = const Duration(milliseconds: 300)}) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: duration,
        curve: Curves.easeOut,
      );
    }
  }

  void refreshCompleted() {
    refreshController.refreshCompleted();
  }

  void loadComplete() {
    if (hasMore) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  void notify() {
    onUpdate?.call();
  }

  void dispose() {
    refreshController.dispose();
    scrollController.dispose();
  }
}

/// 包装支持上拉加载与下拉刷新的列表组件
class AppRefreshWrapper<T> extends StatelessWidget {
  final ListController<T> controller;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final Widget? separator;
  final EdgeInsets? padding;

  const AppRefreshWrapper({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.separator,
    this.padding,
  });

  Future<void> _onRefresh() async {
    controller.refresh();
  }

  Future<void> _onLoadMore() async {
    controller.loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final isFirstLoading = !controller.hasLoaded &&
        controller.items.isEmpty &&
        controller.autoInit;

    // 聊天模式使用不同的布局
    if (controller.isChatMode) {
      return _buildChatLayout(context, isFirstLoading);
    }

    return _buildNormalLayout(context, isFirstLoading);
  }

  Widget _buildNormalLayout(BuildContext context, bool isFirstLoading) {
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullDown: controller.enablePullDown && !isFirstLoading,
      enablePullUp: controller.enablePullUp && controller.items.isNotEmpty,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      // header: ClassicHeader(
      //   textStyle: TextStyle(fontSize: 14),
      //   refreshingText: "刷新中...",
      //   idleText: "下拉刷新",
      //   releaseText: "松开刷新",
      //   failedText: "刷新失败",
      //   completeText: "刷新完成",
      // ),
      footer: ClassicFooter(
        loadingText: controller.showPullUpText ? "加载中..." : '',
        noDataText: controller.showPullUpText ? "没有更多数据" : '',
        failedText: controller.showPullUpText ? "加载失败" : '',
        idleText: controller.showPullUpText ? "上拉加载更多" : '',
        canLoadingText: controller.showPullUpText ? "松开加载更多" : '',
        loadingIcon: controller.showPullUpText ? null : SizedBox.shrink(),
        canLoadingIcon: controller.showPullUpText ? null : SizedBox.shrink(),
      ),
      child: isFirstLoading
          ? (loadingWidget ?? const Center(child: Text("加载中...")))
          : controller.items.isEmpty
              ? (emptyWidget ?? const Center(child: Text("暂无数据")))
              : ListView.separated(
                  controller: controller.scrollController,
                  padding: padding ?? const EdgeInsets.all(0),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) =>
                      itemBuilder(context, controller.items[index], index),
                  separatorBuilder: (_, __) =>
                      separator ?? const AppDivider(height: 0),
                ),
    );
  }

  Widget _buildChatLayout(BuildContext context, bool isFirstLoading) {
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullDown: false, // 聊天模式：不使用下拉刷新
      enablePullUp:
          controller.items.isNotEmpty && controller.hasMore, // 聊天模式：上拉加载历史消息
      onLoading: _onLoadMore, // 上拉时加载更多历史消息
      footer: ClassicFooter(
        textStyle: TextStyle(fontSize: 14),
        loadingText: "加载更多消息...",
        idleText: "上拉查看更多消息",
        canLoadingText: "松开加载更多消息",
        failedText: "加载失败",
        noDataText: "没有更多更多消息",
        loadingIcon: SizedBox.shrink(),
        canLoadingIcon: SizedBox.shrink(),
        idleIcon: SizedBox.shrink(),
        failedIcon: SizedBox.shrink(),
        noMoreIcon: SizedBox.shrink(),
      ),
      child: isFirstLoading
          ? (loadingWidget ?? const Center(child: Text("加载中...")))
          : controller.items.isEmpty
              ? (emptyWidget ?? const Center(child: Text("开始聊天吧")))
              : CustomScrollView(
                  reverse: true,
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  controller: controller.scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return itemBuilder(
                          context,
                          controller.items[index],
                          index,
                        );
                      }, childCount: controller.items.length),
                    ),
                  ],
                ),
    );
  }
}

/// 网格布局的刷新列表组件
class AppGridRefreshWrapper<T> extends StatelessWidget {
  final ListController<T> controller;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final EdgeInsets? padding;
  final int crossAxisCount; // 每行显示的列数
  final double mainAxisSpacing; // 主轴间距
  final double crossAxisSpacing; // 交叉轴间距
  final double childAspectRatio; // 子项宽高比

  const AppGridRefreshWrapper({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.padding,
    this.crossAxisCount = 2, // 默认两列
    this.mainAxisSpacing = 10.0,
    this.crossAxisSpacing = 10.0,
    this.childAspectRatio = 1.0,
  });

  Future<void> _onRefresh() async {
    controller.refresh();
  }

  Future<void> _onLoadMore() async {
    controller.loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final isFirstLoading = !controller.hasLoaded &&
        controller.items.isEmpty &&
        controller.autoInit;

    return SmartRefresher(
      controller: controller.refreshController,
      enablePullDown: controller.enablePullDown && !isFirstLoading,
      enablePullUp: controller.enablePullUp && controller.items.isNotEmpty,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      header: ClassicHeader(
        textStyle: TextStyle(fontSize: 14),
        refreshingText: "刷新中...",
        idleText: "下拉刷新",
        releaseText: "松开刷新",
        failedText: "刷新失败",
        completeText: "刷新完成",
      ),
      footer: ClassicFooter(
        loadingText: controller.showPullUpText ? "加载中..." : '',
        noDataText: controller.showPullUpText ? "没有更多数据" : '',
        failedText: controller.showPullUpText ? "加载失败" : '',
        idleText: controller.showPullUpText ? "上拉加载更多" : '',
        canLoadingText: controller.showPullUpText ? "松开加载更多" : '',
        loadingIcon: controller.showPullUpText ? null : SizedBox.shrink(),
        canLoadingIcon: controller.showPullUpText ? null : SizedBox.shrink(),
      ),
      child: isFirstLoading
          ? (loadingWidget ?? const Center(child: Text("加载中...")))
          : controller.items.isEmpty
              ? (emptyWidget ?? const Center(child: Text("暂无数据")))
              : GridView.builder(
                  controller: controller.scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: mainAxisSpacing,
                    crossAxisSpacing: crossAxisSpacing,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) =>
                      itemBuilder(context, controller.items[index], index),
                ),
    );
  }
}

/// 网格布局的刷新列表组件
class AppCustomRefreshWrapper<T> extends StatelessWidget {
  final ListController<T> controller;
  final List<Widget> slivers;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final EdgeInsets? padding;
  final int crossAxisCount; // 每行显示的列数
  final double mainAxisSpacing; // 主轴间距
  final double crossAxisSpacing; // 交叉轴间距
  final double childAspectRatio; // 子项宽高比

  const AppCustomRefreshWrapper({
    super.key,
    required this.controller,
    required this.slivers,
    this.emptyWidget,
    this.loadingWidget,
    this.padding,
    this.crossAxisCount = 2, // 默认两列
    this.mainAxisSpacing = 10.0,
    this.crossAxisSpacing = 10.0,
    this.childAspectRatio = 1.0,
  });

  Future<void> _onRefresh() async {
    controller.refresh();
  }

  Future<void> _onLoadMore() async {
    controller.loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final isFirstLoading = !controller.hasLoaded &&
        controller.items.isEmpty &&
        controller.autoInit;

    return SmartRefresher(
      controller: controller.refreshController,
      enablePullDown: controller.enablePullDown && !isFirstLoading,
      enablePullUp: controller.enablePullUp,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      // header: ClassicHeader(
      //   textStyle: TextStyle(fontSize: 14),
      //   refreshingText: "",
      //   idleText: "",
      //   releaseText: "",
      //   failedText: "",
      //   completeText: "",
      // ),
      footer: ClassicFooter(
        loadingText: "加载中...",
        noDataText: "没有更多数据",
        failedText: "加载失败",
        idleText: "上拉加载更多",
        canLoadingText: "松开加载更多",
        loadingIcon: SizedBox.shrink(),
        canLoadingIcon: SizedBox.shrink(),
      ),
      child: isFirstLoading
          ? (loadingWidget ?? const Center(child: Text("加载中...")))
          : controller.items.isEmpty
              ? (emptyWidget ?? const Center(child: Text("暂无数据")))
              : CustomScrollView(
                  controller: controller.scrollController,
                  slivers: slivers,
                ),
    );
  }
}

/// 聊天室专用的 ListController
class ChatListController<T> extends ListController<T> {
  ChatListController({
    super.onUpdate,
    super.onFetch,
    super.autoInit = true,
    super.defaultItems,
    super.pageSize = 30,
  }) : super(isChatMode: true, enablePullDown: true, showPullUpText: false);

  /// 发送新消息
  Future<void> sendMessage(T message) async {
    addMessage(message, isScrollToBottom: true);
  }

  /// 接收新消息（来自其他用户或推送）
  void receiveMessage(T message) {
    addMessage(message, isScrollToBottom: false);
  }

  /// 批量接收消息（比如从WebSocket接收多条消息）
  void receiveMessages(List<T> messages) {
    items.addAll(messages);
    notify();
  }
}
