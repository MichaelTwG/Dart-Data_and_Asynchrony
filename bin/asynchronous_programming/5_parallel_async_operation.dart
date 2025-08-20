
Future<String> simulateNetworkCall(int delay, String data) async{
  return Future.delayed(Duration(seconds: delay), () => data);
}

void main() async{

  List<String> list = await Future.wait([
    simulateNetworkCall(1, "First"),
    simulateNetworkCall(2, "Second"),
    simulateNetworkCall(3, "Third")]);
  print(list);
}
