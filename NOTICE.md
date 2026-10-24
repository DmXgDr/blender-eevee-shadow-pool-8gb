# 许可、来源与修改声明

这是 Blender 5.2.3 LTS 的非官方修改发行版，不代表 Blender Foundation。

## 许可

完整发行版遵循 GNU GPL v3.0-or-later（见 LICENSE 和 Blender 随附发行许可）。Blender 多数源文件标注 GPL-2.0-or-later；部分测试及依赖采用 Apache、BSD、MIT 等许可。各文件既有声明及第三方许可保持有效，不因顶层 LICENSE 被重写。新增便携启动脚本采用 GPL-3.0-or-later。

上游 COPYRIGHT/COPYING、doc/license 及运行包 app/license 中的文本保留。源码和二进制不附加禁止修改、禁止商业使用或禁止再分发的额外限制。

## 来源与对应源码

- 上游： https://www.blender.org/ / https://projects.blender.org/blender/blender
- 发布源码： https://download.blender.org/source/blender-5.2.3.tar.xz
- 上游提交： e13b728c6880d3084d9d57c30031ed5df8b39dee（v5.2.3）
- 修改后的完整源码：本仓库 blender/，以及每个 Release 的 blender-5.2.3-shadow8gb-source.tar.xz。
- 便携 ZIP 内的 Source/ 也包含完整修改源码、补丁和重建说明。
- 第三方依赖的固定版本、源地址及哈希在 blender/build_files/build_environment 中；重建所需说明见 docs/BUILD.md。

Cycles GPU 预编译内核来自同版本官方 Windows ZIP，其对应 Cycles 源码已包含在完整源码中。本次未修改 Cycles。NVIDIA OptiX 开发 SDK 不随包提供，重建者需按 NVIDIA 许可单独获取；没有将该 SDK 重新标注为 GPL。

## 修改记录

2026-10-23：扩展 EEVEE 阴影图集到 32,768 页 / 512 层；调整页地址、缓存字段及采样打包；增加 4 GB、8 GB 菜单和默认值；增加可选诊断与地址/GPU 测试。

2026-10-24：整理公开发布文档、补充各修改文件的日期说明及顶层 GPL 文本。此步骤仅改变源码注释、文档和打包内容，已验证的 blender.exe 二进制未改变。

上游作者版权与署名均予保留。测试结果仅代表文档中的平台和场景；软件按相应许可证的无担保条款提供。

参考： https://www.blender.org/about/license/
