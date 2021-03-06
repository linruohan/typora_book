
##  扫描wifi
```sh
dev=`networkctl | grep wlan | awk '{print $2}'`;
iwlist $dev scan | grep "ESSID:"
```
NetworkManager (简体中文)
Jump to navigationJump to search
Related articles

Network configuration
Wireless network configuration
Category:Network configuration
翻译状态：本文是 NetworkManager 的翻译。上次翻译日期：2015-02-17。如果英文版本有所更改，则您可以帮助同步翻译。
网络管理器(NetworManager)是检测网络、自动连接网络的程序。无论是无线还是有线连接，它都可以令您轻松管理。对于无线网络,网络管理器优先连接已知的网络并可以自动切换到最可靠的无线网络。利用网络管理器的程序可以自由切换在线和离线模式。网络管理器会相对无线网络优先选择有线网络，支持 VPN。网络管理器最初由 Redhat 公司开发，现在由 GNOME 管理。

警告： 请注意, Wi-Fi 的密码默认情况下是明文保存的。参见 #加密的Wi-Fi密码

Contents
1	安装
1.1	启用 NetworkManager
1.2	额外的用户界面
1.3	移动网络支持
1.4	VPN 支持
1.5	PPPoE / DSL 支持
2	使用
2.1	nmcli 使用示例
3	前端
3.1	GNOME
3.2	KDE Plasma
3.3	nm-applet
3.3.1	Appindicator
3.4	nmcli-dmenu
4	配置
4.1	设置 PolicyKit 权限
4.2	使用 NetworkManager 调度网络服务
4.2.1	避免超时
4.2.2	启动 OpenNTPD
4.2.3	使用sshfs挂载远程文件夹
4.2.4	使用 dispatcher 在网络连接建立后连接 vpn
4.3	代理设置
4.4	禁用 NetworkManager
5	测试
6	常见问题
6.1	安全Wi-Fi网络不提示输入密码
6.2	PPTP 通道中无流量
6.3	网络管理功能失效
6.4	定制resolv.conf
6.5	使用 resolv.conf.head 和 resolv.conf.tail
6.6	在resolv.conf中保留改动
6.7	使用dhclient时的DHCP问题
6.8	主机名问题
6.9	配置dhclient把主机名推送到DHCP服务器
6.10	配置NetworkManager使用一个特性的DHCP客户端
6.11	缺少默认路由 route
6.12	没有探测到 3G 模块
6.13	在笔记本上关闭WLAN
6.14	静态 IP 设置 变成 DHCP
6.15	普通用户无法编辑链接
6.16	删除隐蔽无线网络链接
6.17	GNOME VPN失效问题
6.18	Unable to connect to visible European wireless networks
6.19	引导时自动连接到VPN不工作
6.20	dhcpd不断地拒绝租约
6.21	Systemd瓶颈
6.22	网络(WiFi)经常有规律地断开
7	提示与技巧
7.1	加密的Wi-Fi密码
7.2	通过Wi-Fi共享网络连接
7.2.1	Ad-hoc
7.2.2	Real AP
7.3	通过Ethernet共享连接
7.4	在cron任务（jobs）或脚本中检查网络是否连接
7.5	登陆后自动解锁秘钥环
7.5.1	GNOME
7.6	有密码认证的KDE and OpenConnect VPN
7.7	忽略特定设备
7.8	启用DNS缓存
7.9	启用IPv6隐私扩展
8	其它资源
安装
NetworkManager可以通过networkmanager包安装。这个包包括了一个daemon、一个命令行界面(nmcli)和一个基于curses的界面(nmtui)。NetworkManager支持基本的DHCP功能。对于全功能的DHCP和IPV6支持，请安装dhclient 。

启用 NetworkManager
安装好之后需要启动/启用 NetworkManager.service systemd 服务。NetworkManager 守护进程启动后，会自动连接到任何可用的已经配置的系统连接。用户连接或未配置的连接需要通过nmcli或applet进行配置和连接。

额外的用户界面
nm-connection-editor，提供图形界面，
network-manager-applet，提供系统托盘图标(nm-applet)。
Note: 你必须确保没有其他会对网络进行配置的服务正在运行;事实上, 多个网络配置服务之间会相互冲突。如果想知道当前有哪些服务正在运行, 可以运行 systemctl --type=service 然后 停止 多余的网络配置服务。参见 #配置 来激活 NetworkManager 服务。
移动网络支持
安装modemmanager、mobile-broadband-provider-info和usb_modeswitch来支持连接移动网络。详情参见USB 3G Modem#NetworkManager。

