#!/usr/bin/env fish

function elapsed
    if command -v gdate >/dev/null 2>&1
        set dateBin gdate
    else
        set dateBin date
    end

    # 检查系统是否支持%N
    set test_nano ($dateBin +%N)
    set nano_supported true
    if test "$test_nano" = N
        set nano_supported false
    end

    # 根据系统是否支持纳秒进行时间戳记录
    if test "$nano_supported" = true
        set start_time ($dateBin +%s%N)
    else
        set start_time ($dateBin +%s)
    end

    # 执行传入的命令
    $argv

    # 再次根据系统进行时间戳记录
    if test "$nano_supported" = true
        set end_time ($dateBin +%s%N)
    else
        set end_time ($dateBin +%s)
    end

    # 计算运行时间
    set elapsed
    if test "$nano_supported" = true
        set elapsed (math (math $end_time - $start_time) / 1000000) # 转换为毫秒
        # use -g to export elapsed_time
        set -g elapsed_time "$elapsed ms"
    else
        set elapsed (math $end_time - $start_time) # 已经是秒
        # use -g to export elapsed_time
        set -g elapsed_time "$elapsed s"
    end
end
