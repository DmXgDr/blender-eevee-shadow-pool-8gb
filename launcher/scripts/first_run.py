# SPDX-License-Identifier: GPL-3.0-or-later
import bpy
from pathlib import Path
root=Path(__file__).resolve().parent.parent
bpy.ops.wm.read_factory_settings(use_empty=False)
bpy.context.scene.render.engine='BLENDER_EEVEE'
bpy.context.scene.eevee.shadow_pool_size='8192'
bpy.context.preferences.view.show_splash=False
bpy.context.preferences.filepaths.temporary_directory=str(root/'profiles/daily/temp')
bpy.ops.wm.save_userpref()
bpy.ops.wm.save_homefile()
print('Portable 8 GiB startup initialized')
