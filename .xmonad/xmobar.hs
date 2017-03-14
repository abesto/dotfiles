-- heavily based on http://github.com/vicfryzel/xmonad-config

Config {
    bgColor = "#000000",
    fgColor = "#ffffff",
    font = "xft:Source Code Pro:style=Semibold:size=8",
    lowerOnStart = True,
    commands = [
        Run MultiCpu ["-t","Cpu: <total0>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Swap ["-t","Swap: <used>/<total>","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run DynNetwork ["-t","<dev>: <rxvbar><rx>/<tx><txvbar>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Date "%a %b %_d %Y %H:%M:%S" "date" 10,
        Run StdinReader,
        Run TopProc [] 10,
        Run TopMem [] 10,
        Run Battery ["-t", "Battery: <acstatus><timeleft> (<left>%)",
               "-L", "10", "-H", "80", "-p", "3",
               "--", "-O", "<fc=green>On</fc> - ", "-i", "",
               "-L", "-15", "-H", "-5",
               "-l", "red", "-m", "blue", "-h", "green"]
              600,
        Run DiskIO [("/", "Disk: <readvbar>R|W<writevbar>")] [] 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %top%   %multicpu%   %memory%   %diskio%   %swap%   %dynnetwork%   %battery%   <fc=#FFFFCC>%date%</fc>"
}
