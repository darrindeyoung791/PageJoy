import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 导入URL launcher
import '../utils/animal_version.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // 应用信息部分
                  _buildAppInfo(context),
                  const SizedBox(height: 24),
                  
                  // 版本信息部分
                  _buildSectionHeader(context, '版本'),
                  _buildVersionInfo(context),
                  const SizedBox(height: 24),
                  
                  // 图片致谢部分
                  _buildSectionHeader(context, '致谢'),
                  _buildCreditsInfo(context),
                  const SizedBox(height: 24),
                  
                  // GitHub项目链接按钮
                  _buildGitHubButton(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25, // 1/4 屏幕高度
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建分段标题
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  // 构建应用信息
  Widget _buildAppInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'PageJoy',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '沉浸式电子杂志应用，专注于为用户提供极致的阅读体验。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  // 构建版本信息
  Widget _buildVersionInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: FutureBuilder<String>(
        future: AnimalVersion.getDisplayVersion(),
        builder: (context, snapshot) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '当前版本',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              snapshot.hasData ? snapshot.data! : '加载中...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          );
        },
      ),
    );
  }

  // 构建致谢信息
  Widget _buildCreditsInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '感谢以下图片作者为本项目提供的精美动物图片：',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '• 羚羊 (Antelope) - Amy Chung (https://www.pexels.com/zh-cn/@amy-chung-209788/)\n'
            '• 美洲野牛 (Bison) - Chaitaastic (https://www.pexels.com/zh-cn/@chaitaastic/)\n'
            '• 美洲狮 (Cougar) - Lucas Pezeta (https://www.pexels.com/zh-cn/@lucaspezeta/)\n'
            '• 海豚 (Dolphin) - Hamid Elbaz (https://www.pexels.com/zh-cn/@hamid-elbaz-62178/)\n'
            '• 大象 (Elephant) - Hsapir (https://www.pexels.com/zh-cn/@hsapir/)\n'
            '• 猎鹰 (Falcon) - Co Sch (https://www.pexels.com/zh-cn/@co-sch-48159/)\n'
            '• 长颈鹿 (Giraffe) - Pixabay (https://www.pexels.com/zh-cn/@pixabay/)\n'
            '• 刺猬 (Hedgehog) - Pixabay (https://www.pexels.com/zh-cn/@pixabay/)\n'
            '• 鬣蜥 (Iguana) - Gina Jie Sam Foek (https://www.pexels.com/zh-cn/@gina-jie-sam-foek-126882/)\n'
            '• 美洲豹 (Jaguar) - Yigithan Ozturk (https://www.pexels.com/zh-cn/@yigithan02/)\n'
            '• 考拉 (Koala) - Pixabay (https://www.pexels.com/zh-cn/@pixabay/)\n'
            '• 狐猴 (Lemur) - Magda Ehlers (https://www.pexels.com/zh-cn/@magda-ehlers-pexels/)\n'
            '• 海牛 (Manatee) - Jakub Pabis (https://www.pexels.com/zh-cn/@jakub-pabis-147246622/)\n'
            '• 夜莺 (Nightingale) - Guvo59 (https://www.pexels.com/zh-cn/@guvo59/)\n'
            '• 水獭 (Otter) - Pixabay (https://www.pexels.com/zh-cn/@pixabay/)\n'
            '• 熊猫 (Panda) - Diana Silaraja (https://www.pexels.com/zh-cn/@diana-silaraja-794257/)\n'
            '• 鹌鹑 (Quail) - Brett Sayles (https://www.pexels.com/zh-cn/@brett-sayles/)\n'
            '• 浣熊 (Raccoon) - Pixabay (https://www.pexels.com/zh-cn/@pixabay/)\n'
            '• 蜘蛛 (Spider) - Pixabay (https://www.pexels.com/zh-cn/@pixabay/)\n'
            '• 巨嘴鸟 (Toucan) - Ekaterina (https://www.pexels.com/zh-cn/@ekamelev/)\n'
            '• 独角兽 (Unicorn) - Karolina Grabowska (https://www.pexels.com/zh-cn/@karolina-grabowska/)\n'
            '• 秃鹫 (Vulture) - Harry Letté (https://www.pexels.com/zh-cn/@harry-lette-1201293/)\n'
            '• 海象 (Walrus) - Francesco Ungaro (https://www.pexels.com/zh-cn/@francesco-ungaro/)\n'
            '• 非洲地松鼠 (Xerus) - Charles Durand (https://www.pexels.com/zh-cn/@charldurand/)\n'
            '• 牦牛 (Yak) - Liam Gant (https://www.pexels.com/zh-cn/@liam-gant-619294/)\n'
            '• 斑马 (Zebra) - Pixabay (https://www.pexels.com/zh-cn/@pixabay/)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // 构建GitHub链接按钮
  Widget _buildGitHubButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: SizedBox(
          width: 200, // 固定宽度以符合设计规范
          child: ElevatedButton(
            onPressed: () async {
              final Uri url = Uri.parse('https://github.com/darrindeyoung791/PageJoy');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                // 如果无法打开链接，可以显示错误信息或尝试其他方式
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('无法打开链接，请检查网络连接'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 0, // 移除阴影
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // MD3推荐的圆角
              ),
              padding: const EdgeInsets.symmetric(vertical: 16), // 增加按钮高度
            ),
            child: Text(
              '在 GitHub 上查看本项目',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSansSC', // 使用Noto Sans SC字体
              ),
            ),
          ),
        ),
      ),
    );
  }
}