Stream<int> emitWithDelay(List<int> values) async*{
  for (int val in values) {
    await Future.delayed(Duration(milliseconds: 500));
    yield val;
  }
}

void main() async{
  List<int> values = [1,2,3,4,5,6,7,8,9,10];

  await for (int val in emitWithDelay(values)) {
    print("seconds: ${val/2}");
  };
}