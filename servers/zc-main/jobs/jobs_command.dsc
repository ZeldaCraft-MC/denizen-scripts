jobs_command:
  type: command
  description: Opens the jobs menu
  usage: /jobs
  name: jobs
  permission: zc.jobs
  script:
    - inventory open d:jobs_main_menu
