return {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
        mac_window_bar = false,
        has_breadcrumbs = true,
        watermark = "",
    },
    cmd = {
        "CodeSnap",
        "CodeSnapSave",
    },
}
