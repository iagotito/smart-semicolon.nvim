# smart-semicolon.nvim

A plugin to place semicolons at the end of the line if writing at the
end of some function.

For example, at the following situation:

```
print("Hello, World!|")
```

Where `|` is the cursor, typing a semicolon will result in:

```
print("Hello, World!");|
```

If you intend to put the semicolon at the end of the string, type
`Ctrl-h` to revert the smart placement action:

```
print("Hello, World!|")
# ;
print("Hello, World!");|
# Ctrl-h
print("Hello, World!;|")
```
