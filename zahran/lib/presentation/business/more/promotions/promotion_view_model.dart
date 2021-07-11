import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/promotion.dart';
import 'package:zahran/presentation/helpers/enums/enumeration.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class PromotionViewModel extends ListController<Promotion> {
  PromotionStatus selectedFilter = PromotionStatus.ALL;

  @override
  Future<ApiListResponse<Promotion>> loadData(int skip) {
    return Repos.promotionRepo.pagination(skip: skip, filterType: selectedFilter);
  }

  void updateFilterType(PromotionStatus selectedFilter) {
    this.selectedFilter = selectedFilter;
    reloadApi();
    update();
  }

  void routeToPromotionDetails(int index) {
    var promotions = items;
    var selectedPromotion = promotions.toList()[index];
    print("Route with id ${selectedPromotion.id}");
    ScreenNames.PROMOTION_DETAILS.push();
  }
}

class PromotionStatus extends Enum<String> {
  const PromotionStatus(String val) : super(val);
  static const PromotionStatus ALL = const PromotionStatus('all');
  static const PromotionStatus EXPIRED = const PromotionStatus('Expired');
  static const PromotionStatus ACTIVE = const PromotionStatus('Active');
}
