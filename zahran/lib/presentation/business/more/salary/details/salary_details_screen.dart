import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'salary_details_view_model.dart';
import 'package:zahran/presentation/commom/prefered_size_title.dart';
import 'package:zahran/presentation/localization/tr.dart';

class SalaryDetailsScreen extends StatelessWidget {
  const SalaryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SalaryDetailsViewModel(context),
        builder: (SalaryDetailsViewModel vm) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  bottom:
                      PreferedSizeTitle(title: vm.model.title.format(context)),
                ),
                _infoRow1(vm),
                SliverSpacer(5),
                _infoRow2(vm),
                SliverSpacer(),
                SliverPaddingBox(
                  child:
                      Text(TR.of(context).earnings, style: context.headline6),
                ),
                SliverSpacer(10),
                for (var item in vm.model.earnings)
                  _buildTrackValue(
                    context: context,
                    name: item.title.format(context),
                    amount: item.amount,
                    rate: item.rate,
                  ),
                _buildTrackValue(
                  context: context,
                  name: TR.of(context).total,
                  amount: vm.model.earning,
                  backgroundColor: context.theme.primaryColor,
                  textColor: context.theme.colorScheme.onPrimary,
                ),
                SliverSpacer(),
                SliverPaddingBox(
                  child: Text(TR.of(context).desiccation,
                      style: context.headline6),
                ),
                SliverSpacer(10),
                for (var item in vm.model.desiccations)
                  _buildTrackValue(
                    context: context,
                    name: item.title.format(context),
                    amount: item.amount,
                    rate: item.rate,
                  ),
                _buildTrackValue(
                  context: context,
                  name: TR.of(context).total,
                  amount: vm.model.desiccation,
                  backgroundColor: context.theme.primaryColor,
                  textColor: context.theme.colorScheme.onPrimary,
                ),
                SliverSpacer(),
                _buildTrackValue(
                  context: context,
                  name: TR.of(context).net_salary,
                  amount: vm.model.netSalary,
                  backgroundColor: context.theme.colorScheme.secondary,
                  textColor: context.theme.colorScheme.onSecondary,
                )
              ],
            ),
          );
        });
  }

  Widget _buildTrackValue({
    required BuildContext context,
    required String name,
    required double amount,
    double? rate,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return SliverPaddingBox(
      child: Card(
        color: backgroundColor,
        child: ListTile(
          title: Text(
            name,
            style: context.bodyText2?.copyWith(color: textColor),
          ),
          trailing: DefaultTextStyle.merge(
            style: TextStyle(
                color: textColor ?? context.theme.colorScheme.secondary),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (rate != null) ...[
                  _buildAmount(
                      context, TR.of(context).rate, rate.noTrailing(), true),
                  SizedBox(width: 20),
                ],
                _buildAmount(context, TR.of(context).amount,
                    amount.currency(symbol: ""), rate != null),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildAmount(
      BuildContext context, String title, String value, bool showTitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle) ...[
          Text(title, style: context.caption),
          SizedBox(height: 5)
        ],
        Text(value),
      ],
    );
  }

  SliverPaddingBox _infoRow1(SalaryDetailsViewModel vm) {
    return SliverPaddingBox(
      child: Row(
        children: [
          _infoCard(vm.context, TR.of(vm.context).sab_number,
              vm.model.employeeInfo.sabNumber),
          SizedBox(width: 15),
          _infoCard(vm.context, TR.of(vm.context).department,
              vm.model.employeeInfo.department),
        ],
      ),
    );
  }

  SliverPaddingBox _infoRow2(SalaryDetailsViewModel vm) {
    return SliverPaddingBox(
      child: Row(
        children: [
          _infoCard(
              vm.context, TR.of(vm.context).bank, vm.model.employeeInfo.bank),
          SizedBox(width: 15),
          _infoCard(
              vm.context, TR.of(vm.context).payment_type, vm.model.paymentType),
        ],
      ),
    );
  }

  Widget _infoCard(BuildContext context, String label, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value),
              SizedBox(height: 7),
              Text(
                label,
                style: context.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
