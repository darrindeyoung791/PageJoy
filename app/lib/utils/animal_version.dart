import 'package:package_info_plus/package_info_plus.dart';

class AnimalVersion {
  /// 动物代号映射表
  /// 格式: 补丁版本 -> 动物名称
  static const Map<int, String> animalCodenames = {
    1: 'antelope',    // 羚羊 - 敏捷、快速
    2: 'badger',      // 獾 - 坚韧、勇敢
    3: 'cheetah',     // 猎豹 - 速度极快
    4: 'dolphin',     // 海豚 - 聪明、友善
    5: 'eagle',       // 鹰 - 锐利、高瞻远瞩
    6: 'fox',         // 狐狸 - 机智、灵活
    7: 'giraffe',     // 长颈鹿 - 高瞻远瞩
    8: 'hawk',        // 隼 - 敏锐、精准
    9: 'iguana',      // 鬣蜥 - 适应性强
    10: 'jaguar',     // 美洲虎 - 强大、优雅
    11: 'koala',      // 考拉 - 温和、专注
    12: 'lion',       // 狮子 - 勇敢、领导力
    13: 'monkey',     // 猴子 - 聪明、灵活
    14: 'nightingale', // 夜莺 - 美妙歌声
    15: 'owl',        // 猫头鹰 - 智慧、洞察力
    16: 'panther',    // 黑豹 - 神秘、强大
    17: 'quokka',     // 短尾矮袋鼠 - 友好、乐观
    18: 'rabbit',     // 兔子 - 敏捷、快速
    19: 'snake',      // 蛇 - 灵活、智慧
    20: 'tiger',      // 老虎 - 威武、力量
    21: 'unicorn',    // 独角兽 - 稀有、神秘
    22: 'vulture',    // 秃鹫 - 敏锐、高效
    23: 'wolf',       // 狼 - 忠诚、团队合作
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