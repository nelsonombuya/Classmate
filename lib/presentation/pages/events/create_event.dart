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

/// # Create Event Form
/// The page can be used for both creating new events
/// and updating existing events
/// (By passing the event through the widget's constructor)
class CreateEvent extends StatelessWidget {
  const CreateEvent({Event? event, required EventsBloc eventsBloc})
      : _event = event,
        _eventsBloc = eventsBloc;

  final Event? _event;
  final EventsBloc _eventsBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _eventsBloc),
        BlocProvider<CreateEventCubit>(
          create: (context) => CreateEventCubit(),
        ),
      ],
      child: _CreateEventView(_event),
    );
  }
}

class _CreateEventView extends StatefulWidget {
  const _CreateEventView(this._event);

  final Event? _event;

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
    if (widget._event != null) {
      _titleController.text = widget._event!.title;
      _descriptionController.text = widget._event!.description ?? '';
      context.read<CreateEventCubit>().updateEventDetails(widget._event!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final EventsBloc _bloc = context.read<EventsBloc>();
    final CreateEventCubit _cubit = context.read<CreateEventCubit>();

    return FormView(
      title: widget._event == null ? "Create Event" : "Edit Event",
      actions: [
        BlocBuilder<CreateEventCubit, CreateEventState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  return widget._event == null
                      ? _bloc.add(
                          PersonalEventCreated(
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim(),
                            startDate: state.selectedStartingDate,
                            endDate: state.selectedEndingDate,
                            isAllDayEvent: state.isAllDayEvent,
                          ),
                        )
                      : _bloc.add(
                          PersonalEventUpdated(
                            widget._event!.copyWith(
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              startDate: state.selectedStartingDate,
                              endDate: state.selectedEndingDate,
                              isAllDayEvent: state.isAllDayEvent,
                            ),
                          ),
                        );
                }
              },
              child: Text(
                widget._event == null ? "SAVE" : "UPDATE",
                textScaleFactor: 1.2,
              ),
            );
          },
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
                // TODO Toggle Description Field
                CustomTextFormField(
                  maxLines: null,
                  label: 'Description',
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: _deviceQuery.safeHeight(3.0)),
                BlocBuilder<CreateEventCubit, CreateEventState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
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
                              onChanged: (value) =>
                                  _cubit.changeAllDayEventState(value),
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
                              onTap: (date) => _cubit.changeStartingDate(date),
                            ),
                            if (!state.isAllDayEvent)
                              DatePickerButton(
                                title: "To",
                                allDayEvent: state.isAllDayEvent,
                                selectedDate: state.selectedEndingDate,
                                onTap: (date) => _cubit.changeEndingDate(date),
                                firstSelectableDate: state.selectedStartingDate
                                    .add(Duration(minutes: 5)),
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
