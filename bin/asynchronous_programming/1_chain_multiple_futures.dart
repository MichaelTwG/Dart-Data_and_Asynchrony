Future<String> multiStepProcess() async{
  return Future.delayed(Duration(seconds:1), () => print("Step 1"))
  .then((_) {
    return Future.delayed(Duration(seconds:1), () => print("Step 2"));
  })
  .then((_) => "Done");
  //Alternativa mas optima

  //await Future.delayed(Duration(seconds:1), () => print("Step 1"));
  //await Future.delayed(Duration(seconds:1), () => print("Step 2"));
  //return "Done";
}


void main() async{
  print(await multiStepProcess());
}