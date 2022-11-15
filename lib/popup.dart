import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:intl/intl.dart';
import 'package:krushak/globals.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather.dart';

/// {@template hero_dialog_route}
/// Custom [PageRoute] that creates an overlay dialog (popup effect).
///
/// Best used with a [Hero] animation.
/// {@endtemplate}
class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    @required WidgetBuilder? builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder!,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54.withOpacity(0.3);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}

/// {@template custom_rect_tween}
/// Linear RectTween with a [Curves.easeOut] curve.
///
/// Less dramatic that the regular [RectTween] used in [Hero] animations.
/// {@endtemplate}
class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    @required Rect? begin,
    @required Rect? end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin!.left, end!.left, elasticCurveValue)!,
      lerpDouble(begin!.top, end!.top, elasticCurveValue)!,
      lerpDouble(begin!.right, end!.right, elasticCurveValue)!,
      lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue)!,
    );
  }
}

class NearbyPopup extends StatefulWidget {
  final String? hero;
  final Map<String, dynamic>? nearby;
  final String? langCode;
  const NearbyPopup({Key? key, this.hero, this.nearby, this.langCode})
      : super(key: key);

  @override
  State<NearbyPopup> createState() => _NearbyPopupState();
}

class _NearbyPopupState extends State<NearbyPopup> {
  /*static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }*/

  void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: widget.hero!,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.network(
                                widget.nearby!['url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.44,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TranslatedText(
                                  widget.langCode!,
                                  widget.nearby!['title'],
                                  TextStyle(
                                      fontFamily: 'SemiBold',
                                      color: secondary,
                                      fontSize: 28),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TranslatedText(
                        widget.langCode!,
                        '${widget.nearby!['address']}',
                        TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 18,
                            color: secondary),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: getWidth(context),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TranslatedText(
                              widget.langCode!,
                              '${widget.nearby!['start']}-${widget.nearby!['end']}',
                              TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 24,
                                  color: secondary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: getWidth(context),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TranslatedText(
                              widget.langCode!,
                              '${widget.nearby!['time']}',
                              TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'SemiBold',
                                  color: secondary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          MapsLauncher.launchQuery(widget.nearby!['address']);
                          /*DirectionsService.init(
                              'AIzaSyAcnv76t3MrO7z4tm1TTgdIOMiAU5w5oxo');

                          final directionsService = DirectionsService();

                          final request = DirectionsRequest(
                            origin: 'New York',
                            destination:
                                'In front of riddhi siddhi ganesh mandir, Akkalkot',
                            travelMode: TravelMode.driving,
                          );

                          print('request--${request}');
                          // navigateTo(request.origin, request.destination);
                          launchMap(request.destination);

                          directionsService.route(request,
                              (DirectionsResult response,
                                  DirectionsStatus? status) {
                            if (status == DirectionsStatus.ok) {
                              // do something with successful response
                            } else {
                              // do something with error response
                            }
                          });*/
                        },
                        child: Container(
                          width: getWidth(context),
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.3))),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TranslatedText(
                                widget.langCode!,
                                'Directions',
                                TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 24,
                                    color: secondary),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
