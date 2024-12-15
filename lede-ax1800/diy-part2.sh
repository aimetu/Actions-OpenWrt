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
# sed -i "s/LibWrt/OpenWrt/g" package/base-files/files/bin/config_generate

# 默认网关 ip 地址修改
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# 修改 wifi 无线名称
# sed -i "s/LibWrt/OpenWrt/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh

# 更换 5.4 内核为 5.10 内核
# sed -i "s/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g" target/linux/qualcommax/Makefile

# samba 解除 root 限制
# sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template

# 取消 bootstrap 为默认主题，将 argon 设置为默认主题 ( for LuCI 18.06 & 23.05 )
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone  https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# 添加 AdguardHome 广告过滤插件，删除自带 AdguardHome 文件
rm -rf feeds/packages/net/adguardhome
# git clone https://github.com/kongfl888/luci-app-adguardhome package/new/luci-app-adguardhome
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/new/luci-app-adguardhome

# 更新 lede 的内置的 smartdns 版本
rm -rf feeds/packages/net/smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git feeds/packages/net/smartdns
sed -i "/^PKG_SOURCE_VERSION:=/cPKG_SOURCE_VERSION:=e89778809897329f48c662b5cb9d69ed9df6c032" feeds/packages/net/smartdns/Makefile
sed -i "s/PKG_MIRROR_HASH/#PKG_MIRROR_HASH/" feeds/packages/net/smartdns/Makefile

# 安装 luci-app-smartdns（ 必选 )
rm -rf feeds/luci/applications/luci-app-smartdns
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns
# git clone https://github.com/pymumu/smartdns.git package/smartdns

# 插件 mosdns & alist 依赖，删除重复 golang & v2ray 防止插件冲突
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
# rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
