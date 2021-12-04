## 视频输入设置
xrandr --output LVDS1 --off --output DP1 --off --output VGA1 --off --output VIRTUAL1 --off --output VGA-1-2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal 


alias pi='sudo pacman -Sy'
alias vi='sudo vim'
alias pr='sudo pacman -Rs'
alias wo='cd ~/working'
alias ra='ranger'
alias wifi1='iwlist scan | grep "ESSID:"'
alias wifi='nmcli device wifi list | head -10'
alias shouji='nmcli device wifi connect "HONOR 30" password "12345678"'
alias kuandai='nmcli device wifi connect "xiaohan001" password "Mm1214875764"'
alias duankaiwifi='nmcli device disconnect wlp3s0'
