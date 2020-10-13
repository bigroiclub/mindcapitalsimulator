import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindcapitalsimulator/src/bloc/event/login_event.dart';
import 'package:mindcapitalsimulator/src/bloc/login_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/login_state.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/widget/custom_button.dart';

class LoginMobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailTextController = TextEditingController();

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        if (state is SignInFail) {
          _emailTextController.clear();
        } else if (state is LoginStateError) {
          _emailTextController.clear();
          SchedulerBinding.instance.addPostFrameCallback((_) {
                Flushbar(
                  duration: Duration(seconds: 3),
                  icon: Icon(FontAwesomeIcons.user),
                  message: state.message,
                  backgroundGradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(242, 0, 83, 1),
                      Color.fromRGBO(242, 0, 83, 0.5)
                    ],
                  ),
                )..show(context);
              });
        }

        return Container(
          decoration: BoxDecoration(border: Border.all(width: 3)),
          margin: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Form(
                child: TextFormField(
                  controller: _emailTextController,
                  style:
                      TextStyle(fontSize: 20.0, backgroundColor: Colors.white),
                  decoration: InputDecoration(
                      labelText: '${AppLocalizations.of(context).email}',
                      hoverColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    BlocProvider.of<LoginBloc>(context)
                        .add(EmailChangedEvent(value));
                  },
                  onTap: () {},
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              SizedBox(height: 4.0,),
              CustomButton(
                child: Text(AppLocalizations.of(context).login,
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context)
                      .add(SignInEvent());
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                AppLocalizations.of(context).compliance,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        );
      },
    );
  }
}