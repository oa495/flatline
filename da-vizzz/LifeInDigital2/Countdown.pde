class Countdown {
  int totalTime;
  int days;
  int seconds;
  int hours;
  int minutes;
  int secondsLeft;
  int minutesLeft;
  int hoursLeft;
  int daysLeft;
  int timeDif;
  boolean done = false;

  Countdown(int totalTime) {
    frameRate(1);
    this.timeDif = int(totalTime*0.001);
    daysLeft = floor(timeDif/60/60/24);
    hoursLeft = floor((timeDif - (daysLeft*60*60*24))/60/60);
    minutesLeft = floor((timeDif - (daysLeft*60*60*24) - (hoursLeft*60*60))/60);
    secondsLeft = floor((timeDif - (days*60*60*24) - (hoursLeft*60*60)) - (minutesLeft*60));
    println(daysLeft);
    println(hoursLeft);
    println(minutesLeft);
    println(secondsLeft);
  }

  // Starting the timer
  boolean startCountdown() {
    if (secondsLeft == 0 && minutesLeft == 0 && hoursLeft == 0) {
      done = true;
    } else {
      secondsLeft--;
      if (secondsLeft < 0) {
        minutesLeft--;
        secondsLeft = 59;
      }
      if (minutesLeft < 0) {
        hoursLeft--;
        minutesLeft = 59;
      }
    }
    return done;
  }

  void display() {
    background(0);
    textSize(24);
    text(hoursLeft, width/2, 200);
    text(minutesLeft, width/2, 400);
    text(secondsLeft, width/2, 600);
  }
}

