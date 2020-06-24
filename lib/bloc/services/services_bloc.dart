import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sercl/PODO/Categories.dart';
import 'package:sercl/bloc/bloc.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/bloc/services/services_event.dart';
import 'package:sercl/bloc/services/services_state.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Category.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/GraphClient/GraphQLBuilder.dart';

class ServicesBloc extends BLoC<ServicesEvent> {
  BehaviorSubject<ProfileState> subject = BehaviorSubject();
  Fly fly = GetIt.instance<Fly>();
  Categories cats;

  ServicesBloc() {
    getServices();
  }

  @override
  void dispatch(ServicesEvent event) async {
    if (event is ServicesScreenLaunched) {
      this.pushServices();
    }
  }

  Future<void> pushServices() async {
    if (this.cats == null) {
      await getServices();
    }
    this.subject.add(ServicesAre(cats.categories));
  }

  Future<void> getServices() async {
    Node catQuery = Node(name: "Categories", cols: [
      'name',
      'icon',
      'color',
      Node(name: 'services', cols: [
        'id',
        'name',
        Node(name: "category", cols: [
          "id",
        ]),
      ])
    ]);

    dynamic results = await fly
        .query([catQuery], parsers: {'Categories': Categories.empty()});

    cats = results['Categories'];
  }

  void fetchCategoriesWithServices() {
    // List<Service> cleaningServices = [
    //   Service(title: "Home"),
    //   Service(title: "Patio"),
    //   Service(title: "Deep Cleaning"),
    //   Service(title: "Furniture"),
    //   Service(title: "Construction Cleanup"),
    // ];

    // List<Service> repairingServices = [
    //   Service(title: "Home"),
    //   Service(title: "Patio"),
    //   Service(title: "Deep Cleaning"),
    //   Service(title: "Furniture"),
    //   Service(title: "Construction Cleanup"),
    // ];

    // List<Service> gardenServices = [
    //   Service(title: "Home"),
    //   Service(title: "Patio"),
    //   Service(title: "Deep Cleaning"),
    //   Service(title: "Furniture"),
    //   Service(title: "Construction Cleanup"),
    // ];

    // List<Service> movingServices = [
    //   Service(title: "Home"),
    //   Service(title: "Patio"),
    //   Service(title: "Deep Cleaning"),
    //   Service(title: "Furniture"),
    //   Service(title: "Construction Cleanup"),
    // ];

    // List<Category> categories = [
    //   Category("Cleaning", cleaningServices, "assets/images/cleaning.png",
    //       AppColors.cleaningPurple),
    //   Category("Repairing", repairingServices, "assets/images/repairing.png",
    //       AppColors.repairingYellow),
    //   Category("Garden & Outdoor", gardenServices, "assets/images/outdoor.png",
    //       AppColors.greenOutdoor),
    //   Category("Moving & Recycling", movingServices, "assets/images/moving.png",
    //       AppColors.redMoving),
    // ];

    // this.subject.add(ServicesAre(categories));
  }
}
