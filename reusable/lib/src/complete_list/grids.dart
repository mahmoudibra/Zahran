part of complete_list;

class Grids {
  static SliverStaggeredGridDelegate fit(
    int length,
    int crossAxisCount,
    int fit,
  ) =>
      SliverStaggeredGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        staggeredTileCount: length,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(fit),
      );

  static SliverStaggeredGridDelegate columns_1(int length) => fit(length, 1, 1);
  static SliverStaggeredGridDelegate columns_2(int length) => fit(length, 2, 1);
  static SliverStaggeredGridDelegate columns_3(int length) => fit(length, 3, 1);
  static SliverStaggeredGridDelegate columns_4(int length) => fit(length, 4, 1);
  static SliverStaggeredGridDelegate columns_5(int length) => fit(length, 5, 1);
  static SliverStaggeredGridDelegate columns_6(int length) => fit(length, 6, 1);
}
