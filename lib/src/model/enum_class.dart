import 'package:firefight_equip/src/view/pages/alarm_equip_select_page.dart';
import 'package:firefight_equip/src/view/pages/fire_alarm_require_page.dart';
import 'package:firefight_equip/src/view/pages/fire_ext_capacity_page.dart';
import 'package:flutter/material.dart';
import 'package:firefight_equip/src/view/pages/about_page.dart';
import 'package:firefight_equip/src/view/pages/fire_ext_require_page.dart';
import 'package:firefight_equip/src/view/pages/home_page.dart';
import 'package:firefight_equip/src/view/pages/fire_ext_select_page.dart';
import 'package:firefight_equip/src/view/pages/setting_page.dart';

/// ページ名enum
enum PageNameEnum {
  toppage('トップページ', MyHomePage(), Icons.home_rounded),
  fireExt('消火器具計算', SelectFireExtPage(), Icons.fire_extinguisher),
  fireExtRequire('消火器具 設置基準計算', FireExtRequirePage(), null),
  fireExtCapacity('消火器具 能力単位計算', FireExtCapacityPage(), null),
  alarmEquip('警報設備計算', SelectFireAlarmPage(), Icons.alarm),
  fireAlarmRequire('自動火災警報設備 設置基準計算', FireAlarmRequirePage(), null),
  gasAlarmRequire('ガス漏れ警報設備 設置基準計算', FireAlarmRequirePage(), null),
  setting('設定', SettingPage(), Icons.settings),
  about('About', AboutPage(), Icons.info_outline);

  final String title;
  final dynamic page;
  final IconData? icon;

  const PageNameEnum(this.title, this.page, this.icon);
}

/// 防火対象物の一覧Enum
enum FirePreventPropertyEnum {
  no1I('(1)項イ  劇場、映画館、演芸場又は観覧場', true),
  no1Ro('(2)項ロ  公会堂又は集会場', true),
  no2I('(2)項イ  キャバレー、カフェー、ナイトクラブ、その他', true),
  no2Ro('(2)項ロ  遊技場又はダンスホール', true),
  no2Ha('(2)項ハ  性風俗関連特殊営業を営む店舗、その他', true),
  no2Ni('(2)項ニ  カラオケボックス、その他', true),
  no3I('(3)項イ  待合、料理店、その他', true),
  no3Ro('(3)項ロ  飲食店', true),
  no4('(4)項  百貨店、マーケット、その他', true),
  no5I('(5)項イ  旅館、ホテル、宿泊所、その他', true),
  no5Ro('(5)項ロ  寄宿舎、下宿又は共同住宅', false),
  no6I123('(6)項イ1〜3  入院施設がある病院、診療所、助産所', true),
  no6I4('(6)項イ4  入院施設がない診療所、助産所', true),
  no6Ro('(6)項ロ  特別養護老人ホーム、救護施設、乳児院、障害児入所施設、その他', true),
  no6Ha('(6)項ハ  老人デイサービスセンター、更生施設、保育所、その他', true),
  no6Ni('(6)項ニ  幼稚園又は特別支援学校', true),
  no7('(7)項  小学校、中学校、高等学校、高等専門学校、大学、各種学校、その他', false),
  no8('(8)項  図書館、博物館、美術館、その他', false),
  no9I('(9)項イ  公衆浴場のうち、蒸気浴場、熱気浴場、その他', true),
  no9Ro('(9)項ロ  (9)イに掲げる公衆浴場以外の公衆浴場', false),
  no10('(10)項  車両の停車場又は船舶若しくは航空機の発着場', false),
  no11('(11)項  神社、寺院、教会、その他', false),
  no12I('(12)項イ  工場又は作業場', false),
  no12Ro('(12)項ロ  映画スタジオ又はテレビスタジオ', false),
  no13I('(13)項イ  自動車車庫又は駐車場', false),
  no13Ro('(13)項ロ  飛行機又は回転翼航空機の格納庫', false),
  no14('(14)項  倉庫', false),
  no15('(15)項  前各項に該当しない事業場', false),
  no16I('(16)項イ  特定複合用途防火対象物', true),
  no16Ro('(16)項ロ  非特定複合用途防火対象物', false),
  no16No2('(16の2)項  地下街', true),
  no16No3('(16の3)項  準地下街', true),
  no17('(17)項  重要文化財、その他', false),
  no18('(18)項  延長50メートル以上のアーケード', false),
  no19('(19)項  市町村長の指定する山林', false),
  no20('(20)項  総務省令で定める舟車', false);

  final String title; // 文字表示
  final bool isSpecific; // 特定防火対象物か

  const FirePreventPropertyEnum(this.title, this.isSpecific);
}

/// 自火報の階
/// 自火報は階による制限がある
enum FireAlarmFloorEnum {
  basement('地階'),
  floor1('1F'),
  floor2('2F'),
  floor3to10('3F - 10F'),
  floorOver11('11F以上');

  final String title;

  const FireAlarmFloorEnum(this.title);
}

/// 自火報のその階の特殊用途
enum FireAlarmUsedTypeEnum {
  none('なし'),
  parking('駐車場'),
  commRoom('通信機器室'),
  roadRoofTop('道路(屋上部分)'),
  road('道路(その他の部分)');

  final String title;

  const FireAlarmUsedTypeEnum(this.title);
}

/// 設置義務があるかどうかの文章
enum RequireSentenceEnum {
  none(''),
  yes('設置義務があります'),
  no('設置義務はありません'),
  complex('設置義務は当該用途の基準による');

  final String title;

  const RequireSentenceEnum(this.title);
}
