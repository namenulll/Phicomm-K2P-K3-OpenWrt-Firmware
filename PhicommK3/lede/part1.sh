#!/bin/bash

#
#Copyright 2022 yangxu52<https://github.com/yangxu52>
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#

echo '添加pass dependencies'
sed -i '$a src-git passpack https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
echo '=========Add feed source OK!========='


echo '添加插件'
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
git clone https://github.com/kenzok8/small package/lean
git clone https://github.com/kenzok8/openwrt-packages package/lean
echo '=========Add feed source OK!========='

echo '添加dnsfilter'
rm -rf package/lean/luci-app-dnsfilter 
git clone https://github.com/kiddin9/luci-app-dnsfilter package/lean/luci-app-dnsfilter 
echo '=========Add dnsfilter source OK!========='

echo '添加用于过滤'
git clone https://github.com/destan19/OpenAppFilter/tree/master/oaf package/lean/luci-app-oaf
echo '=========Add dnsfilter source OK!========='

echo '添加OpenClash'
rm -rf package/lean/luci-app-openclash
svn checkout https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-openclash
echo '=========Add OpenClash source OK!========='


echo '添加jerrykuku的argon-mod主题'
rm -rf package/lean/luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon
echo '=========Add argon-mod OK!========='


echo '替换lwz322的K3屏幕驱动插件'
rm -rf package/lean/k3screenctrl
git clone https://github.com/yangxu52/k3screenctrl_build.git package/lean/k3screenctrl/
echo '=========Replace k3screen drive plug OK!========='

echo '添加ssr'
sed -i "/helloworld/d" "feeds.conf.default"
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
echo '=========Add OpenClash source OK!========='

echo '移除bcm53xx中的其他机型'
sed -i '421,453d' target/linux/bcm53xx/image/Makefile
sed -i '140,412d' target/linux/bcm53xx/image/Makefile
sed -i 's/$(USB3_PACKAGES) k3screenctrl/luci-app-k3screenctrl/g' target/linux/bcm53xx/image/Makefile
# sed -n '140,146p' target/linux/bcm53xx/image/Makefile
echo '=========Remove other devices of bcm53xx OK!========='

#1.'asus_dhd24' 2.'ac88u_20' 3.'69027'
firmware='ac88u_20'
echo '替换K3的无线驱动为asus-dhd24'
wget -nv https://github.com/yangxu52/Phicomm-k3-Wireless-Firmware/raw/master/brcmfmac4366c-pcie.bin.${firmware} -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
echo '=========Replace k3 wireless firmware OK!========='
