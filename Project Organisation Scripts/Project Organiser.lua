-- for each track in the project
-- Get the number of tracks in the project
local NumberOfTracks = reaper.CountTracks(0)

-- Check if its a folder track (treat any non-zero folder depth as a folder boundary)
function CheckIfFolder(track)
    -- I_FOLDERDEPTH >0 = folder start, <0 = folder end. Treat both as folder boundary.
    local depth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
    if depth ~= 0 then
        return true
    else
        return false
    end
end

-- Check if the track has any FX.
function CheckIfFX(track)
    -- Get the number of FX on the track
    local fxCount = reaper.TrackFX_GetCount(track)
    if fxCount > 0 then
        return true -- The track has FX
    else
        return false -- The track has no FX
    end
end

function CheckIfReceivesOrSends(track)
    -- Get the number of receives on the track (category 0)
    local receiveCount = reaper.GetTrackNumSends(track, -1)
    -- Get the number of sends from the track (category 0)
    local sendCount = reaper.GetTrackNumSends(track, 0)
    if receiveCount > 0 or sendCount > 0 then
        return true -- The track has receives or sends
    else
        return false -- The track has neither receives nor sends
    end
end

function CheckifmediaItems(track)
    -- Get the number of media items on the track
    local itemCount = reaper.CountTrackMediaItems(track)
    if itemCount > 0 then
        return true -- The track has media items
    else
        return false -- The track has no media items
    end
end

-- Main Body
for i = NumberOfTracks, 1, -1 do
    local track = reaper.GetTrack(0, i - 1)
    if track then
        reaper.ShowConsoleMsg ("Track " .. i .. ": ")
        if CheckIfFolder(track) == false
        then
            if CheckIfFX(track) == false
            then
                if CheckIfReceivesOrSends(track) == false
                then
                    if CheckifmediaItems(track) == false
                    then
                        reaper.ShowConsoleMsg("Track " .. i .. " Track is Empty\n")
                        reaper.DeleteTrack(reaper.GetTrack(0, i - 1))
                    else
                        reaper.ShowConsoleMsg("Track " .. i .. " has media items\n")
                    end
                else
                    reaper.ShowConsoleMsg("Track " .. i .. " HAS receives or sends.\n")
                end
            else
                reaper.ShowConsoleMsg("Track " .. i .. " IS a FX track.\n")
            end
        else
            reaper.ShowConsoleMsg("Track " .. i .. " IS a folder track.\n")
        end
    end
end
-- Delete Selected Tracks