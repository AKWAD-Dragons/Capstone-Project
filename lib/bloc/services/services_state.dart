import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Category.dart';
import 'package:sercl/bloc/profile/profile_state.dart';

abstract class ServicesState {}

class ServicesAre extends ProfileState {
  List<Category> categories;
  ServicesAre(this.categories);
}