VPN 支持
从1.16版本开始NetworkManager对WireGuard有原生支持[1]。

NetworkManager 对其他 VPN 的支持基于一个插件系统。请针对需要的VPN类型选择性安装以下的软件包:

networkmanager-openconnect for OpenConnect
networkmanager-openvpn for OpenVPN
networkmanager-pptp for PPTP Client
networkmanager-vpnc for Vpnc
networkmanager-strongswan for strongSwan
networkmanager-fortisslvpn-gitAUR
networkmanager-iodine-gitAUR
networkmanager-libreswanAUR
networkmanager-l2tpAUR
networkmanager-ssh-gitAUR
networkmanager-sstpAUR[断开的链接：package not found]
警告： VPN支持是unstable，请通过GUI检查daemon进程的选项是否正确设置了，并在每次更新之后再次检查。[2]
Note: 为了在使用VPN的时候使用全功能的DNS，你应该设置split DNS[断开的链接：无效的部分]。
PPPoE / DSL 支持
安装 rp-pppoe 来获得对 PPPoE / DSL 连接的支持。使用nm-connection-editor并添加一个新的DSL/PPPoE连接。

使用
NetworkManager 自带了 nmcli(1) 和 nmtui(1).

nmcli 使用示例
显示附近的 wifi:

$ nmcli device wifi list
连接 wifi:

$ nmcli device wifi connect SSID password password
连接到隐藏的 wifi:

$ nmcli device wifi connect SSID password password hidden yes
通过 wlan1 wifi 网卡(interface)连接 wifi:

$ nmcli device wifi connect SSID password password ifname wlan1 profile_name
断开一个网卡(interface)上的连接:

$ nmcli device disconnect ifname eth0
重新连接一个被标记为“已断开”的网卡：

$ nmcli connection up uuid UUID
显示一个所有连接过的网络的UUID的列表:

$ nmcli connection show
查看所有网络设备及其状态:

$ nmcli device
关掉 wifi:

$ nmcli radio wifi off
前端
为了配置和轻松使用网络管理器，大多数用户会希望安装一个托盘组件。图形前端往往显示在系统托盘（或通知区域），从而允许用户选择网络或者配置 NetworkManager。不同类型的桌面环境下有多种托盘插件。

GNOME
GNOME在 网络设置 里有内置的配置工具。

KDE Plasma
安装 plasma-nm 软件包。然后通过 面板的选项 > 添加部件 > 网络 来把它添加到KDE的任务栏上。

nm-applet
network-manager-applet 是一个GTK3+前端小程序，工作在Xorg环境下，带有一个系统托盘。

为了存储连接密码，请安装并配置 GNOME/Keyring。

请注意，如果对某个连接启用了 对其他用户可用 选项，NetworkManager就会将密码明文存储，虽然相应的文件只能被root或者其他使用 nm-applet 的用户访问。参照 #加密的Wi-Fi密码。

在没有系统托盘的情况下运行 nm-applet，可以使用 trayer 或者 stalonetray。比如，你可以在自己的可执行文件路径中添加这样的脚本：

nmgui
#!/bin/sh
nm-applet    2>&1 > /dev/null &
stalonetray  2>&1 > /dev/null
killall nm-applet
当关闭 stalonetray 窗口的时候，它会关闭 nm-applet，所以当你完成网络配置后它就不会再占用内存。

nm-applet 可以显示一些事件的消息，比如连接或断开WiFi。为了显示这些消息，确保你已安装了一个消息服务器 - 参照 Desktop notifications。如果你在没有消息服务器的情况下使用它，消息可能会出现在stdout/stderr中并可能导致程序卡住。参照 [3]。

为了在禁用消息提示的情况下使用 nm-applet，用以下命令运行程序：

$ nm-applet --no-agent
Tip: nm-applet 可能被 自启动desktop文件 自动启动，这种情况下要添加--no-agent选项请修改Exec那一行：
Exec=nm-applet --no-agent
Appindicator
nm-applet 是支持Appindicator的，但没有被编译进官方软件包，详见 FS#51740。为了在Appindicator环境中使用nm-applet，将 network-manager-applet 替换成 network-manager-applet-indicatorAUR[断开的链接：package not found] 并执行以下命令：

