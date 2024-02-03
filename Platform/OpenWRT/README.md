# OpenWRT Config
- Theme: [luci-theme-argon](https://github.com/jerrykuku/luci-theme-argon)
- Application: https://github.com/kenzok8/openwrt-packages
    - luci-app-adguardhome
    - luci-app-openclash
    - luci-proto-wireguard
    - luci-app-ddns
    - ddns-scripts-cloudflare

## Note:
- AdGuardHome 无法开机自启
    原因是出现了一个小写的 `adguardhome` 进程，禁用小写的进程即可 https://github.com/kenzok8/openwrt-packages/issues/320

- AdGuardHome 作为 OpenClash 上游
    1. AdGuardHome 的 53 端口重定向改为 使用 53 端口替换 dnsmasq
    2. OpenClash --> 插件设置 --> DNS 设置 --> 禁用 本地 DNS 劫持
    3. OpenClash --> 覆写设置 --> 常规设置 --> nameserver 添加 127.0.0.1：53

- OpenClash 启动报错「无法获取 General 部分的转发端口设置, OpenClash 使用原始配置文件启动失败」
    OpenClash --> 插件设置 --> 版本更新 --> 更新内核和 OpenClash 或者手动下载

- CloudFlare-DDNS 失败
    - 查询主机名  是完整的域名，不是子域名
    - 域名  3级域名和二级域名之间有个 @ 符号