# function to create a new directory and open it in VS Code
new_directory() {
  mkdir "$1"
  cd "$1"
  code .
}

#Removes duplicated lines from the history file
history_cleanup() {
  today=$(date "+%Y-%m-%d")
  last_cleaned=$(head -n 1 ~/.last_history_cleanup 2>/dev/null || echo "never")

  if [ "$today" != "$last_cleaned" ]; then
    echo "Cleaning up history file ..."
    awk '!a[$0]++' ~/.zsh_history >/tmp/temp && mv /tmp/temp ~/.zsh_history
    echo $today >~/.last_history_cleanup
  fi
}

preexec() { echo; }

# Define functions for prettier and editorConfig
prettier() {
  echo "{
\"narrowParens\": \"always\",
\"bracketSpacing\": true,
\"endOfLine\": \"auto\",
\"printWidth\": 70,
\"semi\": true,
\"singleQuote\": true,
\"tabWidth\": 2,
\"trailingComma\": \"all\",
\"useTabs\": false
}" >.prettierrc
}

editorConfig() {
  echo "root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true" >.editorconfig
}

# Combine them into a single command
pc() {
  prettier
  editorConfig
}
