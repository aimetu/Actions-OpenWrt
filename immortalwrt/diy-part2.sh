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
sed -i "s/ImmortalWrt/OpenWrt/g" package/base-files/files/bin/config_generate

# 默认网关 ip 地址修改
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# 修改 wifi 无线名称
sed -i "s/ImmortalWrt/OpenWrt/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 wifi 无线名称 & 密码
sed -i "s/OWRT/OpenWrt/g" target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
sed -i "s/12345678/password/g" target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh

# 最大连接数修改为65535
# sed -i "s/nf_conntrack_max=.*/nf_conntrack_max=65535/g" package/kernel/linux/files/sysctl-nf-conntrack.conf
# sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

# 修改 wifi 默认打开
# sed -i "s/disabled='${defaults ? 0 : 1}'/disabled='0'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 更换 6.6 内核为 6.1 内核
# sed -i "s/KERNEL_PATCHVER:=6.6/KERNEL_PATCHVER:=6.1/g" target/linux/qualcommax/Makefile

# samba 解除 root 限制
# sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template

# 取消 bootstrap 为默认主题，添加 argon 主题设置为默认
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-theme-argon-config

# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# 添加 kucat 主题，搭配 luci-app-advancedplus 设置参数 
# git clone -b js https://github.com/sirpdboy/luci-theme-kucat.git package/luci-theme-kucat

# 添加 advanced 系统设置插件
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# git clone https://github.com/sirpdboy/luci-app-advancedplus.git package/luci-app-advancedplus

# 删除自带 AdguardHome 文件，添加 AdguardHome 广告过滤插件
# rm -rf feeds/packages/net/adguardhome
# https://github.com/xptsp/luci-app-adguardhome package/luci-app-adguardhome
# git clone https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# 更新 golang 依赖（ mosdns & alist 插件 )
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# 替换 geodata 依赖
# rm -rf feeds/packages/net/v2ray-geodata
# git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 添加 mosdns 插件
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/luci-app-mosdns

# 添加 smartdns 插件
# rm -rf feeds/packages/net/smartdns
# rm -rf feeds/luci/applications/luci-app-smartdns
# git clone https://github.com/pymumu/openwrt-smartdns.git package/smartdns
# git clone https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# 添加 nekobox 插件
# git clone https://github.com/Thaolga/openwrt-nekobox.git package/openwrt-nekobox

# 添加 nikki 插件
# git clone https://github.com/nikkinikki-org/OpenWrt-nikki.git package/luci-app-nikki

# 添加 OpenClash 插件（ dev 版 ）
# rm -rf feeds/luci/applications/luci-app-openclash
# git clone -b dev https://github.com/vernesong/OpenClash.git package/luci-app-openclash