$ nm-applet --indicator
nmcli-dmenu
networkmanager-dmenu-gitAUR 是一个通过 dmenu 而不是 nm-applet 来管理 NetworkManager 连接的脚本。它提供了所有必要的功能, 例如连接到已有的 WiFi 或有线网络、连接到新的 WiFi 网络、在需要的时候询问密码、连接到已有的 VPN、启用/停用网络连接、运行图形界面 nm-connection-editor 等等。

配置
NetworkManager 需要做这么几步保证正常运行。确保你/etc/hosts按照Network configuration#Set the hostname一节的描述配置了/etc/hosts。

NetworkManager的全局配置文件位于/etc/NetworkManager/NetworkManager.conf。额外的配置文件可以放进/etc/NetworkManager/conf.d/文件夹。通常全局的默认配置不需要改动。

设置 PolicyKit 权限
参照General troubleshooting#Session permissions建立一个工作会话. 在工作会话中,你有三种方式授予NetworkManager工作所必须的权限.

方式 1. 登录后运行PolicyKit认证代理,比如 /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 (polkit-gnome 的一部分). 当你添加和删除一个网络链接时会提示输入密码.

方式 2. 将你的账户加入wheel账户组. 管理网络时你将不需要输入密码,但注意你的账户同时被赋予了此账户组的其他权限,比如运行sudo命令是无需密码.

方式 3. 将你的账户加入network账户组,同时创建以下文件:

/etc/polkit-1/rules.d/50-org.freedesktop.NetworkManager.rules
polkit.addRule(function(action, subject) {
  if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("network")) {
    return polkit.Result.YES;
  }
});
所有在network账户群中的用户都能免密码管理网络. 但是如果你没有在 systemd-logind[断开的链接：无效的部分] 中拥有一个活跃会话的话, 在systemd下此方式将失效.

使用 NetworkManager 调度网络服务
有些服务只有联网时才有意义，例如 OpenNTPD 和 网络文件系统挂载(netfs)。dispatcher 可以在连接网络后启动这些服务，并在网络关闭时停止它们。要使用这一功能, 需要启动 NetworkManager-dispatcher.service。 并且将脚本加到 /etc/NetworkManager/dispatcher.d 目录。这些脚本必须属于 root, 否则不会被执行。为了安全起见, 用户组也设置为 root:

# chown root:root scriptname
而且脚本必须只能是拥有者可写, 否则不会被执行:

# chmod 755 scriptname
脚本将在连接网络时按字母表顺序运行，并在网络停止时反向停止。要保证启动顺序，可以在前面加数字，例如 10_portmap 或 30_netfs 这样就能保证 portmapper 在 NFS 挂载之前启动。

警告： 如果没有连接到外部网络，请注意启动的服务和需要它们的程序。如果连接公共网络时启动了错误的服务，可能导致安全问题。
避免超时
如果一切运行良好, 那么这一节就可以跳过了。 However, there is a general problem related to running dispatcher scripts which take longer to be executed. Initially an internal timeout of three seconds only was used. If the called script did not complete in time, it was killed. Later the timeout was extended to about 20 seconds (see the Bugtracker for more information). If the timeout still creates the problem, a work around may be to modify the dispatcher service file /usr/lib/systemd/system/NetworkManager-dispatcher.service to remain active after exit:

/etc/systemd/system/NetworkManager-dispatcher.service
.include /usr/lib/systemd/system/NetworkManager-dispatcher.service
[Service]
RemainAfterExit=yes
运行修改后的 NetworkManager-dispatcher 服务并将其设置为开机启动。

警告： 加入了 RemainAfterExit 那一行后会让 dispatcher 一直运行。不幸的是, dispatcher 必须在再次运行脚本前被关闭。这意味着脚本只能被运行一次。因此, 除非超时确实引起了问题, 否则不要修改服务文件。
启动 OpenNTPD
安装 networkmanager-dispatcher-openntpdAUR 软件包

使用sshfs挂载远程文件夹
由于该脚本在一个非常受限制的环境中运行, 为了连接上SSH agent, 你必须 export SSH_AUTH_SOCK。 这里有几种不同方式, 参照 here 获取更多详细信息. 以下示例需要 gnome-keyring , 如果 gnome-keyring 没解锁,将需要你输入密码. 如果 NetworkManager 设置为登录后自动连接, 很有可能因为 gnome-keyring 还没启动导致失败(转入睡眠). 对应的 UUID 可以通过命令 nmcli con status 或 nmcli con list 查得。

