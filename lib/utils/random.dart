import 'dart:math';

Random random = Random();

List<int> getRandomDifferentThreeNumberInRange(int min, int max, int diffFrom) {
  final List<int> result = [];
  while (result.length < 3) {
    int randomNumber = random.nextInt(max - min) + min;
    while (randomNumber == diffFrom || result.contains(randomNumber)) {
      randomNumber = random.nextInt(max - min) + min;
    }
    result.add(randomNumber);
  }
  return result;
}
