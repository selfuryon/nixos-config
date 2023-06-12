require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    personal = "~/notes/personal",
                },
                index = "index.norg",
                default_workspace = "personal",
            }
        }
    }
}
