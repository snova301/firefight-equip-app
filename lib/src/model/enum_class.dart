import 'package:flutter/material.dart';
import 'package:firefight_equip/src/view/pages/about_page.dart';
import 'package:firefight_equip/src/view/pages/fire_ext_require_page.dart';
import 'package:firefight_equip/src/view/pages/home_page.dart';
import 'package:firefight_equip/src/view/pages/fire_ext_select_page.dart';
import 'package:firefight_equip/src/view/pages/setting_page.dart';

/// ページ名enum
enum PageNameEnum {
  toppage('トップページ', MyHomePage(), Icons.home_rounded),
  fireExt('消火器計算', SelectFireExtPage(), Icons.fire_extinguisher),
  fireExtRequ('消火器 設置基準計算', FireExtRequirePage(), Icons.fire_extinguisher),
  fireExtCapa('消火器 能力単位計算', FireExtRequirePage(), Icons.fire_extinguisher),
  setting('設定', SettingPage(), Icons.settings),
  about('About', AboutPage(), Icons.info_outline);

  final String title;
  final dynamic page;
  final IconData? icon;

  const PageNameEnum(this.title, this.page, this.icon);
}

/// 防火対象物の一覧Enum
enum FirePreventPropertyEnum {
  no1I('(1)イ 劇場、映画館、演芸場又は観覧場', true),
  no1Ro('(2)ロ 公会堂又は集会場', true),
  no2I('(2)イ キャバレー、カフェー、ナイトクラブ、その他', true),
  no2Ro('(2)ロ 遊技場又はダンスホール', true),
  no2Ha('(2)ハ 性風俗関連特殊営業を営む店舗、その他', true),
  no2Ni('(2)ニ カラオケボックス、その他', true),
  no3I('(3)イ 待合、料理店、その他', true),
  no3Ro('(3)ロ 飲食店', true),
  no4('(4) 百貨店、マーケット、その他', true),
  no5I('(5)イ 旅館、ホテル、宿泊所、その他', true),
  no5Ro('(5)ロ 寄宿舎、下宿又は共同住宅', false),
  no6I('(6)イ 病院、診療所、助産所', true),
  no6Ro('(6)ロ 特別養護老人ホーム、救護施設、乳児院、障害児入所施設、その他', true),
  no6Ha('(6)ハ 老人デイサービスセンター、更生施設、保育所、その他', true),
  no6Ni('(6)ニ 幼稚園又は特別支援学校', true),
  no7('(7) 小学校、中学校、高等学校、高等専門学校、大学、各種学校、その他', false),
  no8('(8) 図書館、博物館、美術館、その他', false),
  no9I('(9)イ 公衆浴場のうち、蒸気浴場、熱気浴場、その他', true),
  no9Ro('(9)ロ (9)イに掲げる公衆浴場以外の公衆浴場', false),
  no10('(10) 車両の停車場又は船舶若しくは航空機の発着場', false),
  no11('(11) 神社、寺院、教会、その他', false),
  no12I('(12)イ 工場又は作業場', false),
  no12Ro('(12)ロ 映画スタジオ又はテレビスタジオ', false),
  no13I('(13)イ 自動車車庫又は駐車場', false),
  no13Ro('(13)ロ 飛行機又は回転翼航空機の格納庫', false),
  no14('(14) 倉庫', false),
  no15('(15) 前各項に該当しない事業場', false),
  no16I('(16)イ 特定複合用途防火対象物', true),
  no16Ro('(16)ロ 非特定複合用途防火対象物', false),
  no16No2('(16の2) 地下街', true),
  no16No3('(16の3) 準地下街', true),
  no17('(17) 重要文化財、その他', false),
  no18('(18) 延長50メートル以上のアーケード', false),
  no19('(19) 市町村長の指定する山林', false),
  no20('(20) 総務省令で定める舟車', false);

  final String title;
  final bool isSpecific;

  const FirePreventPropertyEnum(this.title, this.isSpecific);
}
