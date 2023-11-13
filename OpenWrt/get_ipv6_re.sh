#!/bin/bash
# 使用 ifconfig 命令获取 WAN 口信息，并将结果保存到变量中
wan_info=$(ifconfig pppoe-wan)
# echo "$wan_info"
echo "$wan_info" > ip_tmp

# re get inet6 addr: 240e:368:1000:1984:d94:c777:e17b:3d4d/64 Scope:Global
ipv6_address=$(grep -E 'inet6.*Scope:Global' ip_tmp)
echo "$ipv6_address" > ip_tmp
# 取中间ip
ipv6_address=$(sed -n 's/.*inet6 addr: \([^ ]*\) Scope:Global.*/\1/p' ip_tmp)
echo "$ipv6_address" > ip_tmp
# 去除结尾/64
ipv6_address=$(sed 's/\/64$//' ip_tmp)

# 输出获取的 IPv6 地址
echo "$ipv6_address"

