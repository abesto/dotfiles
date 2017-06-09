-- heavily based on http://github.com/vicfryzel/xmonad-config

Config {
    bgColor = "#000000",
    fgColor = "#ffffff",
    font = "xft:Source Code Pro:style=Semibold:size=8",
    lowerOnStart = True,
    commands = [
        Run MultiCpu ["-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-p","3"] 10,
        Run ThermalZone 0 ["-H","80"] 10,  -- critical trip point is 107
        Run ThermalZone 7 ["-H","70"] 10,  -- critical trip point is 100
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-p","3"] 10,
        Run Network "wlp2s0" ["-H","1024","-L","100","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","4"] 10,
        Run Network "tun0" ["-H","1024","-L","100","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","4"] 10,
        Run Date "%a %b %_d %Y %H:%M:%S" "date" 10,
        Run StdinReader,
        Run TopProc ["-w","15","-a","r"] 10,
        Run Battery ["-t", "Bat: <acstatus> <timeleft> (<left>%)",
               "-L", "10", "-H", "80", "-p", "3",
               "--", "-O", "<fc=green>On</fc> - ", "-i", "",
               "-L", "-15", "-H", "-5",
               "-l", "red", "-m", "blue", "-h", "green"]
              600
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader%}{<%top%><%multicpu% %thermal0% %thermal7%><%memory%><%wlp2s0%><VPN=%tun0%> %battery% <fc=#FFFFCC>%date%</fc>"
}
