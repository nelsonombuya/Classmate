import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/event/event_bloc.dart';
import '../../../../constants/device_query.dart';
import '../../../../constants/validator.dart';
import '../../../../cubit/add_event/add_event_cubit.dart';
import '../../../common_widgets/custom_textFormField.dart';
import '../../../common_widgets/date_picker_button.dart';
import '../../../common_widgets/form_view.dart';

class AddEventForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DeviceQuery(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider<AddEventCubit>(
            create: (context) => AddEventCubit(),
          ),
          BlocProvider<EventBloc>(
            create: (context) => EventBloc(context),
          ),
        ],
        child: AddEventFormView(),
      ),
    );
  }
}

class AddEventFormView extends StatefulWidget {
  @override
  _AddEventFormViewState createState() => _AddEventFormViewState();
}

class _AddEventFormViewState extends State<AddEventFormView> {
  // TODO Calendar Functions to add later
  // DateTime _from, _to, _reminder;
  // int _numberOfRepetitions;
  // RepetitionRange _repetitionRange;
  // - Location
  // - Guests
  //     - UID
  //     - Names
  //     - Profile Pictures

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final EventBloc _eventsBloc = BlocProvider.of<EventBloc>(context);
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final AddEventCubit _addEventCubit =
        BlocProvider.of<AddEventCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AddEventCubit, AddEventState>(
          listener: (context, state) {
            if (state is EventValidation) {
              if (_formKey.currentState == null)
                throw Exception("Current Form State is Null ❗ ");

              if (_formKey.currentState!.validate()) {
                _eventsBloc.add(
                  NewPersonalEventAdded(
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    startDate: state.selectedStartingDate,
                    endDate: state.selectedEndingDate,
                  ),
                );
              }
            }
          },
        ),
        BlocListener<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventAddedSuccessfully) Navigator.of(context).pop();
          },
        ),
      ],
      child: FormView(
        title: "Add Event",
        actions: [
          TextButton.icon(
            onPressed: () {
              _addEventCubit.validateNewEvent();
              FocusScope.of(context).unfocus();
            },
            icon: Icon(Icons.save_alt_rounded),
            label: Text("SAVE"),
          ),
        ],
        child: Column(
          children: [
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  CustomTextFormField(
                    size: 3.0,
                    label: 'Title',
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    validator: Validator.titleValidator,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(2.0)),
                  CustomTextFormField(
                    maxLines: null,
                    label: 'Description',
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    validator: Validator.descriptionValidator,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  Column(
                    children: [
                      BlocBuilder<AddEventCubit, AddEventState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              SizedBox(width: _deviceQuery.safeWidth(2.0)),
                              Text(
                                "All Day",
                                style: TextStyle(
                                  fontSize: _deviceQuery.safeHeight(2.1),
                                  color: state.isAllDayEvent
                                      ? CupertinoColors.black
                                      : null,
                                  fontWeight: state.isAllDayEvent
                                      ? FontWeight.bold
                                      : null,
                                ),
                              ),
                              Switch.adaptive(
                                value: state.isAllDayEvent,
                                onChanged: (value) => _addEventCubit
                                    .changeAllDayEventState(value),
                              ),
                            ],
                          );
                        },
                      ),
                      BlocBuilder<AddEventCubit, AddEventState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DatePickerButton(
                                title: state.isAllDayEvent ? "On" : "From",
                                allDayEvent: state.isAllDayEvent,
                                selectedDate: state.selectedStartingDate,
                                onTap: (date) =>
                                    _addEventCubit.changeStartingDate(date),
                              ),
                              if (!state.isAllDayEvent)
                                DatePickerButton(
                                  title: "To",
                                  allDayEvent: state.isAllDayEvent,
                                  selectedDate: state.selectedEndingDate,
                                  firstSelectableDate: state
                                      .selectedStartingDate
                                      .add(Duration(minutes: 5)),
                                  onTap: (date) =>
                                      _addEventCubit.changeEndingDate(date),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
