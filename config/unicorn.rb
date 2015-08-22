# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/opt/app"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/run/unicorn.pid"

stderr_path "/opt/app/log/unicorn.log"
stdout_path "/opt/app/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.[app name].sock"
listen "/tmp/unicorn.myapp.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30