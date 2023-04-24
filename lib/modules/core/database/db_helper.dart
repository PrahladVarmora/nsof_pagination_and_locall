import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';
import 'package:nstack_softech_practical/modules/dashboard/model/model_dashboard_list_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper.internal();

  factory DataBaseHelper() => _instance;
  final String databaseName = 'nstack_softech.db';
  final int databaseVersion = 1;

  static Database? dbBase;

  Future<Database?> get db async {
    if (dbBase != null) {
      return dbBase;
    }
    dbBase = await initDb();
    return dbBase;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    var theDb = await openDatabase(path, version: databaseVersion,
        onOpen: (Database db) async {
      String rowSqlCreateTableDashboard = '''
          create table IF NOT EXISTS ${AppConfig.tableDashboardList} ( 
          ${AppConfig.dashboardListId} INTEGER primary key, 
          ${AppConfig.dashboardListName} text,
          ${AppConfig.dashboardListDescription} text,
          ${AppConfig.dashboardListAvatarUrl} text,
          ${AppConfig.dashboardListWatchersCount} INTEGER,
          ${AppConfig.dashboardListLanguage} text,
          ${AppConfig.dashboardListHasIssues} INTEGER,
          ${AppConfig.dashboardListOpenIssuesCount} INTEGER)
          ''';
      await db.execute(rowSqlCreateTableDashboard);
    });
    return theDb;
  }

  DataBaseHelper.internal();

  ///-----Start----DashboardList------------
  Future<int> insertDashboardListData(
      List<ModelDashboardListItem> mModelDashboardListItem) async {
    var dbClient = await db;
    int result = 0;
    for (ModelDashboardListItem value in mModelDashboardListItem) {
      result =
          await dbClient!.insert(AppConfig.tableDashboardList, value.toJson());
    }

    int id = -1;
    if (result != 0) {
      id = 1;
    }
    return id;
  }

  Future<List<ModelDashboardListItem>> getDashboardListData(
      {required int mPage, required int mSize}) async {
    var dbClient = await db;
    var value = await dbClient!
        .rawQuery('''SELECT * FROM ${AppConfig.tableDashboardList}''');
    printWrapped('value---------$value');
    try {
      List<ModelDashboardListItem> mModelDashboardListItem =
          List<ModelDashboardListItem>.from(
              value.map((model) => ModelDashboardListItem.fromJson(model)));
      printWrapped(
          'mModelDashboardListItem-----${mModelDashboardListItem.length}');
      return mModelDashboardListItem;
    } catch (e) {
      printWrapped('mModelDashboardListItem-----$e');
      return [];
    }
  }

  Future deleteAllData() async {
    var dbClient = await db;
    var value =
        await dbClient!.rawQuery("DELETE FROM ${AppConfig.tableDashboardList}");

    return value;
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