#!/bin/sh
USER='username'
REMOTE='user@host:/remote/path'
LOCAL='/local/path'

interface=$1 status=$2
if [ "$CONNECTION_UUID" = "uuid" ]; then
  case $status in
    up)
      export SSH_AUTH_SOCK=$(find /tmp -maxdepth 1 -type s -user "$USER" -name 'ssh')
      su "$USER" -c "sshfs $REMOTE $LOCAL"
      ;;
    down)
      fusermount -u "$LOCAL"
      ;;
  esac
fi
使用 dispatcher 在网络连接建立后连接 vpn
此部分示例演示如果自动连接到NetworkManager已定义的vpn-connection.首先创建调度脚本定义vpn连接之后的事务

1. 创建调度脚本
/etc/NetworkManager/dispatcher.d/vpn-up
#!/bin/sh
VPN_NAME="name of VPN connection defined in NetworkManager"
ESSID="Wi-Fi network ESSID (not connection name)"

interface=$1 status=$2
case $status in
  up|vpn-down)
    if iwgetid | grep -qs ":\"$ESSID\""; then
      nmcli con up id "$VPN_NAME"
    fi
    ;;
  down)
    if iwgetid | grep -qs ":\"$ESSID\""; then
      if nmcli con status id "$VPN_NAME" | grep -qs activated; then
        nmcli con down id "$VPN_NAME"
      fi
    fi
    ;;
esac
如果想在任意 Wi-Fi 网络都可以自动连接 VPN, 你可以用这样给 ESSID 赋值: ESSID=$(iwgetid -r)。记住要给脚本设置相应的权限, 参见 上文[断开的链接：无效的部分]。

如果想任意用户都能使用 VPN, 即使已经在 nm-applet 中勾选了 Make the VPN connection available to all users 选项, 由于 VPN secrets 保管方式的原因, 连接依然可能会失败并且 NetworkManager 会报错 'no valid VPN secrets'。这样就需要执行步骤2:

2. 可以选择编辑 VPN 连接的配置文件让 NetworkManager 自己储存 secrets 而不是把 secrets 保存在 不能被root访问的 keyring 中: 打开 /etc/NetworkManager/system-connections/name of your VPN connection, 把 password-flags 以及 secret-flags 从 1 改为 0。
或者直接在 VPN 配置文件中加入 vpn-secrets 并写入密码:

 [vpn]
 ....
 password-flags=0
 
 [vpn-secrets]
 password=your_password
注意： 现在可能有必要重新打开 NetworkManager connection editor 并再次保存 VPN passwords/secrets。
代理设置
NetworkManager不直接处理代理设置，但是如果你使用GNOME，你可以使用 proxydriver配合NetworkManager。 proxydriverAUR软件包位于 AUR.

为使proxydriver设置代理，你需要在设置GNOME自动启动进程( System->Preferences->Startup Applications):

xhost +si:localuser:your_username
参照: Proxy settings

禁用 NetworkManager
由于服务是通过 dbus 自动启动的, 所以要完全禁用可以用 systemctl 来屏蔽:

systemctl mask NetworkManager
systemctl mask NetworkManager-dispatcher
测试
NetworkManager 托盘组件被设计成开机自动启动，所以对大部分用户来说，并不需要过多配置。 但是如果你手动停用旧有的网络设置断网，你需要测试一下 NetworkManager 是否正常工作。 首先启动服务：

systemctl start NetworkManager
有些托盘组件会提供给你一个 .desktop 文件以便通过系统菜单运行。 如果没有，那你就需要通过命令或者注销重登录系统来让托盘组件运行。 一旦托盘组件运行了，它会自动请求网络连接并通过 DHCP 服务器来进行网络配置。

在一些 non-xdg-compliant 窗口系统，比如 Awesome 中启动 GNOME applet：

nm-applet --sm-disable &
如果需要静态 IP，你需要配置 NetworkManager。一般来说，在托盘图标上面点击右键， 选择「编辑连接」即可。

常见问题
常见问题的一些解决办法。

安全Wi-Fi网络不提示输入密码
当连接到一个安全的WI-Fi网络时，没有输入密码的提示，而且没有连接建立。当没有秘钥环(keyring)包安装时，会发生这种情况。一个简单的解决办法是安装gnome-keyring。如果你希望密码以加密的形式存储，按照GNOME Keyring来设置gnome-keyring-daemon。

