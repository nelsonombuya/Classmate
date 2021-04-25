import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/events/events_bloc.dart';
import '../../../bloc/notifications/notifications_bloc.dart';
import '../../../constants/device.dart';
import '../../../constants/validators.dart';
import '../../widgets/animated_text_button_widget.dart';
import '../../widgets/custom_form_view_widget.dart';
import '../../widgets/custom_textFormField_widget.dart';
import 'date_picker_button_widget.dart';

/// # Add Event Form
/// What gets shown when you want to add an event
/// Uses Modals for stuff
class AddEventForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ### Adding the relevant BLoCs
    return BlocProvider<EventsBloc>(
      create: (context) => EventsBloc(),
      child: AddEventFormView(),
    );
  }
}

class AddEventFormView extends StatefulWidget {
  @override
  _AddEventFormViewState createState() => _AddEventFormViewState();
}

class _AddEventFormViewState extends State<AddEventFormView> {
  // ### Values to be saved
  String _title;
  String _description;

  // TODO Calendar Functions to add later
  // DateTime _from, _to, _reminder;
  // int _numberOfRepetitions;
  // RepetitionRange _repetitionRange;
  // - Location
  // - Guests
  //     - UID
  //     - Names
  //     - Profile Pictures

  // ### Handling the Form Inputs
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _areThingsEnabled = true;
  bool _proceed;

  DateTime _selectedStartingDate = DateTime.now();
  DateTime _firstSelectableStartingDate = DateTime.now();
  DateTime _lastSelectableStartingDate = DateTime(DateTime.now().year + 100);

  DateTime _selectedEndingDate = DateTime.now().add(Duration(minutes: 30));
  DateTime _firstSelectableEndingDate = DateTime.now();
  DateTime _lastSelectableEndingDate = DateTime(DateTime.now().year + 100);

  @override
  Widget build(BuildContext context) {
    // ### BLoC Providers
    EventsBloc _events = BlocProvider.of<EventsBloc>(context);
    NotificationsBloc _notifications =
        BlocProvider.of<NotificationsBloc>(context);

    // ### For Measurements and Scaling
    Device().init(context);

    // ### Used during the Add Event Process
    Future<void> _addEvent() async {
      _events.add(EventAdditionStarted());

      // HACK Used to wait for the event addition to be completed
      // Before making the button report an error or success state
      while (_proceed == null) await Future.delayed(Duration(seconds: 3));

      if (!_proceed) throw Exception();
      setState(() => _proceed = null);
    }

    // ### Handling the event's of this form
    return BlocListener<EventsBloc, EventsState>(
      listener: (context, state) async {
        // ### Validating the form
        if (state is EventValidation) {
          if (_formKey.currentState.validate()) {
            // If the form is valid, disable the input fields
            setState(() => _areThingsEnabled = false);

            // Saving the form information for use during sign up
            _formKey.currentState.save();

            // Sending the Event to be registered
            _events.add(
              NewPersonalEventAdded(
                title: _title.trim(),
                description: _description.trim(),
                startDate: _selectedStartingDate,
                endDate: _selectedEndingDate,
              ),
            );
          }
        }

        // * In case of success
        if (state is EventAddedSuccessfully) {
          // Cleaning Up
          setState(() => _proceed = true);
        }

        // ! In case of errors
        if (state is ErrorAddingEvent) {
          // In case there's an error. show it and wait for the user
          // to try again
          setState(() => _proceed = false);
        }
      },
      child: FormView(
        title: "Add Event",
        actions: [AnimatedTextButton(label: "SAVE", onPressed: _addEvent)],
        child: Column(
          children: [
            SizedBox(height: Device.height(2.0)),

            // ## Form
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  // ### Options
                  // TODO Change Font Style
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.scale(
                        scale: 0.75,
                        alignment: Alignment.topRight,
                        child: CupertinoRadioChoice(
                          enabled: _areThingsEnabled,
                          initialKeyValue: 'Personal',
                          onChange: (_selectedEventType) {},
                          choices: {'Personal': 'Personal'},
                          selectedColor: CupertinoColors.activeBlue,
                          notSelectedColor: CupertinoColors.inactiveGray,
                        ),
                      ),
                    ],
                  ),

                  // ### Title Field
                  CustomTextFormField(
                    size: 3.0,
                    label: 'Title',
                    enabled: _areThingsEnabled,
                    keyboardType: TextInputType.text,
                    onSaved: (value) => _title = value,
                    validator: Validator.titleValidator,
                  ),

                  SizedBox(height: Device.height(2.0)),

                  // ### Description Field
                  CustomTextFormField(
                    maxLines: null,
                    label: 'Description',
                    enabled: _areThingsEnabled,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) => _description = value,
                  ),

                  SizedBox(height: Device.height(3.0)),

                  // ### All Day Switch
                  // TODO Add all day functionality
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: Device.width(2.0)),
                          Text(
                            "All Day",
                            style: TextStyle(fontSize: Device.height(2.1)),
                          ),
                          Switch.adaptive(
                            value: false,
                            onChanged: (value) => true,
                          )
                        ],
                      ),

                      // ### Date Picker Part 3
                      // Hours Wasted 6 😢
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// ### For the Starting Date
                          DatePickerButton(
                            title: "Starts",
                            initialSelectedDate: _selectedStartingDate,
                            firstSelectableDate: _firstSelectableStartingDate,
                            lastSelectableDate: _lastSelectableStartingDate,
                            onTap: (date) {
                              setState(
                                () {
                                  _selectedStartingDate = date;

                                  if (_selectedEndingDate.isBefore(date))
                                    _selectedEndingDate =
                                        date.add(Duration(minutes: 30));

                                  _firstSelectableEndingDate =
                                      date.add(Duration(minutes: 5));
                                },
                              );
                            },
                          ),

                          /// ### For the Ending Date
                          DatePickerButton(
                            title: "Ends",
                            initialSelectedDate: _selectedEndingDate,
                            firstSelectableDate: _firstSelectableEndingDate,
                            lastSelectableDate: _lastSelectableEndingDate,
                            onTap: (date) => setState(
                              () {
                                _selectedEndingDate = date;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: Device.height(3.0)),

                  /// ### Other Icons
                  Wrap(
                    spacing: Device.width(8),
                    runSpacing: Device.width(8),
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.spaceAround,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.repeat_rounded),
                            onPressed: () {}, // TODO Repeated Events
                          ),
                          Text("Repeat Event"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_location_rounded),
                            onPressed: () {}, // TODO Location Based Events
                          ),
                          Text("Add Location"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_alert_rounded),
                            onPressed: () {}, // TODO Alerts for Events
                          ),
                          Text("Add Reminder"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.people_alt_rounded),
                            onPressed: () {}, // TODO Shared Events
                          ),
                          Text("Add Guests"),
                        ],
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
