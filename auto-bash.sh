function define {
  set | awk "/^$1/,/^}/"
}
