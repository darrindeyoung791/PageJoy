import 'package:package_info_plus/package_info_plus.dart';

class AnimalVersion {
  /// 动物代号映射表
  /// 格式: 补丁版本 -> 动物名称
  static const Map<int, String> animalCodenames = {
    1: 'antelope',    // 羚羊 - 敏捷、快速
    2: 'bison',       // 美洲野牛 - 力量、耐力
    3: 'cougar',      // 美洲狮 - 勇猛、敏捷
    4: 'dolphin',     // 海豚 - 聪明、友善
    5: 'elephant',    // 大象 - 智慧、力量
    6: 'falcon',      // 猎鹰 - 敏锐、快速
    7: 'giraffe',     // 长颈鹿 - 高瞻远瞩
    8: 'hedgehog',    // 刺猬 - 机智、保护
    9: 'iguana',      // 鬣蜥 - 适应性强
    10: 'jaguar',     // 美洲豹 - 强大、优雅
    11: 'koala',      // 考拉 - 温和、专注
    12: 'lemur',      // 狐猴 - 灵活、社交
    13: 'manatee',    // 海牛 - 温和、坚韧
    14: 'nightingale', // 夜莺 - 美妙歌声
    15: 'otter',      // 水獭 - 机灵、友善
    16: 'panda',      // 熊猫 - 和平、可爱
    17: 'quail',      // 鹌鹑 - 谦逊、灵活
    18: 'raccoon',    // 浣熊 - 聪明、好奇
    19: 'spider',     // 蜘蛛 - 精密、创造
    20: 'toucan',     // 巨嘴鸟 - 鲜艳、活泼
    21: 'unicorn',    // 独角兽 - 稀有、神秘
    22: 'vulture',    // 秃鹫 - 敏锐、高效
    23: 'walrus',     // 海象 - 坚韧、强壮
    24: 'xerus',      // 非洲地松鼠 - 机敏、警觉
    25: 'yak',        // 牦牛 - 坚韧、耐力
    26: 'zebra',      // 斑马 - 独特、条纹美
  };

  /// 获取动物代号
  static String getAnimalCodename(int patchVersion) {
    return animalCodenames[patchVersion] ?? 'unknown-animal';
  }

  /// 从版本字符串解析补丁版本号
  static int parsePatchVersion(String version) {
    // 版本格式可能是: 0.0.1-antelope+1 或 0.0.1+1
    try {
      // 查找补丁版本数字（在第二个点和连字符/加号之间）
      final parts = version.split('.');
      if (parts.length >= 3) {
        final patchPart = parts[2];
        // 提取数字部分
        final numberMatch = RegExp(r'^(\d+)').firstMatch(patchPart);
        if (numberMatch != null) {
          return int.parse(numberMatch.group(1)!);
        }
      }
    } catch (e) {
      // 解析失败时返回默认值
      return 1;
    }
    return 1;
  }

  /// 获取完整的版本显示名称
  static Future<String> getDisplayVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final patchVersion = parsePatchVersion(packageInfo.version);
      final animalName = getAnimalCodename(patchVersion);
      
      // 返回格式: 0.0.1-antelope (build 1)
      return '${packageInfo.version} ($animalName)';
    } catch (e) {
      return 'Unknown Version';
    }
  }

  /// 获取版本代号信息
  static Future<String> getVersionCodename() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final patchVersion = parsePatchVersion(packageInfo.version);
      return getAnimalCodename(patchVersion);
    } catch (e) {
      return 'unknown';
    }
  }
}