//import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:sercl/PODO/Order.dart';
//import 'package:sercl/PODO/Rate.dart';
//import 'package:sercl/resources/dimens.dart';
//import 'package:sercl/resources/res.dart';
//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:sercl/PODO/Album.dart';
//import 'package:sercl/ui/Chat/ExpandedAppBarSection.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:video_player/video_player.dart';
//
//class OrderDetails extends StatefulWidget {
//  final Order order;
//
//  const OrderDetails({Key key, this.order}) : super(key: key);
//
//  @override
//  _OrderDetailsState createState() => _OrderDetailsState();
//}
//
//class _OrderDetailsState extends State<OrderDetails> {
//  VideoPlayerController controller;
//
//  @override
//  Widget build(BuildContext context) {
//    return SingleChildScrollView(
//      child: Padding(
//        padding: EdgeInsets.all(AppDimens.screenPadding),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            Visibility(
//              visible: widget.order.description != null,
//              child: Column(
//                children: <Widget>[
//                  Text(
//                    widget.order.description != null
//                        ? widget.order.description
//                        : "",
//                    style: TextStyle(
//                        fontSize: 15,
//                        color: AppColors.darkTextColor,
//                        height: 1.5),
//                  ),
//                  SizedBox(height: AppDimens.screenPadding)
//                ],
//              ),
//            ),
//            // Row(
//            //   children: <Widget>[
//            //     Visibility(
//            //       visible: widget.order.albums.length >= 1,
//            //       child: ClipRRect(
//            //         borderRadius:
//            //             new BorderRadius.circular(AppDimens.statusCardRadius),
//            //         child: GestureDetector(
//            //           child: Hero(
//            //             tag: 'imageOne',
//            //             child: widget.order.albums.length >= 1
//            //                 ? Image.network(
//            //                     widget.order.albums[0].image_link,
//            //                     width: 60,
//            //                     height: 60,
//            //                     fit: BoxFit.cover,
//            //                   )
//            //                 : Container(),
//            //           ),
//            //           onTap: () {
//            //             Navigator.push(context, MaterialPageRoute(builder: (_) {
//            //               return DetailScreen(
//            //                 widget.order.albums,
//            //                 0,
//            //               );
//            //             }));
//            //           },
//            //         ),
//            //       ),
//            //     ),
//            //     SizedBox(
//            //       width: 10,
//            //     ),
//            //     Visibility(
//            //       visible: widget.order.albums.length >= 2,
//            //       child: ClipRRect(
//            //         borderRadius:
//            //             new BorderRadius.circular(AppDimens.statusCardRadius),
//            //         child: GestureDetector(
//            //           child: Hero(
//            //             tag: 'imageTwo',
//            //             child: widget.order.albums.length >= 2
//            //                 ? Image.network(
//            //                     widget.order.albums[1].image_link,
//            //                     fit: BoxFit.cover,
//            //                     width: 60,
//            //                     height: 60,
//            //                   )
//            //                 : Container(),
//            //           ),
//            //           onTap: () {
//            //             Navigator.push(context, MaterialPageRoute(builder: (_) {
//            //               return DetailScreen(
//            //                 widget.order.albums,
//            //                 1,
//            //               );
//            //             }));
//            //           },
//            //         ),
//            //       ),
//            //     ),
//            //     SizedBox(
//            //       width: 16,
//            //     ),
//            //     Visibility(
//            //       visible: widget.order.albums.length >= 3,
//            //       child: ClipRRect(
//            //         borderRadius:
//            //             new BorderRadius.circular(AppDimens.statusCardRadius),
//            //         child: GestureDetector(
//            //           child: Hero(
//            //             tag: 'imageThree',
//            //             child: widget.order.albums.length >= 3
//            //                 ? Image.network(
//            //                     widget.order.albums[2].image_link,
//            //                     width: 60,
//            //                     height: 60,
//            //                   )
//            //                 : Container(),
//            //           ),
//            //           onTap: () {
//            //             Navigator.push(context, MaterialPageRoute(builder: (_) {
//            //               return DetailScreen(
//            //                 widget.order.albums,
//            //                 2,
//            //               );
//            //             }));
//            //           },
//            //         ),
//            //       ),
//            //     ),
//            //   ],
//            // ),
//            Visibility(
//              visible: widget.order.albums.isNotEmpty ||
//                  widget.order.videos.isNotEmpty,
//              child: attachments(),
//            ),
//            Visibility(
//              child: SizedBox(height: AppDimens.screenPadding),
//              visible: widget.order.albums.isNotEmpty,
//            ),
//            Divider(),
//            SizedBox(height: AppDimens.screenPadding),
//            Row(
//              children: <Widget>[
//                Image.asset(
//                  'assets/images/user.png',
//                  width: 15,
//                ),
//                SizedBox(width: 10),
//                Text(widget.order.customer_name)
//              ],
//            ),
//            SizedBox(height: 15),
//            Row(
//              children: <Widget>[
//                Image.asset(
//                  'assets/images/pin.png',
//                  width: 15,
//                ),
//                SizedBox(width: 10),
//                Expanded(
//                    child: Text(widget.order.street_name +
//                        ", " +
//                        widget.order.street_no +
//                        ", " +
//                        widget.order.postcode))
//              ],
//            ),
//            SizedBox(height: 15),
//            Row(
//              children: <Widget>[
//                Image.asset(
//                  'assets/images/phone.png',
//                  width: 17,
//                ),
//                SizedBox(width: 9),
//                InkWell(
//                  onTap: () {
//                    launch("tel://${widget.order.phone}");
//                  },
//                  child: Text(
//                    widget.order.phone == null ? "" : widget.order.phone,
//                    style: TextStyle(color: AppColors.accentColor),
//                  ),
//                )
//              ],
//            ),
//            SizedBox(height: 15),
//            Row(
//              children: <Widget>[
//                Image.asset(
//                  'assets/images/mail.png',
//                  width: 15,
//                ),
//                SizedBox(width: 10),
//                Text(widget.order.email == null ? "" : widget.order.email)
//              ],
//            ),
//            SizedBox(height: 15),
//          ],
//        ),
//      ),
//    );
//  }
//
//  List<Widget> imageChildren() {
//    List<Widget> children = List();
//    for (int i = 0; i < widget.order.albums.length; i++) {
//      children.add(InkWell(
//        onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (_) {
//            return DetailScreen(
//              widget.order.albums,
//              i,
//            );
//          }));
//        },
//        child: singleImage(widget.order.albums.elementAt(i).image_link),
//      ));
//    }
//    return children;
//  }
//
//  Widget singleImage(image) {
//    return Card(
//      clipBehavior: Clip.antiAlias,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(5.0),
//      ),
//      child: Image.network(
//        image,
//        fit: BoxFit.cover,
//        height: 60,
//        width: 60,
//      ),
//    );
//  }
//
//  Widget attachments() {
//    return Container(
//      width: double.infinity,
//      //padding: EdgeInsets.all(AppDimens.cardPadding),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Wrap(children: imageChildren()),
//          Wrap(children: videoChildren())
//        ],
//      ),
//    );
//  }
//
//  List<Widget> videoChildren() {
//    List<Widget> children = List();
//    for (int i = 0; i < widget.order.videos.length; i++) {
//      children.add(InkWell(
//        child: videoWidget(widget.order.videos.elementAt(i).video_link),
//      ));
//    }
//    return children;
//  }
//
//  Widget videoWidget(String video) {
//    return Card(
//      clipBehavior: Clip.antiAlias,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(5.0),
//      ),
//      child: InkWell(
//        onTap: () {
//          videoPlayerDialog(video);
//        },
//        child: Image.asset(
//          "assets/images/thumbnail.png",
//          fit: BoxFit.cover,
//          height: 60,
//          width: 60,
//        ),
//      ),
//    );
//  }
//
//  void videoPlayerDialog(String video) async {
//    controller = VideoPlayerController.network(video);
//    await controller.initialize();
//    controller.play();
//    controller.setLooping(true);
//    if (mounted) {
//      await showDialog(
//          barrierDismissible: true,
//          useRootNavigator: false,
//          context: context,
//          builder: (BuildContext bContext) {
//            return Scaffold(
//              backgroundColor: Colors.transparent,
//              body: Stack(
//                children: <Widget>[
//                  Positioned.fill(
//                    child: InkWell(
//                      radius: 0,
//                      onTap: () {
//                        Navigator.pop(context);
//                      },
//                    ),
//                  ),
//                  Center(
//                    child: controller.value.initialized
//                        ? AspectRatio(
//                            aspectRatio: controller.value.aspectRatio,
//                            child: VideoPlayer(controller),
//                          )
//                        : CircularProgressIndicator(),
//                  ),
//                  Positioned(
//                    child: BackButton(
//                      color: AppColors.white,
//                    ),
//                  ),
//                ],
//              ),
//            );
//          });
//    }
//    await controller.setLooping(false);
//    await controller.pause();
//  }
//
//
//}
//
//class DetailScreen extends StatelessWidget {
//  DetailScreen(this.links, this.current);
//  final List<Album> links;
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
//                      child: Image.network(
//                    links[itemIndex].image_link,
//                    fit: BoxFit.contain,
//                  )),
//                ),
//              ),
//            )
//          ],
//        ));
//  }
//}
