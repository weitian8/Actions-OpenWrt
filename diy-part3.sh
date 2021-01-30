#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 移除不用软件包    
# rm -rf package/lean/luci-app-dockerman
# rm -rf package/lean/luci-app-wrtbwmon

# 添加额外软件包
# git clone https://github.com/vernesong/OpenClash.git package/OpenClash
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-filebrowser package/luci-app-filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/filebrowser package/filebrowser
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost

# themes
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat

# fw876/helloworld
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
