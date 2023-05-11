# re-ophase contributing guide

## Issues

## Pull-Requests

## Database Migrations

## Tests

## Documentation

## `TODO`-Tags

Tag | Meaning
:---: | :---
`BUG`            | here is something wrong
`HACK`           | here is something hacked together and needs to be cleaned up, but it's working
`FIXME`          | here is something that needs urgent attention
`TODO` / `todo!` | here is something to do
`XXX`            | here is something that needs attention
`[ ]`            | this is an open task / goal / etc
`[x]`            | this is a completed task / goal / etc
`TODOC`          | here is something that needs documentation
`VERIFY`         | here is something that might be wrong and needs to be verified

#### Example Config for VSCode "ToDo Tree" Extension

```json
"todo-tree.highlights.useColourScheme": true,
    "todo-tree.highlights.defaultHighlight": {
        "gutterIcon": true,
        "type": "text-and-comment",
    },
    "todo-tree.general.tags": [
        "BUG",
        "HACK",
        "FIXME",
        "TODO",
        "XXX",
        "[ ]",
        "[x]",
        "todo!",
        "TODOC",
        "VERIFY",
    ],
    "todo-tree.highlights.backgroundColourScheme": [
        "red",
        "orange",
        "yellow",
        "darkolivegreen",
        "blue",
        "darkmagenta",
        "green",
        "green",
        "steelblue",
        "forestgreen",
    ],
    "todo-tree.highlights.foregroundColourScheme": [
        "white",
        "black",
        "black",
        "white",
        "white",
        "white",
        "white",
        "white",
        "white",
        "white",
    ],
    "todo-tree.highlights.customHighlight": {
        "TODOC": {
            "icon": "book"
        },
        "TODO": {
            "icon": "pencil"
        },
        "VERIFY": {
            "icon": "search"
        }
    },
    "todo-tree.general.tagGroups": {
        "TODO": [
            "TODO",
            "todo!",
        ]
    }
```
 