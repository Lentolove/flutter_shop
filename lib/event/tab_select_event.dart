import 'package:event_bus/event_bus.dart';

///切换页面视图显示
EventBus tabSelectBus = EventBus();

class TabSelectEvent {
  int selectIndex;

  TabSelectEvent(this.selectIndex);
}
