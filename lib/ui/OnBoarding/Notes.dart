import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/PODO/Note.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/support/router.gr.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  ProfileBloc bloc = GetIt.instance<ProfileBloc>();
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        icon: new Icon(
          Icons.arrow_back,
          color: AppColors.white,
        ),
        onPressed: () => MainRouter.navigator.pop(context),
      ),
      backgroundColor: AppColors.accentColor,
      title: Text(AppStrings.notes),
    ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(AppDimens.parentContainerRadius),
                topRight: Radius.circular(AppDimens.parentContainerRadius))),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemCount: bloc.sp.notes.length,
            itemBuilder: (BuildContext context, int i) {
              return noteItem(bloc.sp.notes.elementAt(i));
            }),
      ),
    );
  }

  Widget noteItem(Note note) {
    return Container(
      margin: EdgeInsets.only(left:AppDimens.screenPadding, right: AppDimens.screenPadding),
      child: Card(
        elevation: AppDimens.cardElevation,
        child: Container(
            padding: EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              progressContainer(note.section),
              SizedBox(height: 10,),
              Text(
                note.description,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  Widget progressContainer(String section) {
    return Container(
      padding: EdgeInsets.all(AppDimens.statusCardPadding),
      child: Text(
        section,
        style: TextStyle(
          color: AppColors.errorColor,
          fontSize: 12
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color:AppColors.errorColor ,),
        borderRadius: BorderRadius.circular(AppDimens.statusCardPadding),
      ),
    );
  }

}
