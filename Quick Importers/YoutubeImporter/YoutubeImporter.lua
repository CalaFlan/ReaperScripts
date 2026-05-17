-- CHANGE ME
local ytdlp_path = "C:\\Users\\me\\Desktop\\ytdlp" -- Replace with your yt-dlp path, remember to use double backslashes in the path

-- Settings
local Download_format = "-x --force-overwrites  --audio-format wav" -- Replace with your desired format options

--
local url = ""
local download_Path -- Gets set to ReaProject Path, or Default recording path if project is not saved

--
local function promptURL()
    local retval, user_input = reaper.GetUserInputs("YouTube Downloader", 1, "Enter YouTube URL:, extrawidth=200",url)
    if retval then
        url = user_input
    else
        url = nil
    end
end

local function SetDownloadPath()
    download_Path = reaper.GetProjectPath("")
end

local function findLatestFile(directory)
    -- Use Windows dir command to get files sorted by date (most recent last)
    local handle = io.popen("dir /b /od \"" .. directory .. "\"")
    local latest_file = nil
    
    for file in handle:lines() do
        if file ~= "" then
            latest_file = file  -- Keep the last one (most recent)
        end
    end
    handle:close()
    
    if latest_file then
        return directory .. "\\" .. latest_file
    end
    return nil
end

local function importVideo()
    -- find the most recently downloaded file in the download path
    local latest_file = findLatestFile(download_Path) 
    if latest_file then
        reaper.InsertMedia(latest_file, 0)
        -- reaper.ShowConsoleMsg("Imported: " .. latest_file .. "\n")
    else
        reaper.ShowMessageBox("No file found in download path", "Error", 0)
    end
end

local function DownloadVideo()
    if not url then
        reaper.ShowMessageBox("No URL provided", "Error", 0)
        return
    end
    local command = "cd \"" .. ytdlp_path .. "\" && .\\yt-dlp " .. Download_format .. " -P \"" .. download_Path .. "\" \"" .. url .. "\""
    os.execute(command) -- Run the yt-dlp command to download the video/audio
    importVideo()
end

promptURL()
SetDownloadPath()
DownloadVideo()