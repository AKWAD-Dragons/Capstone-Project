import 'package:sercl/PODO/LocalError.dart';
import 'package:rxdart/rxdart.dart';

class ErrorBloc {
  static Map<int, List<String>> errorConfig = {
    1:[],
    0: [],

    /// Invalid Email Error
    -1: [],

    /// Invalid verification Code Error
    -2: [],
    -3: [],

    /// No Internet Connection Error
    -4: [],
    /// Internal Server Error
    -5: [],
  };

  static Map<String, PublishSubject<LocalError>> ErrorStreamMap = Map();

  static void push(LocalError error) {
    List<String> pages = errorConfig[error.code];

    if (pages == null || pages.isEmpty) return;
    ErrorStreamMap.forEach((route, obs) {
      print("$route ${pages.contains(route).toString()}");
      if (pages.contains(route)) {
        obs.sink.add(error);
      }
    });
  }

  static Observable<LocalError> makeStream(String route) {
    PublishSubject<LocalError> ps = PublishSubject<LocalError>();
    ErrorStreamMap[route] = ps;
    return ps.stream;
  }

  dispose() {
    //_errorFetcher.close();
  }

  static void clear() {
    //_errorFetcher.add(null);
  }
}
