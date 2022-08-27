-- neogit configuration
require("plenary")
local neogit = require('neogit')
neogit.setup {
  integrations = { diffview = true }
}
