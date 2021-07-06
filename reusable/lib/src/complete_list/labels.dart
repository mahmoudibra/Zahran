part of complete_list;

class Labels {
  final String loadingText;
  final String reload;
  final String loadFailedText;
  final String noMoreText;
  final String loadMoreText;
  final String emptyList;
  final bool shownoMoreText;

  const Labels._({
    this.loadMoreText = 'Load more',
    this.emptyList = 'No items',
    this.loadFailedText = 'Load failed',
    this.noMoreText = 'No more items',
    this.loadingText = 'Loading ...',
    this.reload = 'Reload',
    this.shownoMoreText = true,
  });
  factory Labels.of(BuildContext context) {
    var localizer = ReusableLocalizations.of(context);
    if (localizer != null) {
      return Labels._(
        loadMoreText: localizer.loadMore,
        emptyList: localizer.noItems,
        loadFailedText: localizer.loadFailed,
        noMoreText: localizer.noMoreItems,
        loadingText: localizer.loading,
        reload: localizer.reload,
      );
    }
    return Labels._();
  }

  Labels copyWith({
    String? loadingText,
    String? emptyList,
    String? loadFailedText,
    String? noMoreText,
    String? loadMoreText,
    String? reload,
    bool? shownoMoreText,
  }) {
    return Labels._(
      loadMoreText: loadMoreText ?? this.loadMoreText,
      emptyList: emptyList ?? this.emptyList,
      loadFailedText: loadFailedText ?? this.loadFailedText,
      noMoreText: noMoreText ?? this.noMoreText,
      loadingText: loadingText ?? this.loadingText,
      reload: reload ?? this.reload,
      shownoMoreText: shownoMoreText ?? this.shownoMoreText,
    );
  }
}
