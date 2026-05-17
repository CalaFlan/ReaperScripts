local function get_last_file_name(directory)
    local command = 'dir /a-d /o-d /tc /b "'..directory..'" 2>nul:'
    -- /tw for last modified file
    -- /tc for last created file
    local pipe = io.popen(command)
    local file_name = pipe:read()
    pipe:close()
    return file_name
 end
 
 local directory = [[d:\OBSRecordings\]] -- <--- Replace this with your chosen directory (OBS Output path, Downloads, Ect) dont forget the "\" at the end!
 local file_name = get_last_file_name(directory)
 if file_name then
    reaper.InsertMedia(directory..file_name,1)
 else
    reaper.ShowConsoleMsg("Directory is empty")
 end
