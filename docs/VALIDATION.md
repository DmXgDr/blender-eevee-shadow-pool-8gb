# 验证记录

版本：Blender 5.2.3 LTS，Shadow8GB v1.0.0，非官方修改版。
测试平台：Windows x64 / NVIDIA GeForce RTX 4090 24 GB / 驱动 617.14。
程序 SHA-256：`88698edaa61c638688710ff38aa6a6e0559f702f67d5ddc96db87dda3f8bb031`。

## 通过的检查

- OpenGL 11 项、Vulkan 11 项阴影单元测试，合计 22 项全部通过。覆盖 32768 个页地址和缓存索引、LOD 0–7、完整偏移范围、分配、释放、缓存与碎片整理。
- 实际 8 GiB 图集分配：2048×2048×512，8,589,934,592 字节，32768 页，分配成功。
- 普通场景包含太阳光、区域光、点光源、聚光灯及运动遮挡物。在 1、12、24、返回 1 帧进行渲染；OpenGL 下修改版的 2 GB、8 GB 与官方 2 GB PNG 图像逐像素一致。
- Vulkan 8 GB 完成相同四次渲染。与官方 OpenGL 结果有轻微后端差异：最大归一化通道差为 2/255，平均差低于 0.000001；同后端返回第 1 帧完全一致。逐项数据见 render-comparison.json（历史字段名 linear_difference 实际比较已保存 PNG 的归一化通道值）。
- 96 盏太阳灯压力场景：原版 2 GB 报 Shadow buffer full；修改版 8 GB 最大实际占用 14554 页，超过旧版 8192 页容量，无该报错，渲染完成。
- 独立 GUI 的 Rendered 视口在 1、12、24、返回 1 帧截图，已检查图像；原生菜单显示并提供 4 GB、8 GB 档位。
- 对应源码归档中的 6 个修改文件与本地已编译源码哈希一致。程序目录不存在 Git LFS 占位文件。

## 复测

解压后双击 Start-Blender.cmd。打开 Examples/Shadow-Validation.blend，按 F12 渲染。
压力场景为 Examples/Shadow-Pressure-96-Suns.blend；需要足够空闲显存。
命令行便携与渲染检查可运行：

```powershell
.\Start-Blender.ps1 -b --gpu-backend opengl --python-exit-code 1 --python .\Verification\smoke_test.py
```

输出保存在 profiles/daily/relocation-test。源码内含单元测试，重建后可运行 blender_test --gtest_filter=DrawOpenGLTest.eevee_shadow*:DrawVulkanTest.eevee_shadow*。

## 验证范围

已测试上面的合成场景和硬件，未测试其他显卡、所有插件、用户实际项目或长时间完整动画。视口截图为指定帧检查，不代表完整动画播放验收。8 GB 是阴影图集容量，其他渲染数据还需要额外显存。Cycles 渲染器和其它功能未在本任务中做全面回归。