PPTP 通道中无流量
PPTP连接成功登录，可以看到一个有正确VPN IP的ppp0接口，但是甚至不能ping通远端IP。这是由于Arch提供的pppd缺少MPPE (Microsoft Point-to-Point Encryption) 支持。 推荐首先尝试Arch提供的ppp，因为它可能会按照希望的样子工作。

要解决这个问题，安装ppp-mppeAUR[断开的链接：package not found]包应该足够了。

参见WPA2 Enterprise#MS-CHAPv2。

网络管理功能失效
有时NetworkManager关闭了，但对应的pid文件却没有移除，同时你得到提示 'Network management disabled'. 你可以手工处理:

# rm /var/lib/NetworkManager/NetworkManager.state
定制resolv.conf
参见主页面resolv.conf。如果你使用dhclient，你可以尝试networkmanager-dispatch-resolvAUR[断开的链接：package not found]包。

使用 resolv.conf.head 和 resolv.conf.tail
请阅读 resolv.conf 并确保 NetworkManager 使用的是 dhcpcd 而不是 dhclient。如果要使用 dhclient，可以试试AUR里面的 networkmanager-dispatch-resolvAUR[断开的链接：package not found]。

在resolv.conf中保留改动
NetworkManager试图将DHCP中获取的DNS信息写入/etc/resolv.conf,导致原文件被覆盖,你可以在文件属性中设置i参数避免文件被修改

# chattr +i /etc/resolv.conf
如果你要修改此文件,移除i参数:

# chattr -i /etc/resolv.conf
使用dhclient时的DHCP问题
如果你无法通过DHCP获取IP,尝试在/etc/dhclient.conf添加如下配置:

 interface "eth0" {
   send dhcp-client-identifier 01:aa:bb:cc:dd:ee:ff;
 }
其中aa:bb:cc:dd:ee:ff 是你网卡的MAC地址. MAC地址可以使用iproute2 包中的 ip link show eth0 命令获得。

主机名问题
主机名是否被转发到所链接的路由器取决与你所使用的NetworkManager插件。通用的“密钥文件”插件默认不转发主机名。为了使之转发主机名，添加下面的内容到/etc/NetworkManager/NetworkManager.conf：

[keyfile]
hostname=your_hostname
[keyfile]下的选项会应用到默认/etc/NetworkManager/system-connections路径的网络连接。

另一种选择是配置NetworkManager自动启动的DHCP客户端来转发主机名。NetworkManager默认使用dhclient，并且当前者没有安装时使用dhcpcd。使dhclient 转发主机名需要设置一个非默认选项, dhcpcd默认转发主机名.

首先，检查使用的是哪一个DHCP客户端(以dhclient为例):

# journalctl -b | egrep "dhc"
...
Nov 17 21:03:20 zenbook dhclient[2949]: Nov 17 21:03:20 zenbook dhclient[2949]: Bound to *:546
Nov 17 21:03:20 zenbook dhclient[2949]: Listening on Socket/wlan0
Nov 17 21:03:20 zenbook dhclient[2949]: Sending on   Socket/wlan0
Nov 17 21:03:20 zenbook dhclient[2949]: XMT: Info-Request on wlan0, interval 1020ms.
Nov 17 21:03:20 zenbook dhclient[2949]: RCV: Reply message on wlan0 from fe80::126f:3fff:fe0c:2dc.

配置dhclient把主机名推送到DHCP服务器
复制示例配置文件：

# cp /usr/share/dhclient/dhclient.conf.example /etc/dhclient.conf

看一下这个文件 - 其实我们想保存的只有一行而且dhclient会使用其他选项的默认值 (就像你没有这个文件时它使用的那样)。下面是那重要的一行：

/etc/dhclient.conf
send host-name = pick-first-value(gethostname(), "ISC-dhclient");
用你最喜欢的方法强制进行IP地址刷新，然后你应该可以在你的DHCP服务器上看到你的主机名了。

IPv6推送主机名：

# cp /usr/share/dhclient/dhclient.conf.example /etc/dhclient6.conf
/etc/dhclient6.conf
send fqdn.fqdn = pick-first-value(gethostname(), "ISC-dhclient");
配置NetworkManager使用一个特性的DHCP客户端
如果你想显示地设置Networkmanager使用的DHCP客户端，可以在全局配置文件中设置：

