-- get the selected items
local item1 = reaper.GetSelectedMediaItem(0, 0)
local item2 = reaper.GetSelectedMediaItem(0, 1)

-- check if two items are selected
if not (item1 and item2) then
    reaper.ShowMessageBox("Please select two items.", "Error", 0)
    return
end

-- get the start positions of the items
local start1 = reaper.GetMediaItemInfo_Value(item1, "D_POSITION")
local start2 = reaper.GetMediaItemInfo_Value(item2, "D_POSITION")

-- calculate the time between the start positions
local timeBetween = start2 - start1

-- display the time between the items in seconds
reaper.ShowMessageBox("The time between items: " .. timeBetween .. " seconds.", "Time Between Items", 0)

