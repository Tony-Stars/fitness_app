import "package:fitness/bloc/activity_bloc.dart";
import "package:fitness/models/activity.dart";
import "package:flutter/material.dart";

class ActivityTile extends StatelessWidget {
  final Activity activity;
  final ActivityBloc activityCubit;

  const ActivityTile({
    super.key,
    required this.activity,
    required this.activityCubit,
  });

  void onChangedCompleted(bool? value, BuildContext context) {
    final dto = activity.copyWithCompleted(value!);
    activityCubit.add(UpdateActivityEvent(context: context, dto: dto));
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(activity.title),
      value: activity.completed,
      onChanged: (bool? value) => onChangedCompleted(value, context),
      secondary: Icon(activity.icon),
    );
  }
}
