import 'dart:math';

Future<String> safeNetworkCall() async{
  try {
    await Future.delayed(Duration(seconds:2));
      var randomNum = Random().nextInt(10);
      if (randomNum > 3 && randomNum < 6) {
        throw Exception("Network Error");
      }
      return "data";
  } catch (e) {
    //print(e);
    return "Fallback data";
  }
}

void main() async{
  for (int i = 0; i < 10; i++) {
    String data = await safeNetworkCall();
    print(data);
  }
}