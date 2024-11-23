#
#  Options
#

# Do not run /etc/{zprofile,zshrc,zlogin,zlogout}.
setopt NO_GLOBAL_RCS

# Exchanges the meanings of '+' and '-' when used
# with a number to specify a directory in the stack.
setopt PUSHD_MINUS

# Don't push multiple copies of the same directory
# onto the directory stack.
setopt PUSHD_IGNORE_DUPS

# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD

# Have pushd with no arguments act like 'pushd $HOME'.
setopt PUSHD_TO_HOME

# Expand expressions in braces which would not otherwise
# undergo brace expansion to a lexically ordered list of
# all the characters i.e. {a-c} becomes a b c.
setopt BRACE_CCL

# Allow the character sequence '''' to signify a single
# quote within singly quoted strings. Note this does not
# apply in quoted strings using the format $'...', where a
# backslashed single quote can be used.
setopt RC_QUOTES

# Perform implicit tees or cats when multiple redirections
# are attempted.
setopt MULTIOS

# No beep.
setopt NO_BEEP
setopt NO_LIST_BEEP
setopt NO_HIST_BEEP

# Expand '=command' as path of command.
# e.g. '=ls' -> '/bin/ls'
setopt EQUALS

# List jobs in the long format by default i.e. show process ID.
setopt LONG_LIST_JOBS

# Recognize comments.
setopt INTERACTIVE_COMMENTS

# When the last character resulting from a completion is a slash
# and the next character typed is a word delimiter, a slash, or
# a character that ends a command (such as a semicolon or an ampersand),
# remove the slash.
setopt AUTO_REMOVE_SLASH

# Append a trailing '/' to all directory names resulting from
# filename generation (globbing).
setopt MARK_DIRS

# Perform case-insensitive globbing.
setopt NO_CASE_GLOB

# Report the status of background jobs immediately.
setopt NOTIFY

# Use '*, ~, ^' as regular expression match without pattern.
# e.g. > rm *~398
# Remove * without a file "398". For test, use "echo *~398".
setopt EXTENDED_GLOB

# Print a warning message if a mail file has been accessed since
# the shell last checked.
setopt MAIL_WARNING

# Do not record an event that was just recorded again.
setopt HIST_IGNORE_DUPS

# Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NODUPS

# Do not display a previously found event.
setopt HIST_FIND_NO_DUPS

# Expire a duplicate event first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST

# Save each command's beginning timestamp and duration.
setopt EXTENDED_HISTORY

# Remove command lines from the history list when the first character
# on the line is a space.
setopt HIST_IGNORE_SPACE

# Remove command of 'history' or 'fc -l' from history list.
setopt HIST_NO_STORE

# Share history.
setopt SHARE_HISTORY

# Remove superfluous blanks from each command line being
# added to the history list.
setopt HIST_REDUCE_BLANKS

# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

# Append to history file.
setopt APPEND_HISTORY

# Edit history file during call history before executing.
setopt HIST_VERIFY

# Remove function definitions from the history list.
setopt HIST_NO_FUNCTIONS

# Do not autoselect the first completion entry.
unsetopt MENU_COMPLETE

# Show completion menu on successive tab press.
setopt AUTO_MENU

# Perform parameter expansion, command substitution
# and arithmetic expansion.
setopt PROMPT_SUBST

# Return to last prompt if no numeric argument is given.
setopt ALWAYS_LAST_PROMPT

# Move cursor to end of word if a single
# match is inserted or menu completion is performed.
setopt ALWAYS_TO_END

# Change directory (cd) if name is a directory and not a command.
setopt AUTO_CD

# Set cursor to the end of the word if completion is started.
setopt COMPLETE_IN_WORD

# Do not require a leading '.' in a filename to be matched explicitly.
setopt GLOB_DOTS

# Show the type of each file with a trailing identifying
# mark When listing files that are possible completions.
setopt LIST_TYPES

# Perform filename expansion on all unquoted
# arguments of the form 'anything=expression'.
setopt MAGIC_EQUAL_SUBST

# Disable start (^S) and stop (^Q) characters.
setopt NO_FLOW_CONTROL
