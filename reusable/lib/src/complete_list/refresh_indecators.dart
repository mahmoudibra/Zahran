part of complete_list;

class _RefreshIndicator extends StatelessWidget {
  final AnimationController lisnable;
  final double deltaExtent;
  final bool showLoader;
  const _RefreshIndicator({
    Key? key,
    required this.lisnable,
    required this.deltaExtent,
    required this.showLoader,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: lisnable,
      builder: (BuildContext context, Widget? child) {
        var realPercent = lisnable.value.clamp(0.0, 1.0);
        return SliverToBoxAdapter(
          child: Container(
            height: deltaExtent * lisnable.value,
            width: deltaExtent * lisnable.value,
            margin: EdgeInsets.only(bottom: 10 * realPercent),
            alignment: Alignment.center,
            child: realPercent > 0
                ? FittedBox(
                    child: RefreshProgressIndicator(
                      value: showLoader ? null : realPercent,
                    ),
                  )
                : SizedBox(),
          ),
        );
      },
    );
  }
}

class _FooterLoading extends StatelessWidget {
  final bool shrinkWrap;
  final ListPaging controller;

  final Labels labels;

  const _FooterLoading({
    Key? key,
    required this.shrinkWrap,
    required this.controller,
    required this.labels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.gotAllItems && !labels.shownoMoreText) {
      return SliverToBoxAdapter();
    }
    if (shrinkWrap) {
      return SliverToBoxAdapter(
        child: SafeArea(
          top: false,
          child: Center(
            child: _build(context),
          ),
        ),
      );
    } else {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: SafeArea(
          top: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _build(context),
          ),
        ),
      );
    }
  }

  Widget _build(BuildContext context) {
    if (controller.gotAllItems) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: TextStyles.caption(child: Text(labels.noMoreText)),
      );
    }
    if (controller.loadingMore) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: cupertino.CupertinoActivityIndicator(),
      );
    }

    return TextButton(
      onPressed: () {
        controller.loadNextApi();
      },
      child: Text(labels.loadMoreText),
    );
  }
}
