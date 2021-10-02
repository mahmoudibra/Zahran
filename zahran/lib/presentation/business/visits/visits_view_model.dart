import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:simple/simple.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/get_location_mixin.dart';

class VisitsViewModel extends ListController<BranchModel>
    with GetLocationMixin {
  final BuildContext context;

  VisitsViewModel(this.context);

  @override
  Future<ApiListResponse<BranchModel>> loadData(int skip) async {
    return Repos.visitsRepo.pagination(skip, await getCurrentPosition(true));
  }

  setTaskCompleted(int id) {
    var visit =
        items.firstOrDefault((element) => element.tasks.any((a) => a.id == id));
    if (visit != null) {
      replaceItems((a) => a.id == visit.id
          ? a.copyWith(
              completedTasks: a.completedTasks + 1,
              incompletedTasks: a.completedTasks - 1,
              tasks: a.tasks
                  .map((e) => e.id == id ? e.copyWith(isCompleted: true) : e)
                  .toList(),
            )
          : a);
    }
  }

  setProblemResolved(int id) {
    var ticket = items
        .firstOrDefault((element) => element.tickets.any((a) => a.id == id));
    if (ticket != null) {
      replaceItems((a) => a.id == ticket.id
          ? a.copyWith(
              tickets: a.tickets
                  .map((e) => e.id == id
                      ? e.copyWith(problem: e.problem?.copyWith(resolved: true))
                      : e)
                  .toList(),
            )
          : a);
    }
  }
}
