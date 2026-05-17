-- Do Selection Command
 reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELTRAXNOITEMS"), 0)

local numberOfTracks = reaper.CountSelectedTracks(0) -- Get how many selected tracks there are

-- Check each select track for Recieves and, FX or being a parent 
for i=1,numberOfTracks,1 do
      -- Current track
    -- Folder Check
    if (reaper.GetMediaTrackInfo_Value(MediaTrack tr, I_FOLDERDEPTH) == 1)


end

-- Deselect 


 
 function main()

  retval, pattern = reaper.GetSetProjectInfo_String( 0, "RENDER_PATTERN", "", false )

  count_tracks = reaper.CountTracks(0)
  zeros = string.len(tostring(count_tracks))

  -- LOOP TRHOUGH SELECTED TRACKS
  local total = 0
  for i, track in ipairs(init_sel_tracks) do
    reaper.SetOnlyTrackSelected(track)
    reaper.Main_OnCommand(40340, 0) -- Unsolo all tracks
    reaper.Main_OnCommand(40728, 0) -- Solo track

    local retval, track_name = reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "", false) -- Get track info
    local track_id = reaper.GetMediaTrackInfo_Value( track, "IP_TRACKNUMBER" )

    local new_pattern = pattern:gsub("$tracknumber", AddZeros(track_id, zeros))

    parent_track = reaper.GetParentTrack( track )
    parent_track_name = ""
    if parent_track then
      retval, parent_track_name = reaper.GetSetMediaTrackInfo_String(parent_track, "P_NAME", "", false) -- Get track info
    end
    new_pattern = new_pattern:gsub("$parenttrack", parent_track_name)

    new_pattern = new_pattern:gsub("$track", track_name)

    reaper.GetSetProjectInfo_String( 0, "RENDER_PATTERN", new_pattern, true )

    total = total + 1

  end

  retval, pattern = reaper.GetSetProjectInfo_String( 0, "RENDER_PATTERN", pattern, true ) -- Restore initial pattern

  reaper.Main_OnCommand(40340, 0) -- Unsolo all tracks

end
