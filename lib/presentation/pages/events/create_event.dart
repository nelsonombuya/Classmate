import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../data/models/event_model.dart';
import '../../../logic/bloc/events/events_bloc.dart';
import '../../../logic/cubit/create_event/create_event_cubit.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/date_picker_button.dart';
import '../../common_widgets/form_view.dart';

class CreateEvent extends StatelessWidget {
  // * This page can also be used to edit events
  // * When the event is passed through the constructor
  const CreateEvent({this.event, required this.eventsBloc});

  final EventModel? event;
  final EventsBloc eventsBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: eventsBloc),
        BlocProvider<CreateEventCubit>(
          create: (context) => CreateEventCubit(),
        ),
      ],
      child: _CreateEventView(event),
    );
  }
}

class _CreateEventView extends StatefulWidget {
  const _CreateEventView(this.event);

  final EventModel? event;

  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<_CreateEventView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
      context.read<CreateEventCubit>().updateEventDetails(widget.event!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return FormView(
      title: widget.event == null ? "Create Event" : "Edit Event",
      actions: [
        BlocBuilder<CreateEventCubit, CreateEventState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  if (widget.event != null) {
                    return context.read<EventsBloc>().add(
                          PersonalEventUpdated(
                            widget.event!.copyWith(
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              startDate: state.selectedStartingDate,
                              endDate: state.selectedEndingDate,
                              isAllDayEvent: state.isAllDayEvent,
                            ),
                          ),
                        );
                  } else {
                    return context.read<EventsBloc>().add(
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
              },
              child: Text(
                widget.event == null ? "SAVE" : "UPDATE",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: CupertinoColors.activeBlue),
              ),
            );
          },
        ),
      ],
      child: Column(
        children: [
          SizedBox(
            height: _deviceQuery.safeHeight(2.0),
          ),
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
                SizedBox(
                  height: _deviceQuery.safeHeight(2.0),
                ),
                CustomTextFormField(
                  maxLines: null,
                  label: 'Description',
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  validator: Validator.descriptionValidator,
                ),
                SizedBox(
                  height: _deviceQuery.safeHeight(3.0),
                ),
                BlocBuilder<CreateEventCubit, CreateEventState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: _deviceQuery.safeWidth(2.0),
                            ),
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
                              onChanged: (value) => context
                                  .read<CreateEventCubit>()
                                  .changeAllDayEventState(value),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DatePickerButton(
                              title: state.isAllDayEvent ? "On" : "From",
                              allDayEvent: state.isAllDayEvent,
                              selectedDate: state.selectedStartingDate,
                              onTap: (date) => context
                                  .read<CreateEventCubit>()
                                  .changeStartingDate(date),
                            ),
                            if (!state.isAllDayEvent)
                              DatePickerButton(
                                title: "To",
                                allDayEvent: state.isAllDayEvent,
                                selectedDate: state.selectedEndingDate,
                                firstSelectableDate: state.selectedStartingDate
                                    .add(Duration(minutes: 5)),
                                onTap: (date) => context
                                    .read<CreateEventCubit>()
                                    .changeEndingDate(date),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
