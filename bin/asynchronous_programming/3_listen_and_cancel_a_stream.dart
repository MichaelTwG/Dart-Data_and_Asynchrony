import 'dart:async';

import '2_stream_from_a_list.dart';


void listenAndCancel(Stream<int> stream) async{
  int count = 0;
  late StreamSubscription<int> subscription;

  subscription = stream.listen((value) {
    count++;
    print(value);
    if (count == 3) {
      subscription.cancel();
    }
  },
  onError: (error) => print("Finish with error: $error"),
  onDone:() => print("Stream done"),
  ); 
}

void main() async {
  listenAndCancel(emitWithDelay([1,2,3,4,5,6,7,8,9,10]));
}