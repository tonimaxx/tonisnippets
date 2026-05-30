# ~/.zsh_functions
# Custom shell functions managed by the shellman skill.
# Add a "# description: ..." line above each function for /shellman list.

# Internal filter for Claude MCP servers
_mcp_filter="mcp-server|alpaca-mcp|context7-mcp|supabase-mcp|hermes-agent"

# description: List running dev servers (Expo, Node, Python, ports). Use --all to include MCP servers.
auditdev() {
  local show_mcp=0
  [[ "$1" == "--all" || "$1" == "-a" ]] && show_mcp=1

  echo "\n=== Expo / Metro ==="
  local found=$(ps aux | grep -E "expo|metro" | grep -v grep | grep -v "/Applications/")
  [[ -z "$found" ]] && echo "  none" || echo "$found" | awk '{printf "  PID %-8s %s\n", $2, $11}'

  echo "\n=== Node Dev Servers ==="
  local node_filter="\bnode\b|nodemon|ts-node"
  local found
  if [[ $show_mcp -eq 1 ]]; then
    found=$(ps aux | grep -E "$node_filter" | grep -v grep | grep -v "/Applications/" | grep -v "vscode" | grep -v "esbuild")
  else
    found=$(ps aux | grep -E "$node_filter" | grep -v grep | grep -v "/Applications/" | grep -v "vscode" | grep -v "esbuild" | grep -vE "$_mcp_filter")
  fi
  if [[ -z "$found" ]]; then
    echo "  none"
  else
    echo "$found" | awk '{cmd=""; for(i=11;i<=NF&&i<=13;i++) cmd=cmd" "$i; printf "  PID %-8s %s\n", $2, cmd}'
  fi

  echo "\n=== Python Dev Servers ==="
  local py_filter="\bpython[3]?\b|uvicorn|flask|gunicorn|django|fastapi"
  local found
  if [[ $show_mcp -eq 1 ]]; then
    found=$(ps aux | grep -E "$py_filter" | grep -v grep | grep -v "/Applications/" | grep -v "vscode")
  else
    found=$(ps aux | grep -E "$py_filter" | grep -v grep | grep -v "/Applications/" | grep -v "vscode" | grep -vE "$_mcp_filter")
  fi
  [[ -z "$found" ]] && echo "  none" || echo "$found" | awk '{printf "  PID %-8s %s %s %s\n", $2, $11, $12, $13}'

  echo "\n=== Dev Ports In Use ==="
  local safe_ports=(3000 3001 4000 4200 5173 8000 8080 8081 8888 9000 19000 19001)
  local hit=0
  for port in $safe_ports; do
    local pid=$(lsof -ti :$port 2>/dev/null | head -1)
    if [[ -n "$pid" ]]; then
      local fullcmd=$(ps -p $pid -o args= 2>/dev/null | cut -c1-60)
      echo "  :$port  PID $pid  → $fullcmd"
      hit=1
    fi
  done
  [[ $hit -eq 0 ]] && echo "  none"

  if [[ $show_mcp -eq 0 ]]; then
    local mcp_count=$(ps aux | grep -E "$_mcp_filter" | grep -v grep | wc -l | tr -d ' ')
    [[ $mcp_count -gt 0 ]] && echo "\n  (${mcp_count} MCP server(s) hidden — run 'auditdev --all' to show)"
  fi
  echo ""
}

# description: List Claude Code MCP background servers with PID and count.
auditmcp() {
  echo "\n=== Claude MCP Servers ==="
  echo "  (spawned by Claude Code — safe to leave, accumulate across sessions)"
  local found=$(ps aux | grep -E "mcp-server|alpaca-mcp|context7-mcp|supabase-mcp|hermes" \
    | grep -v grep \
    | grep -v "vscode")
  if [[ -z "$found" ]]; then
    echo "  none"
  else
    echo "$found" | awk '{
      cmd=""
      for(i=11;i<=NF&&i<=14;i++) cmd=cmd" "$i
      printf "  PID %-8s %s\n", $2, cmd
    }'
    echo ""
    echo "  Count: $(echo "$found" | wc -l | tr -d ' ') processes"
    echo "  To clean up stale ones: restart Claude Code"
  fi
  echo ""
}

# description: Kill all running Expo and Metro bundler processes.
killexpo() {
  local pids=$(ps aux | grep -E "expo|metro" | grep -v grep | awk '{print $2}')
  if [[ -z "$pids" ]]; then
    echo "none running"
  else
    echo "$pids" | xargs kill 2>/dev/null && echo "killed"
  fi
}

# description: Kill all running Node and Nodemon dev server processes.
killnode() {
  local pids=$(ps aux | grep -E "node|nodemon|ts-node" | grep -v grep | awk '{print $2}')
  if [[ -z "$pids" ]]; then
    echo "none running"
  else
    echo "$pids" | xargs kill 2>/dev/null && echo "killed"
  fi
}

# description: Kill whatever process is holding a specific port. Usage: killport <port>
killport() {
  if [[ -z "$1" ]]; then
    echo "Usage: killport <port>"
    return 1
  fi
  local pids=$(lsof -ti :$1)
  if [[ -z "$pids" ]]; then
    echo "nothing on port $1"
  else
    echo "$pids" | xargs kill 2>/dev/null && echo "killed port $1"
  fi
}
