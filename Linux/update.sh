#!/bin/sh
ipv6_address=$(/duckdns/get_ipv6_re.sh)
echo "$ipv6_address"
# 输出获取的 IPv6 地址
# echo "$ipv6_address" >> /duckdns/updatelog_yunshu.log 2>&1
echo url="https://www.duckdns.org/update?domains=xxxx&token=xxxxxxxx-c9c5-4615-935e-12f9ea953b56&ipv6=$ipv6_address" | curl -k -o /duckdns/duck.log -K -
