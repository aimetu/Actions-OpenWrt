#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改 device 设备名称
sed -i "s/LibWrt/OpenWrt/g" package/base-files/files/bin/config_generate

# 默认网关 ip 地址修改
sed -i 's/192.168.1.1/192.168.188.1/g' package/base-files/files/bin/config_generate

# 修改 wifi 无线名称
sed -i "s/LibWrt/OpenWrt/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh

# 更换 5.4 内核为 5.10 内核
# sed -i "s/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g" target/linux/ramips/Makefile

# 取消 bootstrap 为默认主题，将 argon 设置为默认主题
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# 添加 AdguardHome 广告过滤插件，删除自带 AdguardHome 文件
rm -rf feeds/packages/net/adguardhome
# git clone https://github.com/kongfl888/luci-app-adguardhome package/new/luci-app-adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/new/luci-app-adguardhome