/etc/NetworkManager/NetworkManager.conf
dhcp=internal
如果这个选项更没有设置，按照默认使用的是替代的dhcp=dhclient。

然后restart NetworkManager.service。

Note: dhcpcd的支持已经在networkmanager-1.0.0-2 (2015-02-14)中 禁用 。

缺少默认路由 route
在至少一个KDE4系统中,当使用NetworkManager Wireless Setup (简体中文)链接时不会建立缺省路由。 改变无线链接的路由配置来移除Use only for resources on this connection"的默认选择能解决这个问题。

没有探测到 3G 模块
如果NetworkManager(从v0.7.999)没有探测到你的3G模块,但是你仍然可以使用wvdial连接, 可以尝试安装modemmanager,并使用rc.d restart networkmanager重启服务,你可能需要重插或重启你的3G模块, 这可以让NetworkManager支持默认数据库中缺失的硬件模块

参考USB 3G Modem#NetworkManager.

在笔记本上关闭WLAN
有时候在你使用笔记本上的开关禁用WI-Fi然后重新启用后，NetworkManager无法工作。这常常是rfkill的问题。 $ watch -n1 rfkill list all 检查驱动rfkill是否通知到无线适配器的状态. 如果你开启适配器后,其标识符仍然显示blocked,你可以尝试如下命令手动unblock(X是前一条命令的identifier编号)

# rfkill event unblock X
静态 IP 设置 变成 DHCP
因为一个尚未结局的bug，当改变默认连接为静态IP时，nm-applet 可能不能恰当地保存你的IP配置改变，而自动转变为DHCP模式。

要解决这个问题，你不得不在nm-applet中改变默认连接名（比如将"Auto eth0"变成“my eth0”）,去掉“Available to all users”的勾号，输入你的配置IP地址，然后点击“Apply”。这样就能按照所给的名字保存新的配置

接下来，你可能不希望默认链接自动连接网络。运行 nm-connection-editor (不要以root身份)。在链接编辑窗口，编辑默认配置(eg "Auto eth0") 去掉"Connect automatically".， 点击 Apply，关掉窗口。

普通用户无法编辑链接
参见 #Set_up_PolicyKit_permissions[断开的链接：无效的部分].

删除隐蔽无线网络链接
因为隐蔽无线网络不出现在无线列表中，所以不能在GUI中删除，你可以试用以下命令：

# rm /etc/NetworkManager/system-connections/[SSID]
此命令对任何其他连接有效。

GNOME VPN失效问题
在GNOME系统中用NetworkManager 设立OpenConnect或VPN链接，有时会无法跳出对话框，在/var/log/errors.log中会出现如下错误提示：

localhost NetworkManager[399]: <error> [1361719690.10506] [nm-vpn-connection.c:1405] get_secrets_cb(): Failed to request VPN secrets #3: (6) No agents were available for this request.
这是由于Gnome NM Applet在/usr/lib/gnome-shell中读取脚本， 而NetworkManager安装包将脚本安装/usr/lib/networkmanager中（这个bug已经存在一段时间了）. 临时解决方法可以文件夹中创建软连接

对于OpenConnect: ln -s /usr/lib/networkmanager/nm-openconnect-auth-dialog /usr/lib/gnome-shell/
对于VPNC (也即 Cisco VPN): ln -s /usr/lib/networkmanager/nm-vpnc-auth-dialog /usr/lib/gnome-shell/
对其他类型的NM VPN插件可能也需要做类似的事情，不过上述两种VPN是最常见的。

Unable to connect to visible European wireless networks
WLAN chips are shipped with a default regulatory domain. If your access point does not operate within these limitations, you will not be able to connect to the network. Fixing this is easy:

Install crda
Uncomment the correct Country Code in /etc/conf.d/wireless-regdom
Reboot the system, because the setting is only read on boot
引导时自动连接到VPN不工作
问题原因在于，当系统(也即以root用户运行的NetworkManager)尝试建立一个VPN连接时无法获取密码，因为密码存储在一个特性用户的Gnome kerying中。

解决的一个办法是用明文存储VPN密码，如#Use dispatcher to connect to a VPN after a network connection is established[断开的链接：无效的部分]步骤(2.)中所描述。

