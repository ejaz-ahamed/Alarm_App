import 'package:alrm_app/models/alarm_entity.dart';
import 'package:alrm_app/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  static ObjectBox? _instance;

  late final Store store;
  late final Box<AlarmEntity> alarmBox;

  ObjectBox._create(this.store) {
    alarmBox = store.box<AlarmEntity>();
  }

  static ObjectBox get instance {
    return _instance!;
  }

  static Future<void> create() async{
    if(_instance == null){
      final documentDirectory = await getApplicationDocumentsDirectory();
      final store = await openStore(
          directory: join(documentDirectory.path, 'Alarms'));
      _instance = ObjectBox._create(store);
    }
  }
}
