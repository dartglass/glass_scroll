import 'dart:html';
import 'dart:async';

void main() {
  document.onKeyDown.listen((e){
    e.preventDefault();
    if(e.keyCode == 32){
      window.scrollBy(0, 555);
    }
  });

  // TODO: look into using pause instead.
  StreamSubscription<Event> scrollSubscription;
  bool movingScroll = false;
  int eventCount = 0;
  int height = 555;
  int slide = 1;
  _moveScroll(e) {
    print("_moveScroll:movingScroll = $movingScroll");
    eventCount++;
    if (eventCount > 25) {
      movingScroll = true;
      eventCount = 0;
    }

    if (movingScroll) {
      window.scrollTo(0, height*slide);
      slide++;
      movingScroll = false;
      eventCount = 0;
    }
  }

  _onDoneScroll() {
    print("_onDoneScroll");
    scrollSubscription.cancel();
    movingScroll = true;
    scrollSubscription = window.onScroll.listen(_moveScroll, onDone: _onDoneScroll);
  }

  _registerScroll() {
    print("_registerScroll");
    scrollSubscription = window.onScroll.listen(_moveScroll, onDone: _onDoneScroll);
  };

  //_registerScroll();

}
