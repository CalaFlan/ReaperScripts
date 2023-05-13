-- Get the current project
local proj = reaper.GetProjectStateChangeCount(0)

-- Get the selected media item
local item = reaper.GetSelectedMediaItem(proj, 0)

if item then
  -- Get the start and end positions of the media item
  local start_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  local end_pos = start_pos + reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  
  -- Set the play cursor position to the middle of the media item
  reaper.SetEditCurPos((start_pos + end_pos) / 2, true, false)
  
  -- Perform the action ID 40792 to select the item under the edit cursor
  reaper.Main_OnCommand(40792, 0)
end

-- get the selected items
local item1 = reaper.GetSelectedMediaItem(0, 0)
local item2 = reaper.GetSelectedMediaItem(0, 1)

-- get the item positions
local item1_pos = reaper.GetMediaItemInfo_Value(item1, "D_POSITION")
local item2_pos = reaper.GetMediaItemInfo_Value(item2, "D_POSITION")

-- swap the positions
reaper.SetMediaItemInfo_Value(item1, "D_POSITION", item2_pos)
reaper.SetMediaItemInfo_Value(item2, "D_POSITION", item1_pos)

-- update the arrange view
reaper.UpdateArrange()
