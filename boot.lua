local boottimer = os.startTimer(2)
local alphOS = true
local utilOS = false
local diskOS = false

term.setBackgroundColor( colours.white )

local function os.version()
    if term.isColor() == true then
        term.setTextColor( colours.cyan )
        term.setBackgroundColor( colours.black )
    else
        term.setTextColor( colours.white )
        term.setBackgroundColor( colours.black )
    end
    return "alphOS v1.0-alpha-1.0"
end

repeat
    local event, key = os.pullEvent()
    
    if event == "key" then
        if key == keys.r then
            alphOS = false
            utilOS = true
            diskOS = false
        elseif key == keys.leftAlt then
            alphOS = false
            utilOS = false
            diskOS = true
        end
    elseif event == "key_up" then
        if key == keys.r then
            alphOS = true
            utilOS = false
        elseif key == keys.leftAlt then
            alphOS = true
            diskOS = false
        end
    end
until event == "timer" and key == boottimer

if utilOS == true then
    -- Go to the utility OS
    
    local request = shell.run("utilOS.lua")
    
elseif diskOS == true then
    -- Go to the disk selection OS
    
    local request = shell.run("diskOS.lua")
    
elseif alphOS == true then
    -- Go to the primary operating system
    
    local request = shell.run("alphOS/main.lua")
else
    -- Oh. There's nowhere to go.
end

-- Any additional shutdown processes go here

if request == "shutdown" then
    term.setBackgroundColor( colours.grey )
    term.clear()
    sleep(1/20)
    os.shutdown()
    return
elseif request == "restart" then
    term.setBackgroundColor( colours.grey )
    term.clear()
    sleep(1/20)
    term.setBackgroundColor( colours.black )
    term.clear()
    sleep(1)
    os.reboot()
    return
elseif request == "terminal" and utilOS == true then
    term.setBackgroundColor( colours.grey )
    term.clear()
    sleep(1/20)
    term.setBackgroundColor( colours.black )
    term.clear()
    sleep(1)
    term.setCursorPos(1,1)
    term.setTextColor(16)
    print(os.version())
    return
end

os.shutdown() -- Just to be safe!
