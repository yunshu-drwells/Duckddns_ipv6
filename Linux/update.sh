#!/bin/sh
echo $(date "+%Y-%m-%d %H:%M:%S") >> ./duck.log  # echo current time to log
ipv6_address=$(./get_ipv6_re.sh)  # get ipv6
echo "$ipv6_address"
# 输出获取的 IPv6 地址
echo "$ipv6_address" >> ./duck.log 2>&1
# 通过curl发起网络请求更新ddns
domains=xxxxxxxx
token=da2f0fce-ed39-4fd9-bbfa-xxxxxxxxxxxx
url="url=https://www.duckdns.org/update?domains=$domains&token=$token&ipv6=$ipv6_address"
echo "$url" > ./url
curl -k -K ./url >> ./duck.log
echo "\n" >> ./duck.log
