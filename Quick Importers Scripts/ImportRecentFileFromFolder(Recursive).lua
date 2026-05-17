local function get_last_file_name(directory)
    -- Use PowerShell to recursively find the most recent file
    local command = [[powershell -NoProfile -Command "Get-ChildItem -Path ']] .. directory .. [[' -File -Recurse -ErrorAction SilentlyContinue | Sort-Object -Property CreationTime -Descending | Select-Object -First 1 -ExpandProperty FullName"]]
    local pipe = io.popen(command)
    local file_path = pipe:read()
    pipe:close()
    
    -- Trim whitespace
    if file_path then
        file_path = file_path:match("^%s*(.-)%s*$")
    end
    
    return file_path
 end
 
local function Check_Track1_Name_Is_Video()
   local tr = reaper.GetTrack(0, 0);
   if tr == nil then return (0) end

   local b, trackname = reaper.GetTrackName(tr)
   if string.find(trackname, "Video") then
      return (tr) -- True
   else
      return (0) -- False
   end
end


 local directory = [[D:\Media\OBSRecordings\Plum\]]
 local file_path = get_last_file_name(directory)
 if file_path and file_path ~= "" then
   if Check_Track1_Name_Is_Video() == 0 then -- If the first track is not named "Video", insert a new track and name it "Video"
      reaper.InsertTrackAtIndex(0,0)
      reaper.GetSetMediaTrackInfo_String(reaper.GetTrack(0, 0), "P_NAME", "Video", true)
      reaper.InsertMedia(file_path, 0) 
   else -- If the first track is already named "Video", just insert the media item
   -- deselect the current selected track and select the first track
      reaper.SetOnlyTrackSelected(reaper.GetTrack(0, 0))
      reaper.InsertMedia(file_path, 0)
   end
 else
    reaper.ShowConsoleMsg("Directory is empty or no files found")
 end