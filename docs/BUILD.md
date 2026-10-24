# 对应源码与重建

本包是基于 Blender 5.2.3 LTS 的非官方修改构建。原始提交：`e13b728c6880d3084d9d57c30031ed5df8b39dee`。修改日期：2026-10-23。

`blender-5.2.3-shadow8gb-source.tar.xz` 包含官方发布源码和本版本的实际修改；`shadow-pool-8gb.patch` 是相对于官方源码的差异；`changed-files.json` 记录官方及修改文件的 SHA-256。源码内保留原作者和许可声明。

修改文件：

- `eevee_defines.hh`：32,768 个物理页，512 个图集层。
- `eevee_shadow_shared.hh`：15 位页地址；利用已分配页和缓存引用互斥的关系共享字段；采样数据保留 LOD 0–7 的完整偏移范围。
- `eevee_shadow.cc`：可选分配及缓存诊断。设置进程环境变量 `BLENDER_SHADOW_POOL_DIAGNOSTICS=1` 才输出额外信息。
- `rna_scene.cc`：增加 4 GB、8 GB 设置选项。
- `DNA_scene_types.h`：新默认值为 8192 MiB。
- `eevee_test.cc`：页地址、缓存索引、层级偏移和 GPU 分配测试。

阴影页仍为 256×256、每像素 4 字节。8 GB 档位实际图集为 2048×2048×512，即 8,589,934,592 字节（8 GiB）。本修改不增加灯光或 tilemap 数量上限。

## Windows 重建

1. 克隆本仓库，源码位于 `blender/`。仓库根目录的 `Build-Windows.cmd` 指向此目录；Release 源码归档则使用包内 Source/ 的构建脚本。
2. 准备 Visual Studio 2022 的 x64 C++ 编译环境、CMake、Ninja、Git 与 Git LFS。
3. 官方 Windows x64 依赖仓库为 `https://projects.blender.org/blender/lib-windows_x64.git`，固定提交为 `60d6e96b917568278d400a4024c98da0fb777338`。检出到源码内 `lib/windows_x64`，并下载所需的真实 LFS 文件。不能把 100 多字节的 LFS 占位文件当成库。
4. OptiX 头文件从 NVIDIA 官方 `https://github.com/NVIDIA/optix-dev` 取得，本次使用提交 `f1f6dd803f3159992d248178f6e09421c6eb8b6d`，版本 9.1.0。遵循 NVIDIA 自身许可，并把 `OPTIX_ROOT_DIR` 设置为 SDK 根目录。包内不附开发 SDK。
5. 在 x64 VS Developer Command Prompt 中运行 `Build-Windows.cmd`。本次编译器为 MSVC 19.44.35228，CMake 3.29.2；Windows 发布包启用 EEVEE、OpenGL、Vulkan、Cycles、OSL、USD、MaterialX、OIDN 和 NVIDIA OptiX，未启用 Intel oneAPI 或 AMD HIPRT。
6. 本包的 Cycles GPU 预编译内核取自相同版本、相同原始提交的官方 Windows ZIP；Cycles 内核源码未修改。重建时可从官方同版本包取得，或依照源码的 `WITH_CYCLES_CUDA_BINARIES` 等选项自行编译。

依赖的版本、源码地址、哈希及构建脚本在源码的 `build_files/build_environment` 下；第三方许可在程序的 `license` 目录。保留本源码归档、差异补丁、修改说明和许可随程序一并分享。

官方来源：

- https://www.blender.org/releases/5-2/
- https://download.blender.org/source/blender-5.2.3.tar.xz
- https://download.blender.org/release/Blender5.2/blender-5.2.3-windows-x64.zip
- https://www.blender.org/about/license/
