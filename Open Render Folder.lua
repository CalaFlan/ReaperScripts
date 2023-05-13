-- Get the path of the project file
project_path = reaper.GetProjectPath("")

-- Extract the directory part of the path
project_dir = project_path:match("(.*\\)")

-- Extract the parent directory of the project directory
parent_dir = project_dir:match("(.*\\)")

-- Append the "Renders" directory to the parent directory
renders_dir = parent_dir .. "Renders\\"

-- Convert the path to a format that can be used by File Explorer
renders_dir = '"' .. renders_dir .. '"'

-- Use the Windows "explorer" command to open the folder in File Explorer
os.execute("explorer " .. renders_dir)

