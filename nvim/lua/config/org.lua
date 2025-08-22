require("orgmode").setup({
  org_agenda_files = { "~/Documents/org/**/*" },
  org_default_notes_file = "~/Documents/org/refile.org",

  mappings = {
    global = {
      org_agenda = ",a",
      org_capture = ",c",
    },
    org = {
      org_toggle_checkbox = ",x",
      org_toggle_heading = ",h",
      org_toggle_todo = ",t",
      org_change_priority = ",p",
      org_deadline = ",d",
      org_schedule = ",s",
      org_set_tags = ",,",
    },
  },
})