如果你使用nm-appletGUI中的新的"auto-connect VPN"选项，你不再需要使用步骤(1.)所描述的分配器来自动连接。

dhcpd不断地拒绝租约
有人报告dhcpd不断地拒绝租约，同时大量产生如下日志消息：

 dhcpcd[25188]: wlan0: NAK: from 10.1.0.1
 dhcpcd[25188]: wlan0: soliciting a DHCP lease
 dhcpcd[25188]: wlan0: offered 10.2.0.159 from 10.2.0.1
 dhcpcd[25188]: wlan0: ignoring offer of 10.1.0.197 from 10.1.0.1
 dhcpcd[25188]: wlan0: NAK: from 10.1.0.1
 dhcpcd[25188]: wlan0: soliciting a DHCP lease
 dhcpcd[25188]: wlan0: offered 10.2.0.159 from 10.2.0.1
 dhcpcd[25188]: wlan0: ignoring offer of 10.1.0.197 from 10.1.0.1
解决这个问题似乎可以通过切换到 dhclient而不是dhcpcd(对于 NetworkManager, 在/etc/NetworkManager/NetworkManager.conf中设置dhcp选项为 dhclient).

Systemd瓶颈
经过一段时间，日志文件(/var/log/journal)可能会变得非常庞大。当使用NetworkManager时，这可能对引导性能产生大的影响，参考：Systemd#Boot time increasing over time。

网络(WiFi)经常有规律地断开
有些WIFI驱动如果在连接/关联的同时扫描基站会有问题。症状包括VPN断开/重连和丢包，页面无法加载但之后刷新没有问题。

运行journalctl -f可以表明这种情况是否正在发生，和下面相似的信息会在日志文件中以有规律的间隔出现：

NetworkManager[410]: <info>  (wlp3s0): roamed from BSSID 00:14:48:11:20:CF (my-wifi-name) to (none) ((none))
有一个补丁版的NetworkManager应该可以阻止这种扫描：networkmanager-noscanAUR。

提示与技巧
加密的Wi-Fi密码
NetworkManager默认在连接文件/etc/NetworkManager/system-connections/中以明文存储密码。要打印存储的密码，使用下列命令：

# grep -H '^psk=' /etc/NetworkManager/system-connections/*
密码可以被文件系统上的root用户以及可以通过GUI（例如nm-applet）访问设置的普通用户访问。

以加密形式而不是明文存储密码更好，可以通过在秘钥环中存储它们来实现，NetworkManager之后会向秘钥环询问密码。建议使用的秘钥环守护进程是GNOME Keyring或者(仅适用于KDE)KDE Wallet。 要想让之后的东西工作，秘钥环守护进程需要启动，并且秘钥环需要解锁。

更进一步，NetworkManager需要配置为不为所有的用户存储密码。使用GNOMEnm-applet，运行nm-connection-editor来获取一个终端，选择网络连接，点击Edit，选择 Wifi-Security选项卡单后点击密码右侧的图标，勾选Store the password for this user。使用KDE的kdeplasma-applets-plasma-nm[断开的链接：package not found]，点击小程序，点击右上方Settings图标，双击一个网络连接，在 General settings选项卡中，去掉all users may connect to this network。如果这个选项被勾选了，及时秘钥环守护进程在运行，密码也将会以明文存储。

如果这个选项之前被选择了，然后你去掉了它，你可能需要先使用reset选项来使密码从文件中消失。或者，先删掉连接，然后重新建立。

秘钥环的缺点是连接要为每一个用户设置。

通过Wi-Fi共享网络连接
使用nm，你只要点击几下就可以共享你的internet连接（例如，3G或者有线）。你需要一个支持的Wi-Fi卡（基于Atheros AR9xx或者至少AR5xx的网卡可能是最好的选择）。

Ad-hoc
安装dnsmasq包来能够实际共享连接。
配置dnsmasq.conf可能会干扰NetworkManager (对此不确定，不过我觉得是这样)。
点击小程序，选择"Create new wireless network"。
按照指南 (如果使用WEP, 确保使用5到13字符长度的密码,其他的长度可能会失败)。
下次你需要的时候，设置依然在存储着。
Real AP
2012年底，NetworkManager添加了对infrastructure mode（安卓手机需要这个模式，因为他们故意不支持ad-hoc模式）的支持。

参见 Fedora's wiki.

通过Ethernet共享连接
场景: 你的设备有通过wi-fi的internet连接，你想通过ethernet和其他设备共享internet连接。

