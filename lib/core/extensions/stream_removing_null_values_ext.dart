import 'package:rxdart/rxdart.dart';

//very important if a stream sometimes returns null value , this ext below remove those null values from the stream
extension Unwrap<T> on Stream<T?> {
  Stream<T> unwrap() => switchMap(
        (optional) async* {
          if (optional != null) {
            yield optional;
          }
        },
      );
}
