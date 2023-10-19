import wmi
import logging
import requests
import configparser

from urllib3.exceptions import InsecureRequestWarning


def get_public_ipv6_address():
    try:
        wmi_service = wmi.WMI()
        network_adapters = wmi_service.Win32_NetworkAdapterConfiguration(IPEnabled=True)

        for adapter in network_adapters:
            for addr in adapter.IPAddress:
                if ':' in addr:  # IPv6 addresses contain colons
                    if not addr.startswith('fe80::'):  # Exclude link-local addresses
                        return addr

        return None
    except Exception as e:
        print(f"发生错误: {e}")
        return None


if __name__ == '__main__':
    # 配置日志
    logging.basicConfig(filename='updateDuckDdns.log', level=logging.DEBUG,
                        format='%(asctime)s - %(levelname)s - %(message)s', encoding='utf-8')

    # 记录不同级别的日志
    # logging.debug('这是一个调试消息')
    # logging.info('这是一个信息消息')
    # logging.warning('这是一个警告消息')
    # logging.error('这是一个错误消息')
    # logging.critical('这是一个严重错误消息')

    logging.info("同步ipv6开始!------------->")

    public_ipv6_address = get_public_ipv6_address()
    if public_ipv6_address:
        logging.info('通过WMI获取到公网ipv6：%s', public_ipv6_address)
    else:
        logging.error('未找到公网IPv6地址')

    # 创建配置文件解析器
    config = configparser.ConfigParser()
    config.read('config.ini')  # 指定配置文件的路径

    # 从配置文件中读取值
    domains = config['API']['domains']
    token = config['API']['token']
    url = config['API']['url']
    logging.info("通过配置文件读取到url:%s, domains:%s, token:%s", url, domains, token)

    params = {
        "domains": domains,
        "token": token,
        "ipv6": public_ipv6_address
    }

    # 发送HTTP GET请求
    # response = requests.get(url, params=params, verify=False)  # 使用verify=False忽略SSL验证，如果需要的话
    # 禁用InsecureRequestWarning警告
    requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

    try:
        response = requests.get(url, params=params, verify=False)  # 使用verify=False忽略SSL验证，如果需要的话
    except requests.exceptions.ConnectionError as e:
        print("error occur:", e)
    # response = requests.get(url, params=params, verify=False)  # 使用verify=False忽略SSL验证，如果需要的话
    """
    InsecureRequestWarning: Unverified HTTPS request is being made to host 'www.duckdns.org'. Adding certificate verification is strongly advised. See: https://urllib3.readthedocs.io/en/latest/advanced-usage.html#tls-warnings
    warnings.warn(
    这个警告不会影响ddns同步，屏蔽就好：
    使用 PYTHONWARNINGS 环境变量，设置为 ignore:Unverified HTTPS request
    在 Python 代码中，导入 urllib3 模块，并调用 urllib3.disable_warnings (urllib3.exceptions.InsecureRequestWarning)
    在 Python 代码中，导入 requests 模块，并调用 requests.packages.urllib3.disable_warnings (InsecureRequestWarning)
    """
    print(response.text)
    logging.info("发起请求:%s", response.text)
    logging.info("同步ipv6结束!\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
