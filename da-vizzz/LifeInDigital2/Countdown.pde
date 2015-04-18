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
    totalTime = totalTime;
    frameRate(1);
    this.timeDif = int(totalTime*0.001);
    daysLeft = floor(timeDif/60/60/24);
    hoursLeft = floor((timeDif - (daysLeft*60*60*24))/60/60);
    minutesLeft = floor((timeDif - (daysLeft*60*60*24) - (hoursLeft*60*60))/60);
    secondsLeft = floor((timeDif - (days*60*60*24) - (hoursLeft*60*60)) - (minutesLeft*60));
    //   println(daysLeft);
    //    println(hoursLeft);
    //    println(minutesLeft);
    //   println(secondsLeft);
  }

  int returnTime() {
    return timeDif;
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
    fill(255);
    background(243, 116, 88); 
    textSize(90);
    textAlign(LEFT);
    text(hoursLeft, 250, height/2);
    text(minutesLeft, 550, height/2);
    text(secondsLeft, 850, height/2);
  }
}

