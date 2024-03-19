local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local cheatsh = require("nvim-cheatsh.cheatsh")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

return function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "cheat.sh",
    finder = finders.new_table({
        })
  })
end

-- pickers
--   .new(opts, {
--     prompt_title = "cheat.sh",
--     finder = finders.new_table({
--       results = cheat_queries,
--       entry_maker = function(entry)
--         if string.find(entry, "/") then
--           return {
--             value = {
--               string.sub(entry, 1, string.find(entry, "/") - 1),
--               string.sub(entry, string.find(entry, "/") + 1),
--             },
--             display = entry,
--             ordinal = entry,
--           }
--         end
--         return {
--           value = entry,
--           display = entry,
--           ordinal = entry,
--         }
--       end,
--     }),
--     sorter = conf.generic_sorter(opts),
--     previewer = cheat_previewer(),
--     attach_mappings = function(prompt_bufnr, _)
--       actions.select_default:replace(function()
--         local selection = action_state.get_selected_entry()
--         if selection then
--           actions.close(prompt_bufnr)
--           Cheat.open(selection.value)
--         end
--       end)
--       return true
--     end,
--   })
--   :find()
