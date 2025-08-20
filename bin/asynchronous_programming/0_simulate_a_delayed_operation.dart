
Future<String> simulateNetworkCall() async{
  return Future.delayed(Duration(seconds:2), () => "Data received");
}

void main() async{
  print(await simulateNetworkCall());
}