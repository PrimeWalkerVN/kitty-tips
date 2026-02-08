# Bash completion for kitty-tips
# https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html
#
# Installation:
#   Source this file in your ~/.bashrc or ~/.bash_profile:
#     source /path/to/kitty-tips.bash
#
#   Or copy it to the system completions directory:
#     - Linux:  /etc/bash_completion.d/kitty-tips
#     - macOS:  $(brew --prefix)/etc/bash_completion.d/kitty-tips  (if using brew)

_kitty_tips() {
    local cur prev words cword
    _init_completion || return

    # Top-level subcommands and flags
    local commands="random daily search list categories bookmark whatsnew"
    local global_flags="--help -h --version -v"

    # Category values used by the -c flag on the list subcommand
    local categories="Shortcuts Config Appearance Layouts Advanced Performance Integration"

    # Sub-subcommands for 'bookmark'
    local bookmark_cmds="add rm list"

    # Determine which subcommand (if any) has already been typed.
    # Walk through the words on the command line, skipping the program name.
    local subcmd=""
    local i
    for (( i=1; i < cword; i++ )); do
        case "${words[i]}" in
            random|daily|search|list|categories|bookmark|whatsnew)
                subcmd="${words[i]}"
                break
                ;;
        esac
    done

    # If no subcommand has been seen yet, offer subcommands and global flags.
    if [[ -z "${subcmd}" ]]; then
        COMPREPLY=($(compgen -W "${commands} ${global_flags}" -- "${cur}"))
        return
    fi

    # Subcommand-specific completions
    case "${subcmd}" in
        list)
            # After 'list', offer the -c flag; after -c, offer categories.
            if [[ "${prev}" == "-c" ]]; then
                COMPREPLY=($(compgen -W "${categories}" -- "${cur}"))
            else
                COMPREPLY=($(compgen -W "-c" -- "${cur}"))
            fi
            return
            ;;
        bookmark)
            # After 'bookmark', offer its sub-subcommands (add, rm, list).
            # Only offer them if the immediate previous word is 'bookmark'
            # (i.e., we haven't already chosen a bookmark action).
            if [[ "${prev}" == "bookmark" ]]; then
                COMPREPLY=($(compgen -W "${bookmark_cmds}" -- "${cur}"))
            fi
            return
            ;;
        search)
            # 'search' expects a free-form query -- no completions to offer.
            return
            ;;
        *)
            # random, daily, categories, whatsnew take no further arguments.
            return
            ;;
    esac
}

complete -F _kitty_tips kitty-tips