要求:

安装dnsmasq以能够真正地共享连接。
你的连有internet的设备和其他的设备通过合适的ethernet线缆连接（通常这意味着一个交叉线(cross over cable)或者之间有一个交换机（switch））
步骤:

从终端运行nm-connection-editor
添加一个新的ethernet连接
给它起一个合适的名字。比如"共享连接"
转到"IPv4 设置"（IPv4 settings）
对于"方法:"（method） 选择 "与其他电脑共享"（Shared to other computers）
保存
现在，你在NetworkManager的有线连接下应该有了一个新"共享连接"的选项。

在cron任务（jobs）或脚本中检查网络是否连接
有些cron任务需要可用的网络连接才能成功。你可能希望在网络不可用时避免运行这些任务。为此，添加一个网络的if 测试，该测试询问NetworkManager的nm-tool 并检查网状态。下面展示的测试当任何接口可用时成功，当所有借口都不可用时失败。对于可能连接有线，无线或者关闭网络的笔记本来说这很方便。


if [ $(nm-tool|grep State|cut -f2 -d' ') == "connected" ]; then
    #Whatever you want to do if the network is online
else
    #Whatever you want to do if the network is offline - note, this and the else above are optional
fi
例如，这对于一个运行fpupdate来更新F-Prot病毒扫描签名的cron.hourly脚本很有帮助。另外，经过小的修改，使用nm-tool输出的不同部分可以区分不同的网络；例如，因为活跃的无线网络连接有一个星号（asterisk'*'）表示，你可以grep网络名，然后grep星号。

登陆后自动解锁秘钥环
GNOME
右击面板中的nm-applet图标，并选择编辑连接（Edit Connections），打开无线(wireless)选项卡
选择你想要使用的连接并单击编辑
勾选"自动连接"（“Connect Automatically”）框和"对所有用户可用"（“Available to all users”）框
登出并重新登录，完成。


Note: 下述方法已经年代久远，并且已知在至少一个机器上不能工作
在/etc/pam.d/gdm (或者 /etc/pam.d里你相应的守护进程中),如果"auth"和"session"块不存在，在后面添加如下内容：
 auth            optional        pam_gnome_keyring.so
 session         optional        pam_gnome_keyring.so  auto_start
在/etc/pam.d/passwd中, 使用这一行替代'password'块:
 password    optional    pam_gnome_keyring.so
下次登录时，你会被询问你是否希望密码在登录时自动解锁。
有密码认证的KDE and OpenConnect VPN
kdeplasma-applets-plasma-nm[断开的链接：package not found]现在支持配置OpenConnect VPN连接的用户名和密码。打开你的VPN连接，接受证书，连接域会出现。如果没有，看下面的指令，现在输入正确的用户名和密码。

==== 问题解决 ====‘

虽然你可能在连接时输入两个值，kdeplasma-applets-plasma-nm[断开的链接：package not found] 0.9.3.2-1及以上版本能够直接从KWallet中获取OpenConnect用户名和密码。

打开"KDE Wallet Manager"在"Network Management|Maps"下面查找你的OpenConnect VPN连接。点击"Show values"并在这个表的键值"VpnSecrets"下输入你的凭据（相应替代'username'和'password'）:

form:main:username%SEP%username%SEP%form:main:password%SEP%password
下次你连接时，用户名和密码会出现在"VPN secrets"对话框中。

忽略特定设备
有时，可能希望Networkmanager忽略特定的设备，并且不为他们配置地址和路由。通过在/etc/NetworkManager/NetworkManager.conf中使用下述配置，你可以快速轻松地按照MAC或者接口名忽略设备。

[keyfile]
unmanaged-devices=mac:00:22:68:1c:59:b1;mac:00:1E:65:30:D1:C4;interface-name:eth0
填入上述内容后，重启NetworkManager，然后你应该能够在NetworkManager不改变你已经完成的设置的情况下配置接口。

启用DNS缓存
使用dnsmasq来启用允许DNS缓存的插件参见 dnsmasq#NetworkManager[断开的链接：无效的部分]

启用IPv6隐私扩展
参见 IPv6#NetworkManager


其它资源
Wireless network configuration -- 无线配置(wiki)
NetworkManager - 网络管理器的官方主页
NetworkManager for Administrators Part 1
Categories: Network managers (简体中文)Red Hat (简体中文)
