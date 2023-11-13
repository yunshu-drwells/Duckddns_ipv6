#!/bin/sh
# 获取脚本所在目录的相对路径
SCRIPT_DIR=$(dirname "$0")
# 获取脚本所在目录的绝对路径
ABSOLUTE_PATH=$(cd "$SCRIPT_DIR" && pwd)
ipv6_address=$($ABSOLUTE_PATH/get_ipv6_re.sh)  # get ipv6
echo $(date "+%Y-%m-%d %H:%M:%S") >> $ABSOLUTE_PATH/duck.log  # echo current time to log
# 输出获取的 IPv6 地址
echo "$ipv6_address" >> $ABSOLUTE_PATH/duck.log 2>&1
# use curl update ddns
domains=ubuntu224
token=da2f0fce-ed39-4fd9-bbfa-0c63b61adab9
url="url=https://www.duckdns.org/update?domains=$domains&token=$token&ipv6=$ipv6_address"
echo "$url" > ./url
curl -k -K ./url >> $ABSOLUTE_PATH/duck.log
echo "\n" >> $ABSOLUTE_PATH/duck.log
