import "package:fitness/bloc/activity_bloc.dart";
import "package:fitness/services/dto.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class CreateActivityPage extends StatefulWidget {
  final ActivityBloc activityBloc;
  final String workoutId;

  const CreateActivityPage({
    super.key,
    required this.activityBloc,
    required this.workoutId,
  });

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final _nameTextController = TextEditingController();
  final _countTextController = TextEditingController();
  final _inputDecoration = const InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
  );

  void create(BuildContext context) async {
    final dto = CreateActivityDto(
      workoutId: widget.workoutId,
      name: _nameTextController.text,
      count: int.tryParse(_countTextController.text),
    );
    widget.activityBloc.add(CreateActivityEvent(context: context, dto: dto));
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextController.dispose();
    _countTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Создание упражнения")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30.0),
          child: Column(children: [
            TextField(
              controller: _nameTextController,
              decoration: _inputDecoration.copyWith(
                label: const Text("Наименование упражнения"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _countTextController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _inputDecoration.copyWith(
                label: const Text("Количество повторений упражнения"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => create(context),
              child: const Text("Создать"),
            ),
          ]),
        ),
      ),
    );
  }
}
