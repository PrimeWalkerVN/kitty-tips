# Fish shell completions for kitty-tips
# https://fishshell.com/docs/current/completions.html
#
# Installation:
#   Copy this file to ~/.config/fish/completions/kitty-tips.fish
#   or symlink it:
#     ln -s (pwd)/kitty-tips.fish ~/.config/fish/completions/kitty-tips.fish

# Disable file completions globally for kitty-tips since
# none of the subcommands operate on filesystem paths.
complete -c kitty-tips -f

# ---------------------------------------------------------------------------
# Main subcommands (offered only when no subcommand has been typed yet)
# ---------------------------------------------------------------------------
complete -c kitty-tips -n "__fish_use_subcommand" -a "random"     -d "Show a random tip"
complete -c kitty-tips -n "__fish_use_subcommand" -a "daily"      -d "Show tip of the day"
complete -c kitty-tips -n "__fish_use_subcommand" -a "search"     -d "Search tips by keyword"
complete -c kitty-tips -n "__fish_use_subcommand" -a "list"       -d "List all tips"
complete -c kitty-tips -n "__fish_use_subcommand" -a "categories" -d "Show all categories with counts"
complete -c kitty-tips -n "__fish_use_subcommand" -a "bookmark"   -d "Manage bookmarks"
complete -c kitty-tips -n "__fish_use_subcommand" -a "whatsnew"   -d "Show what's new in the latest Kitty release"

# ---------------------------------------------------------------------------
# Global flags (available at the top level before any subcommand)
# ---------------------------------------------------------------------------
complete -c kitty-tips -n "__fish_use_subcommand" -s h -l help    -d "Show help"
complete -c kitty-tips -n "__fish_use_subcommand" -s v -l version -d "Show version"

# ---------------------------------------------------------------------------
# list subcommand: -c <CATEGORY> flag
# ---------------------------------------------------------------------------
complete -c kitty-tips -n "__fish_seen_subcommand_from list" -s c -d "Filter by category" \
    -xa "Shortcuts Config Appearance Layouts Advanced Performance Integration"

# ---------------------------------------------------------------------------
# bookmark subcommands: add, rm, list
# ---------------------------------------------------------------------------
complete -c kitty-tips -n "__fish_seen_subcommand_from bookmark; and not __fish_seen_subcommand_from add rm list" \
    -a "add"  -d "Add a bookmark by tip ID"
complete -c kitty-tips -n "__fish_seen_subcommand_from bookmark; and not __fish_seen_subcommand_from add rm list" \
    -a "rm"   -d "Remove a bookmark by tip ID"
complete -c kitty-tips -n "__fish_seen_subcommand_from bookmark; and not __fish_seen_subcommand_from add rm list" \
    -a "list" -d "List all bookmarks"
