//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:get_it/get_it.dart';
//import 'package:sercl/PODO/SP.dart';
//import 'package:sercl/bloc/profile/profile_bloc.dart';
//import 'package:sercl/bloc/profile/profile_event.dart';
//import 'package:sercl/bloc/profile/profile_state.dart';
//import 'package:sercl/resources/res.dart';
//import 'package:photo_view/photo_view.dart';
//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:url_launcher/url_launcher.dart';
//
//class SPProfile extends StatefulWidget {
//  @override
//  _SPProfileState createState() => _SPProfileState();
//}
//
//class _SPProfileState extends State<SPProfile> with TickerProviderStateMixin {
//  ProfileBloc _profileBloc = GetIt.instance<ProfileBloc>();
//  bool isExpanded = false;
//  List<String> images = List();
//  int choice = 0;
//  double rating;
//  StreamSubscription sub;
//  SP sp;
//  @override
//  void initState() {
//    sub = _profileBloc.subject.listen((state) {
//      if (state is CompanyInfoIs && state.sp != null) {
//        setState(() {
//          sp = state.sp;
//        });
//        for (int i = 0; i < sp.albums.length; i++) {
//          images.add(sp.albums[i].image_link);
//        }
//      }
//    });
//    _profileBloc.dispatch(HomePageLaunched());
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    sub.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: AppColors.accentColor,
//      appBar: AppBar(
//        elevation: 0,
//        centerTitle: true,
//        leading: BackButton(
//          color: AppColors.white,
//        ),
//        backgroundColor: AppColors.accentColor,
//      ),
//      body: SizedBox.expand(
//        child: Container(
//          padding: EdgeInsets.all(AppDimens.screenPadding),
//          height: double.infinity,
//          decoration: BoxDecoration(
//            color: AppColors.white,
//            borderRadius: new BorderRadius.only(
//              topLeft: Radius.circular(AppDimens.parentContainerRadius),
//              topRight: Radius.circular(AppDimens.parentContainerRadius),
//            ),
//          ),
//          child: SingleChildScrollView(
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                personalDataRow(),
//                SizedBox(
//                  height: 30,
//                ),
//                choices(),
//                SizedBox(
//                  height: 20,
//                ),
//                Visibility(
//                  visible: choice == 0,
//                  child: spInfo(),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget spInfo() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        SizedBox(
//          height: 20,
//        ),
//        bioRow(),
//        SingleChildScrollView(
//            scrollDirection: Axis.horizontal,
//            child: Row(children: pictureSlider(images))),
//        SizedBox(
//          height: 30,
//        ),
//        servicesRow(),
//        SizedBox(
//          height: 30,
//        ),
//        areasRow(),
//        SizedBox(
//          height: 30,
//        ),
//        Visibility(
//          visible: sp.insurance != null &&
//              sp.business_certificate != null &&
//              sp.contract != null,
//          child: legalDocsRow(),
//        ),
//      ],
//    );
//  }
//
//  Widget personalDataRow() {
//    return Row(
//      children: <Widget>[
//        Container(
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10),
//                color: AppColors.lightGray),
//            child: ClipRRect(
//              borderRadius:
//                  new BorderRadius.circular(AppDimens.statusCardRadius),
//              child: sp.logo_link != null
//                  ? Image.network(
//                      sp.logo_link,
//                      width: 80,
//                      height: 80,
//                      fit: BoxFit.cover,
//                    )
//                  : Container(
//                      width: 80,
//                      height: 80,
//                      padding: EdgeInsets.all(25),
//                      child: Image.asset(
//                        "assets/images/profile.png",
//                        color: Colors.black54,
//                      ),
//                    ),
//            )),
//        SizedBox(
//          width: 10,
//        ),
//        Expanded(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                sp.name,
//                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
//              ),
//              Text(
//                sp.authUser.email,
//                overflow: TextOverflow.ellipsis,
//                maxLines: 1,
//              ),
//              Visibility(
//                visible: sp.avg_price != null && sp.avg_rating != null,
//                child: Row(
//                  children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        RatingBarIndicator(
//                          itemCount: 5,
//                          itemSize: 20,
//                          rating: double.parse(sp?.avg_rating ?? "0"),
//                          itemBuilder: (BuildContext context, _) {
//                            return Icon(
//                              Icons.star,
//                              color: AppColors.starYellow,
//                            );
//                          },
//                        ),
//                        SizedBox(width: 10),
//                        Container(
//                          width: 1,
//                          height: 15,
//                          color: Colors.grey,
//                        ),
//                        SizedBox(width: 10),
//                        sp.avg_price != null
//                            ? buildPriceRating(sp.avg_price)
//                            : SizedBox(),
//                      ],
//                    )
//                  ],
//                ),
//              )
//            ],
//          ),
//        )
//      ],
//    );
//  }
//
//  Widget bioRow() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          AppStrings.companyBio,
//          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//        ),
//        SizedBox(
//          height: 5,
//        ),
//        bio(),
//      ],
//    );
//  }
//
//  Widget legalDocsRow() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          AppStrings.legalDocuments,
//          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//        ),
//        SizedBox(
//          height: 10,
//        ),
//        Wrap(
//          children: buildDocs(),
//          spacing: 16,
//        )
//      ],
//    );
//  }
//
//  List<Widget> buildDocs() {
//    List<Widget> docs = List();
//    if (sp.contract != null && sp.contract.isNotEmpty)
//      docs.add(singleDoc(AppStrings.contract, sp.contract));
//
//    if (sp.business_certificate != null && sp.business_certificate.isNotEmpty)
//      docs.add(
//          singleDoc(AppStrings.businessCertificate, sp.business_certificate));
//
//    if (sp.insurance != null && sp.insurance.isNotEmpty)
//      docs.add(singleDoc(AppStrings.insurance, sp.insurance));
//    return docs;
//  }
//
//  Widget singleDoc(String title, String link) {
//    return InkWell(
//      onTap: () {
//        _launchURL(link);
//      },
//      child: Column(
//        children: <Widget>[
//          Container(
//            width: 60,
//            height: 60,
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10),
//                border: Border.all(color: AppColors.hint.withAlpha(80))),
//            child: Icon(
//              Icons.insert_drive_file,
//              color: AppColors.accentColor,
//            ),
//          ),
//          SizedBox(
//            height: 5,
//          ),
//          Text(
//            title,
//            style: TextStyle(color: AppColors.accentColor),
//          )
//        ],
//      ),
//    );
//  }
//
//  _launchURL(String url) async {
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      print("FAILED TO LAUNCH: $url");
//    }
//  }
//
//  List<Widget> pictureSlider(List<String> photos) {
//    List<Widget> pictures = new List();
//    for (int i = 0; i < photos.length; i++) {
//      pictures.add(
//        InkWell(
//          onTap: () {
//            Navigator.push(context, MaterialPageRoute(builder: (_) {
//              return Slider(
//                images,
//                i,
//              );
//            }));
//          },
//          child: Card(
//            semanticContainer: true,
//            elevation: 0,
//            clipBehavior: Clip.antiAliasWithSaveLayer,
//            child: Image.network(
//              photos.elementAt(i),
//              fit: BoxFit.fitWidth,
//              height: 120,
//              width: 280,
//            ),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10.0),
//            ),
//          ),
//        ),
//      );
//    }
//    return pictures;
//  }
//
//  Widget bio() {
//    return new Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          new AnimatedSize(
//              vsync: this,
//              duration: const Duration(milliseconds: 200),
//              child: new ConstrainedBox(
//                  constraints: isExpanded
//                      ? new BoxConstraints()
//                      : new BoxConstraints(maxHeight: 60.0),
//                  child: new Text(
//                    sp.bio,
//                    softWrap: true,
//                    overflow: TextOverflow.fade,
//                  ))),
//          isExpanded
//              ? new ConstrainedBox(constraints: new BoxConstraints())
//              : new FlatButton(
//                  child: Text(
//                    AppStrings.showMore,
//                    style: TextStyle(color: AppColors.accentColor),
//                  ),
//                  onPressed: () => setState(() => isExpanded = true)),
//          !isExpanded
//              ? new ConstrainedBox(constraints: new BoxConstraints())
//              : new FlatButton(
//                  child: Text(
//                    AppStrings.showLess,
//                    style: TextStyle(color: AppColors.accentColor),
//                  ),
//                  onPressed: () => setState(() => isExpanded = false))
//        ]);
//  }
//
//  Widget servicesRow() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          AppStrings.services,
//          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//        ),
//        SizedBox(
//          height: 10,
//        ),
//        Wrap(children: buildServices())
//      ],
//    );
//  }
//
//  Widget areasRow() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          AppStrings.areas,
//          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//        ),
//        SizedBox(
//          height: 10,
//        ),
//        Wrap(children: buildAreas())
//      ],
//    );
//  }
//
//  List<Widget> buildServices() {
//    List<Widget> services = List();
//    for (int i = 0; i < sp.services.length; i++) {
//      services.add(Container(
//        margin: EdgeInsets.only(right: 5, bottom: 5),
//        decoration: BoxDecoration(
//            border: Border.all(color: AppColors.hint.withAlpha(80)),
//            borderRadius: BorderRadius.circular(5)),
//        padding: EdgeInsets.all(5),
//        child: Text(sp.services[i].name),
//      ));
//    }
//    return services;
//  }
//
//  List<Widget> buildAreas() {
//    List<Widget> areas = List();
//    for (int i = 0; i < sp.areas.length; i++) {
//      areas.add(Container(
//        margin: EdgeInsets.only(right: 5, bottom: 5),
//        decoration: BoxDecoration(
//            border: Border.all(color: AppColors.hint.withAlpha(80)),
//            borderRadius: BorderRadius.circular(5)),
//        padding: EdgeInsets.all(5),
//        child: Text(AppStrings.from +
//            ' : ' +
//            sp.areas[i].from +
//            ', ' +
//            AppStrings.to +
//            ' : ' +
//            sp.areas[i].to),
//      ));
//    }
//    return areas;
//  }
//
//  Widget choices() {
//    return Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        InkWell(
//          onTap: () {
//            setState(() {
//              choice = 0;
//            });
//          },
//          child: Container(
//            width: MediaQuery.of(context).size.width / 2 - 20,
//            height: 40,
//            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
//            decoration: BoxDecoration(
//              color: choice == 0 ? AppColors.accentColor : AppColors.grayDegree,
//              borderRadius: BorderRadius.all(
//                Radius.circular(5),
//              ),
//            ),
//            child: Text(
//              AppStrings.info,
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                fontSize: 16,
//                color: choice == 0 ? AppColors.white : AppColors.primaryColor,
//              ),
//            ),
//          ),
//        ),
//        InkWell(
//          onTap: () {
//            setState(() {
//              choice = 1;
//            });
//          },
//          child: Container(
//            width: MediaQuery.of(context).size.width / 2 - 20,
//            height: 40,
//            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
//            decoration: BoxDecoration(
//              color: choice == 1 ? AppColors.accentColor : AppColors.grayDegree,
//              borderRadius: BorderRadius.all(
//                Radius.circular(5),
//              ),
//            ),
//            child: Text(
//              AppStrings.reviews,
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                fontSize: 16,
//                color: choice == 1 ? AppColors.white : AppColors.primaryColor,
//              ),
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget buildPriceRating(String avgPrice) {
//    return RatingBarIndicator(
//      itemCount: 3,
//      itemSize: 20,
//      rating: double.parse(avgPrice).roundToDouble(),
//      itemBuilder: (BuildContext context, _) {
//        return Icon(
//          Icons.euro_symbol,
//          color: AppColors.primaryColor,
//        );
//      },
//    );
//  }
//
//  Widget reviewes() {
//    return ListView.builder(
//      itemCount: sp.ratings.length,
//      shrinkWrap: true,
//      itemBuilder: (BuildContext bC, int pos) {
//        return reviewItem(sp.ratings[pos]);
//      },
//    );
//  }
//
//  Widget reviewItem(Review review) {
//    return Padding(
//      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Flexible(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(review.order.customer_name),
//                    Text(
//                      "${review.order.service.name}",
//                      overflow: TextOverflow.ellipsis,
//                      style: TextStyle(color: AppColors.accentColor),
//                    )
//                  ],
//                ),
//              ),
//              Row(
//                children: <Widget>[
//                  Icon(Icons.euro_symbol,
//                      size: 15, color: AppColors.accentColor),
//                  Text(
//                    review.order.invitation.price,
//                    style: TextStyle(color: AppColors.accentColor),
//                  )
//                ],
//              )
//            ],
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Row(
//            children: <Widget>[
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(AppStrings.genRate),
//                  RatingBarIndicator(
//                    itemCount: 5,
//                    itemSize: 20,
//                    rating: double.parse(review.rating),
//                    itemBuilder: (BuildContext context, _) {
//                      return Icon(
//                        Icons.star,
//                        color: AppColors.starYellow,
//                      );
//                    },
//                  ),
//                ],
//              ),
//              SizedBox(
//                width: 30,
//              ),
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(AppStrings.priceRate),
//                  buildPriceRating(review.price_rating)
//                ],
//              )
//            ],
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Visibility(
//            visible: review.comment != null,
//            child: Text(
//              "\"${review.comment}\"",
//              style: TextStyle(fontStyle: FontStyle.italic),
//            ),
//          ),
//          Visibility(
//            visible: review.comment != null,
//            child: SizedBox(
//              height: 10,
//            ),
//          ),
//          Divider(),
//        ],
//      ),
//    );
//  }
//
//  Widget emptyView() {
//    return Center(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Image.asset(
//            "assets/images/no_chats.png",
//            width: 100,
//          ),
//          SizedBox(height: 20),
//          Text(
//            AppStrings.noReviewes,
//            style: TextStyle(
//                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Text(
//            AppStrings.noReviewesMsg,
//            textAlign: TextAlign.center,
//            style: TextStyle(color: AppColors.grayText),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class Slider extends StatelessWidget {
//  Slider(this.links, this.current);
//  final List<String> links;
//  final int current;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: AppColors.primaryColor,
//        body: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              margin: EdgeInsets.only(left: AppDimens.screenPadding, top: 40),
//              child: IconButton(
//                icon: Icon(
//                  Icons.arrow_back,
//                  color: AppColors.white,
//                ),
//                color: AppColors.white,
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//              ),
//            ),
//            Expanded(
//              child: CarouselSlider.builder(
//                aspectRatio: 1,
//                itemCount: links.length,
//                initialPage: current,
//                autoPlay: false,
//                enableInfiniteScroll: false,
//                enlargeCenterPage: false,
//                height: double.infinity,
//                viewportFraction: 1.0,
//                itemBuilder: (BuildContext context, int itemIndex) => Center(
//                  child: Container(
//                      child: PhotoView(
//                          imageProvider: NetworkImage(links[itemIndex]))),
//                ),
//              ),
//            )
//          ],
//        ));
//  }
//}
