import "package:fitness/bloc/filter_bloc.dart";
import "package:fitness/utils/filter.dart";
import "package:fitness/models/enums.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ComplexityTile extends StatefulWidget {
  final Complexity complexity;

  const ComplexityTile({
    super.key,
    required this.complexity,
  });

  @override
  State<ComplexityTile> createState() => _ComplexityTileState();
}

class _ComplexityTileState extends State<ComplexityTile> {
  bool? checked = false;

  @override
  void initState() {
    super.initState();
    checked = false;
  }

  void onChangedCompleted(bool? value, BuildContext context) {
    BlocProvider.of<FilterBloc>(context).add(
      UpdateComplexityEvent(complexity: widget.complexity),
    );

    setState(() {
      checked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, Filter>(builder: (context, _) {
      return CheckboxListTile(
        title: Text(widget.complexity.toString()),
        value: checked,
        onChanged: (bool? value) => onChangedCompleted(value, context),
      );
    });
  }
}
