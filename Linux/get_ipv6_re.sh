#!/bin/bash
# 使用 ifconfig 命令获取 WAN 口信息，并将结果保存到变量中
lan_info=$(ifconfig)
echo "$lan_info" > ip_tmp

# re get inet6 240e:358:116f:7500:d9f:2fc0:ddab:a96e  prefixlen 64  scopeid 0x0<global>
ipv6_address=$(grep -E 'inet6.*prefixlen 64  scopeid 0x0<global>' ip_tmp)
echo "$ipv6_address" > ip_tmp
# get first line
ipv6_address=$(head -n 1 ip_tmp)
echo "$ipv6_address" > ip_tmp

# 取中间ip
ipv6_address=$(sed -n 's/.*inet6 \([^ ]*\)  prefixlen 64  scopeid 0x0<global>.*/\1/p' ip_tmp)
echo "$ipv6_address" > ip_tmp

# 输出获取的 IPv6 地址
echo "$ipv6_address"

