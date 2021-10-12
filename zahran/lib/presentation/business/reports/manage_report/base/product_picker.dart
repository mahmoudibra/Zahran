import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'report_view_model.dart';

class ProductPicker extends StatelessWidget {
  final ValueChanged<Product> onPick;
  const ProductPicker({Key? key, required this.onPick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.onSecondary,
        onPrimary: Theme.of(context).colorScheme.secondary,
      ),
      icon: Icon(Icons.add),
      onPressed: () => show(context, onPick),
      label: Text(TR.of(context).add_product),
    );
  }

  static show(BuildContext context, ValueChanged<Product> onPick) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => _ProductPicker(onPick: onPick)),
    );
  }
}

class _ProductPicker extends StatelessWidget {
  final ValueChanged<Product> onPick;
  _ProductPicker({Key? key, required this.onPick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ReportViewModel>(
        builder: (ReportViewModel vm) {
          return ListTileTheme(
            horizontalTitleGap: 0,
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context, vm),
                for (var item in vm.brands)
                  SliverPaddingBox(
                    child: BrandView(
                      item: item,
                      onPick: onPick,
                      initiallyExpanded: vm.query?.isNotEmpty == true &&
                          item.products.any(
                              (element) => element.name.contains(vm.query)),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, ReportViewModel vm) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      floating: true,
      backgroundColor: Color(0xff040126),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 2),
        child: Builder(
          builder: (BuildContext context) {
            return Container(
              alignment: AlignmentDirectional.topStart,
              height: kToolbarHeight * 2,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    TR.of(context).brand_product,
                    style: context.headline2,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: vm.search,
                    autofillHints: vm.brands.map(
                      (e) => e.name.format(context),
                    ),
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: TR.of(context).search_brand,
                      suffixIcon: Icon(Icons.search),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      flexibleSpace: Builder(
        builder: (context) {
          var t = context.appBarExpansionPercent;
          return Transform.translate(
            offset: Offset(0, 2),
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top * (1 - t)),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15 * (1 - t)),
                  topRight: Radius.circular(15 * (1 - t)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BrandView extends StatelessWidget {
  const BrandView({
    Key? key,
    required this.item,
    required this.initiallyExpanded,
    required this.onPick,
  }) : super(key: key);
  final ValueChanged<Product> onPick;
  final BrandModel item;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key("$initiallyExpanded"),
      child: ExpansionTile(
        title: Text(
          item.name.format(context),
          style: context.bodyText1,
        ),
        initiallyExpanded: initiallyExpanded,
        leading: leadingImage(item.mediaPath, false),
        children: [
          for (var product in item.products) ...[
            ListTile(
              onTap: () => onPick(product.copy()),
              trailing: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.secondary,
              ),
              leading: leadingImage(product.media, true),
              title: Text(product.name.format(context)),
            ),
            if (product != item.products.last)
              Divider(
                indent: 20,
                endIndent: 20,
              ),
          ]
        ],
      ),
    );
  }

  ShapedRemoteImage leadingImage(String path, bool circle) {
    return ShapedRemoteImage(
      width: 30,
      height: 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(circle ? 50 : 5)),
      url: path,
    );
  }
}
