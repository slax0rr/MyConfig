require("orgmode").setup({
  org_agenda_files = { "~/Documents/org/**/*" },
  org_default_notes_file = "~/Documents/org/refile.org",
  org_priority_highest = 'A',
  org_priority_lowest = 'C',
  org_priority_default = 'B',
  org_todo_keywords = {'TODO', '|', 'DONE', 'DELEGATED', 'CANCELLED'},
  org_todo_keyword_faces = {
    DELEGATED = ':slant italic :underline on',
    CANCELLED = ':foreground red :slant italic :weight bold :underline on'
  },

  mappings = {
    global = {
      org_agenda = ",a",
      org_capture = ",c",
    },
    org = {
      org_toggle_checkbox = ",x",
      org_toggle_heading = ",h",
      org_toggle_todo = ",t",
      org_toggle_todo_prev = ",T",

      org_todo = ",t",
      org_todo_prev = ",T",
      org_priority_up = ",p",
      org_priority_down = ",P",
      org_deadline = ",d",
      org_schedule = ",s",
      org_set_tags = ",,",
      org_add_note = ",na",
      org_set_tags_command = ",ot",

      org_agenda_deadline = ",d",
      org_agenda_schedule = ",s",
    },
  },
})
