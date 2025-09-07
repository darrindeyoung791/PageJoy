import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation

class FontTestScreen extends StatelessWidget {
  const FontTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('字体测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(), // 添加平滑滚动物理效果
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '默认字体测试',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '中文测试 - 简体中文',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'English Test - English',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '混合文本测试 Mixed Text Test',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 24),
              // 测试不同字重 - 使用fontWeight
              const Text(
                'NotoSansSC 字重测试 (fontWeight)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '细体 Light (w300)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '常规 Regular (w400)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '中等 Medium (w500)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '粗体 Bold (w700)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // 测试不同字重 - 使用fontVariations
              const Text(
                'NotoSansSC 字重测试 (fontVariations)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '细体 Light (wght: 300)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontVariations: [FontVariation('wght', 300.0)],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '常规 Regular (wght: 400)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontVariations: [FontVariation('wght', 400.0)],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '中等 Medium (wght: 500)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontVariations: [FontVariation('wght', 500.0)],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '粗体 Bold (wght: 700)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontVariations: [FontVariation('wght', 700.0)],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '黑体 Black (wght: 900)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontVariations: [FontVariation('wght', 900.0)],
                ),
              ),
              const SizedBox(height: 24),
              // 测试更高字重 - 使用fontVariations
              const Text(
                '高字重测试 (fontVariations)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '更粗 Bold (wght: 800)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontVariations: [FontVariation('wght', 800.0)],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '超粗 Extra Bold (wght: 1000)',
                style: TextStyle(
                  fontFamily: 'NotoSansSC',
                  fontSize: 20,
                  fontVariations: [FontVariation('wght', 1000.0)],
                ),
              ),
              const SizedBox(height: 24),
              // 测试Lato字体
              const Text(
                'Lato 字重测试',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '细体 Light',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '常规 Regular',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '粗体 Bold',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '黑体 Black',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}