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
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#移除不用软件包    
rm -rf package/lean/luci-app-dockerman
rm -rf package/lean/luci-app-wrtbwmon

#添加额外软件包
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/jerrykuku/luci-app-ttnode.git package/luci-app-ttnode
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
git clone https://github.com/rufengsuixing/luci-app-autoipsetadder.git package/luci-app-autoipsetadder
git clone https://github.com/mchome/openwrt-dogcom.git package/openwrt-dogcom

svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-filebrowser package/luci-app-filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/filebrowser package/filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/lienol/luci-app-fileassistant package/luci-app-fileassistant
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
# cd package/luci-app-serverchan && git reset --hard 6387b3b47b03d95d3f3bcd42ff98db5bb84fd056 && git pull && cd ../..
svn co https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon package/wrtbwmon
git clone https://github.com/brvphoenix/luci-app-wrtbwmon
cd luci-app-wrtbwmon
git reset --hard ff7773abbf71120fc39a276393b29ba47353a7e2 && cp -r luci-app-wrtbwmon ../package/
cd ..
# themes
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat

svn co https://github.com/project-openwrt/openwrt/trunk/package/lienol/luci-app-socat package/luci-app-socat

git clone https://github.com/xrouterservice/luci-app-koolddns.git package/luci-app-koolddns
#赋予koolddns权限
chmod 0755 package/luci-app-koolddns/root/etc/init.d/koolddns
chmod 0755 package/luci-app-koolddns/root/usr/share/koolddns/aliddns

svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-unblockneteasemusic-mini package/luci-app-unblockneteasemusic-mini
#添加subweb&subconverter
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/duktape package/duktape
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/jpcre2 package/jpcre2
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/rapidjson package/rapidjson
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/subweb package/subweb
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/subconverter package/subconverter
#添加smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/luci-app-smartdns

#添加ksmbd
#svn co https://github.com/openwrt/luci/trunk/applications/luci-app-ksmbd package/luci-app-ksmbd
#添加udp2raw
git clone https://github.com/sensec/openwrt-udp2raw package/openwrt-udp2raw
git clone https://github.com/sensec/luci-app-udp2raw package/luci-app-udp2raw
sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=f2f90a9a150be94d50af555b53657a2a4309f287/" package/openwrt-udp2raw/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=20200920\.0/" package/openwrt-udp2raw/Makefile

./scripts/feeds update -a
./scripts/feeds install -a

#readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

#replace coremark.sh with the new one
rm package/lean/coremark/coremark.sh
cp $GITHUB_WORKSPACE/general/coremark.sh package/lean/coremark/

