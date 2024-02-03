- On Windows
1. `scoop install winsw`
2. 将下载的 winsw.exe 文件和 XML 配置文件放在同一个目录下。winsw.exe 文件的名称需要与 XML 配置文件的基本名称相匹配。
3. winsw install

- On MacOS
使用 launchctl 管理服务
1. mv macos.meta.service.plist /Library/LaunchDaemons/macos.meta.service.plist;
2. sudo launchctl load macos.meta.service # 加载服务
3. sudo launchctl unload macos.meta.service # 卸载服务
4. sudo launchctl start macos.meta.service # 卸载服务
5. sudo launchctl stop macos.meta.service # 卸载服务
