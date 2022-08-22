import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_alarm_require_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 自火報設置義務判定のProviderの定義
final fireAlarmRequireProvider =
    StateNotifierProvider<FireAlarmRequireNotifier, FireAlarmRequireClass>(
        (ref) {
  return FireAlarmRequireNotifier();
});

/// 配線リスト入力のNotifierの定義
class FireAlarmRequireNotifier extends StateNotifier<FireAlarmRequireClass> {
  // 空のデータとして初期化
  FireAlarmRequireNotifier()
      : super(FireAlarmRequireClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 0,
          sqFloor: 0,
          isNoWindow: false,
          isLodge: false,
          isCombust: false,
          isSprinkler: false,
          isOneStairs: false,
          floor: FireAlarmFloorEnum.floor1.title,
          usedType: FireAlarmUsedTypeEnum.none.title,
          result: RequireSentenceEnum.none.title,
          reason: '-',
        ));

  /// 防火対象物の更新
  void updateFirePreventProperty(FirePreventPropertyEnum newProperty) {
    state = state.copyWith(firePreventProperty: newProperty);
  }

  /// 延べ面積の更新
  void updateSq(String newVal) {
    try {
      state = state.copyWith(sq: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sq: 0);
    }
  }

  /// 床面積の更新
  void updateSqFloor(String newVal) {
    try {
      state = state.copyWith(sqFloor: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sqFloor: 0);
    }
  }

  /// 無窓階真偽値の更新
  void updateIsNoWindow(bool newBool) {
    state = state.copyWith(isNoWindow: newBool);
  }

  /// 指定可燃物真偽値の更新
  void updateIsCombust(bool newBool) {
    state = state.copyWith(isCombust: newBool);
  }

  /// 宿泊施設の真偽値の更新
  /// 6項イ、6項ハ、16項の2の判断に使用
  void updateIsLodge(bool newBool) {
    state = state.copyWith(isLodge: newBool);
  }

  /// スプリンクラー設置の真偽値の更新
  void updateIsSprinkler(bool newBool) {
    state = state.copyWith(isSprinkler: newBool);
  }

  /// 特定1階段等防火対象物の真偽値の更新
  void updateIsOneStairs(bool newBool) {
    state = state.copyWith(isOneStairs: newBool);
  }

  /// 階(地階、11F以上もここで選択)
  void updateFloor(String newVal) {
    state = state.copyWith(floor: newVal);
  }

  /// その階の用途(通信機器室、道路、駐車場)の更新
  void updateUsedType(String newVal) {
    state = state.copyWith(usedType: newVal);
  }

  /// 計算実行
  /// 消防法施行令第21条より
  void run() {
    /// 読み込み
    final firePreventProperty = state.firePreventProperty;

    /// 入力条件をもとに判断
    if (
        // スプリンクラー設備等があればその有効範囲内において、自火報の設置は免除
        // ただし、特定防火対象物、地階、無窓階、11階以上の階、煙感知器が必要な場合は除く
        // 施行令21条3項、施行規則23条の2項、5項、6項
        state.isSprinkler &&
            !state.firePreventProperty.isSpecific &&
            !state.isNoWindow &&
            state.floor != FireAlarmFloorEnum.basement.title &&
            state.floor != FireAlarmFloorEnum.floorOver11.title) {
      state = state.copyWith(result: RequireSentenceEnum.complex.title);
      state = state.copyWith(
          reason:
              'スプリンクラー設備等があればその有効範囲内において、自動火災報知設備を設置しないことができる(総務省令で定めるものを除く)');
    } else if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 2項ニ、5項イ、6項イ1-3、6項ロ、13項ロ、17項
        // 施行令21条1項1号イ
        firePreventProperty == FirePreventPropertyEnum.no2Ni ||
            firePreventProperty == FirePreventPropertyEnum.no5I ||
            firePreventProperty == FirePreventPropertyEnum.no6I123 ||
            firePreventProperty == FirePreventPropertyEnum.no6Ro ||
            firePreventProperty == FirePreventPropertyEnum.no13Ro ||
            firePreventProperty == FirePreventPropertyEnum.no17) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積に関係なく設置が義務');
    } else if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 6項ハで利用者を入居させ、又は宿泊させるもの
        // 施行令21条1項1項ロ
        firePreventProperty == FirePreventPropertyEnum.no6Ha && state.isLodge) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積に関係なく設置が義務');
    } else if (
        // 延べ面積200m2以上で設置義務がある防火対象物
        // 9項イ
        // 施行令21条1項2号
        firePreventProperty == FirePreventPropertyEnum.no9I &&
            state.sq >= 200) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積200m2以上で設置が義務');
    } else if (
        // 延べ面積300m2以上で設置義務がある防火対象物
        // 1項、2項イ-ハ、3項、4項、6項イ4、6項ニ、16項イ、16の2項
        // 施行令21条1項3号イ
        (firePreventProperty == FirePreventPropertyEnum.no1I ||
                firePreventProperty == FirePreventPropertyEnum.no1Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2I ||
                firePreventProperty == FirePreventPropertyEnum.no2Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2Ha ||
                firePreventProperty == FirePreventPropertyEnum.no3I ||
                firePreventProperty == FirePreventPropertyEnum.no3Ro ||
                firePreventProperty == FirePreventPropertyEnum.no4 ||
                firePreventProperty == FirePreventPropertyEnum.no6I4 ||
                firePreventProperty == FirePreventPropertyEnum.no6Ni ||
                firePreventProperty == FirePreventPropertyEnum.no16I ||
                firePreventProperty == FirePreventPropertyEnum.no16No2) &&
            state.sq >= 300) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積300m2以上で設置が義務');
    } else if (
        // 延べ面積300m2以上で設置義務がある防火対象物
        // 6項ハで利用者を入居させ、又は宿泊させるものを除く
        // 施行令21条1項3号ロ
        firePreventProperty == FirePreventPropertyEnum.no6Ha &&
            !state.isLodge) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積300m2以上で設置が義務');
    } else if (
        // 延べ面積500m2以上で設置義務がある防火対象物
        // 5項ロ、7項、8項、9項ロ、10項、12項、13項イ、14項
        // 施行令21条1項4号
        (firePreventProperty == FirePreventPropertyEnum.no5Ro ||
                firePreventProperty == FirePreventPropertyEnum.no7 ||
                firePreventProperty == FirePreventPropertyEnum.no8 ||
                firePreventProperty == FirePreventPropertyEnum.no9Ro ||
                firePreventProperty == FirePreventPropertyEnum.no10 ||
                firePreventProperty == FirePreventPropertyEnum.no12I ||
                firePreventProperty == FirePreventPropertyEnum.no12Ro ||
                firePreventProperty == FirePreventPropertyEnum.no13I ||
                firePreventProperty == FirePreventPropertyEnum.no14) &&
            state.sq >= 500) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積500m2以上で設置が義務');
    } else if (
        // 延べ面積500m2以上で、かつ特定用途の床面積が300m2以上で設置義務がある防火対象物
        // 16の3項
        // 施行令21条1項5号
        firePreventProperty == FirePreventPropertyEnum.no16No3 &&
            state.sq >= 500 &&
            state.sqFloor >= 300) {
      state = state.copyWith(result: RequireSentenceEnum.complex.title);
      state = state.copyWith(reason: '延べ面積500m2以上で、かつ特定用途の床面積が300m2以上で設置が義務');
    } else if (
        // 延べ面積1000m2以上で設置義務がある防火対象物
        // 11項、15項
        // 施行令21条1項6号
        (firePreventProperty == FirePreventPropertyEnum.no11 ||
                firePreventProperty == FirePreventPropertyEnum.no15) &&
            state.sq >= 1000) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積1000m2以上で設置が義務');
    } else if (
        // 特定防火対象物を選択し、特定1階段等防火対象物の場合、自火報設備が必要
        // 施行令21条1項7号
        firePreventProperty.isSpecific && state.isOneStairs) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '特定一階段等防火対象物は設置が義務');
    } else if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 指定可燃物500倍以上
        // 施行令21条1項8号
        state.isCombust) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '指定可燃物500倍以上で設置が義務');
    } else if (
        // 16の2項は通常300m2以上で設置義務があるが、以下の条件で面積制限がなくなる
        // 九　別表第一（十六の二）項に掲げる防火対象物（第三号及び前二号に掲げるものを除く。）の部分で、次に掲げる防火対象物の用途に供されるもの
        //  イ　別表第一（二）項ニ、（五）項イ並びに（六）項イ（１）から（３）まで及びロに掲げる防火対象物
        //  ロ　別表第一（六）項ハに掲げる防火対象物（利用者を入居させ、又は宿泊させるものに限る。）
        // 施行令21条1項9号
        firePreventProperty == FirePreventPropertyEnum.no16I ||
            firePreventProperty == FirePreventPropertyEnum.no16Ro) {
      state = state.copyWith(result: RequireSentenceEnum.complex.title);
      state = state.copyWith(reason: '延べ面積に関係なく設置が義務');
    } else if (
        // 2項イロハ、3項、16項イ(2項、3項に供する部分)で地階、無窓階の場合
        // 床面積100m2以上で自火報設備が必要
        // 施行令21条1項10号
        (firePreventProperty == FirePreventPropertyEnum.no2I ||
                firePreventProperty == FirePreventPropertyEnum.no2Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2Ha ||
                firePreventProperty == FirePreventPropertyEnum.no3I ||
                firePreventProperty == FirePreventPropertyEnum.no3Ro ||
                firePreventProperty == FirePreventPropertyEnum.no16I) &&
            (state.isNoWindow ||
                state.floor == FireAlarmFloorEnum.basement.title) &&
            state.sqFloor >= 100) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '2項イ-ハ、3項、16項で地階、無窓階の場合、床面積100m2以上で設置が義務');
    } else if (
        // 地階、無窓階、3F以上の階の場合、床面積300m2以上で自火報設備が必要
        // 施行令21条1項11号
        (state.floor == FireAlarmFloorEnum.basement.title ||
                state.floor == FireAlarmFloorEnum.floor3to10.title ||
                state.isNoWindow) &&
            state.sqFloor >= 300) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '地階、無窓階、3階以上の階には、床面積300m2以上で設置が義務');
    } else if (
        // 道路(屋上部分)は600m2以上で自火報設備が必要
        // 施行令21条1項12号
        state.usedType == FireAlarmUsedTypeEnum.roadRoofTop.title &&
            state.sqFloor >= 600) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '屋上部分が道路の場合、600m2以上で設置が義務');
    } else if (
        // 道路(その他)は400m2以上で自火報設備が必要
        // 施行令21条1項12号
        state.usedType == FireAlarmUsedTypeEnum.road.title &&
            state.sqFloor >= 400) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '道路(屋上以外)の場合、400m2以上で設置が義務');
    } else if (
        // 駐車場で地階、2F以上の階の場合、床面積200m2以上で自火報設備が必要
        // 施行令21条1項13号
        (state.floor == FireAlarmFloorEnum.basement.title ||
                state.floor == FireAlarmFloorEnum.floor2.title ||
                state.floor == FireAlarmFloorEnum.floor3to10.title ||
                state.floor == FireAlarmFloorEnum.floorOver11.title) &&
            state.usedType == FireAlarmUsedTypeEnum.parking.title &&
            state.sqFloor >= 200) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '駐車場が地階または2階以上の場合、200m2以上で設置が義務');
    } else if (
        // 11F以上は防火対象物の種類に関係なく自火報設備が必要
        // 施行令21条1項14号
        state.floor == FireAlarmFloorEnum.floorOver11.title) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '11階以上で設置が義務');
    } else if (
        // 通信機器室は床面積500m2以上で自火報設備が必要
        // 施行令21条1項15号
        state.usedType == FireAlarmUsedTypeEnum.commRoom.title &&
            state.sqFloor >= 500) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '通信機器室の床面積が500m2以上で、設置が義務');
    } else {
      state = state.copyWith(result: RequireSentenceEnum.no.title);
      state = state.copyWith(reason: 'ただし、市町村条例や危険物施設のため、設置義務になる場合があります');
    }
  }
}

/// 延べ面積入力初期化
final fireAlarmReqSqTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(fireAlarmRequireProvider).sq.toString();
  return TextEditingController(text: sq);
});

/// 床面積入力初期化
final fireAlarmReqSqFloorTxtCtrlProvider = StateProvider((ref) {
  String sqFloor = ref.watch(fireAlarmRequireProvider).sqFloor.toString();
  return TextEditingController(text: sqFloor);
});
