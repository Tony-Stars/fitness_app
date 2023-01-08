import "package:fitness/bloc/filter_bloc.dart";
import "package:fitness/utils/filter.dart";
import "package:fitness/models/enums.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SpecificationTile extends StatefulWidget {
  final Specification specification;

  const SpecificationTile({
    super.key,
    required this.specification,
  });

  @override
  State<SpecificationTile> createState() => _SpecificationTileState();
}

class _SpecificationTileState extends State<SpecificationTile> {
  bool? checked = false;

  @override
  void initState() {
    super.initState();
    checked = false;
  }

  void onChangedCompleted(bool? value, BuildContext context) {
    BlocProvider.of<FilterBloc>(context).add(
      UpdateSpecificationEvent(specification: widget.specification),
    );

    setState(() {
      checked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, Filter>(builder: (context, _) {
      return CheckboxListTile(
        title: Text(widget.specification.toString()),
        value: checked,
        onChanged: (bool? value) => onChangedCompleted(value, context),
      );
    });
  }
}
