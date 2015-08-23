# working_directory "/path/to/your/app"
working_directory "/opt/app"

# pid "/path/to/pids/unicorn.pid"
pid "/opt/app/unicorn.pid"

stderr_path "/opt/app/log/unicorn.log"
stdout_path "/opt/app/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.sample_app.sock"

# Number of processes
worker_processes 2

# Time-out
timeout 30