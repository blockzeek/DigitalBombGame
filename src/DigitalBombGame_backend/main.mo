import Random "mo:base/Random";

actor DigitalBombGame {
  private var bombNumber : Nat8 = 0;
  private var rangeStart : Nat8 = 0;
  private var rangeEnd : Nat8 = 255;

  func generateRandomNumber() : async Nat8 {
    let seed = await Random.blob();
    let random = Random.Finite(seed);
    let randomNumber = random.byte();
    switch (randomNumber) {
      case (?value) {
        return value;
      };
      case null {
        // Handle the case when the random number is null
        return await generateRandomNumber();
      };
    };
  };

  public func initializeGame() : async () {
    bombNumber := await generateRandomNumber();
  };

  public func guessNumber(guess : Nat8) : async Bool {
    if (guess == bombNumber) {
      // Game over, return true for bomb detonation
      return true;
    } else {
      if (guess < bombNumber) {
        rangeStart := guess + 1;
      } else {
        rangeEnd := guess - 1;
      };
      return false;
    };
  };

  // for debug and presentation
  public query func getbombNumber() : async Nat8 {
    bombNumber;
  };
};
