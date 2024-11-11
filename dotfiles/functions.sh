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
