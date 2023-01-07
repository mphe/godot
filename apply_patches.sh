#!/usr/bin/env bash

# arg1: host
# arg2: branch
merge() {
    git fetch "$1" "$2"
    git merge FETCH_HEAD
}

# arg1: pull request id
# arg2: branch name
merge2() {
    git fetch upstream "pull/$1/head:$2"
    git merge "$2"
}

merge_cherry_pick() {
    git fetch upstream "pull/$1/head:$2"
    git cherry-pick "$2"
}

git merge custom_patches_3.x_base

# Allow exporting custom resources from/to any scripting language (GDScript, VisualScript, C#, NativeScript, PluginScript). #44879
# https://github.com/godotengine/godot/pull/44879
merge https://github.com/willnationsdev/godot gdres-all-3.2

# NodePath export hint #39155
# https://github.com/godotengine/godot/pull/39155
merge https://github.com/brndel/godot nodepath-export-hint

# TODO: Consider merging https://github.com/godotengine/godot/pull/38118#issuecomment-1412631169

patch -p0 < ./fix_array_export_custom_resource.patch
git commit -avm "Fix array export with custom resources"
