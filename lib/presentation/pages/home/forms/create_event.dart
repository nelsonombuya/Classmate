import 'package:classmate/data/models/event_model.dart';
import 'package:classmate/presentation/pages/events/events_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/event/event_bloc.dart';
import '../../../../constants/device_query.dart';
import '../../../../constants/validator.dart';
import '../../../../cubit/create_event/create_event_cubit.dart';
import '../../../common_widgets/custom_textFormField.dart';
import '../../../common_widgets/date_picker_button.dart';
import '../../../common_widgets/form_view.dart';

class CreateEvent extends StatelessWidget {
  // * This page can also be used to edit events
  // * When the event is passed through the constructor
  final EventModel? event;

  const CreateEvent({this.event});

  @override
  Widget build(BuildContext context) {
    return DeviceQuery(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider<CreateEventCubit>(
            create: (context) => CreateEventCubit(),
          ),
          BlocProvider<EventBloc>(
            create: (context) => EventBloc(context),
          ),
        ],
        child: CreateEventView(event: event),
      ),
    );
  }
}

class CreateEventView extends StatefulWidget {
  final EventModel? event;

  const CreateEventView({this.event});

  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
      BlocProvider.of<CreateEventCubit>(context)
          .updateEventDetails(widget.event!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final EventBloc _eventsBloc = BlocProvider.of<EventBloc>(context);
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final CreateEventCubit _createEventCubit =
        BlocProvider.of<CreateEventCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateEventCubit, CreateEventState>(
          listener: (context, state) {
            if (state is EventValidation) {
              if (_formKey.currentState == null)
                throw Exception("Current Form State is Null ❗ ");

              if (_formKey.currentState!.validate()) {
                if (widget.event != null) {
                  _eventsBloc.add(
                    PersonalEventUpdated(
                      docId: widget.event!.docId!,
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      startDate: state.selectedStartingDate,
                      endDate: state.selectedEndingDate,
                      isAllDayEvent: state.isAllDayEvent,
                    ),
                  );
                } else {
                  _eventsBloc.add(
                    PersonalEventCreated(
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      startDate: state.selectedStartingDate,
                      endDate: state.selectedEndingDate,
                      isAllDayEvent: state.isAllDayEvent,
                    ),
                  );
                }
              }
            }
          },
        ),
        BlocListener<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventCreatedSuccessfully ||
                state is EventUpdatedSuccessfully) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
      child: FormView(
        title: "Create Event",
        actions: [
          TextButton(
            onPressed: () {
              _createEventCubit.validateEvent();
              FocusScope.of(context).unfocus();
            },
            child: Text(
              "SAVE",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: CupertinoColors.activeBlue),
            ),
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
                      BlocBuilder<CreateEventCubit, CreateEventState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              SizedBox(width: _deviceQuery.safeWidth(2.0)),
                              Text(
                                "All Day",
                                style: TextStyle(
                                  fontSize: _deviceQuery.safeHeight(2.1),
                                  fontWeight: state.isAllDayEvent
                                      ? FontWeight.bold
                                      : null,
                                ),
                              ),
                              Switch.adaptive(
                                value: state.isAllDayEvent,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (value) => _createEventCubit
                                    .changeAllDayEventState(value),
                              ),
                            ],
                          );
                        },
                      ),
                      BlocBuilder<CreateEventCubit, CreateEventState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DatePickerButton(
                                title: state.isAllDayEvent ? "On" : "From",
                                allDayEvent: state.isAllDayEvent,
                                selectedDate: state.selectedStartingDate,
                                onTap: (date) =>
                                    _createEventCubit.changeStartingDate(date),
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
                                      _createEventCubit.changeEndingDate(date),
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
