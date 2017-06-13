#!/bin/bash

#
# (c) Liviu Balan <liv_romania@yahoo.com>
# http://www.liviubalan.com/
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

# Escape string used in sed command (search term).
# For more info see:
# https://robots.thoughtbot.com/sed-102-replace-in-place
# http://unix.stackexchange.com/questions/32907/what-characters-do-i-need-to-escape-when-using-sed-in-a-sh-script
# $1 = The value being searched for, otherwise known as the needle
function liv_sed_escape_search {
    local LIV_TMP="$1"

    # Replace "\" first
    # "\" => "\\"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\\/\\\\/g')

    # "^" => "\^"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\^/\\^/g')

    # "." => "\."
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\./\\./g')

    # "*" => "\*"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\*/\\*/g')

    # "[" => "\["
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\[/\\[/g')

    # "]" => "\]"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\]/\\]/g')

    # "/" => "\/"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\//\\\//g')

    # "$" => "\$"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\$/\\$/g')

    echo "$LIV_TMP"
}

# Escape string used in sed command (replace term).
# In order to avoid problems do not use empty new lines.
# $1 = The replacement value that replaces found search values
function liv_sed_escape_replace {
    local LIV_TMP="$1"

    # Replace "\" first
    # "\" => "\\"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\\/\\\\/g')

    # "/" => "\/"
    LIV_TMP=$(echo "$LIV_TMP" | sed 's/\//\\\//g')

    # "\n" => "\\n"
    # For more info see http://stackoverflow.com/questions/1251999/how-can-i-replace-a-newline-n-using-sed
    LIV_TMP=$(echo "$LIV_TMP" | sed ':a;N;$!ba;s/\n/\\n/g')

    echo "$LIV_TMP"
}

# Replace $1 (search string) with $2 (replace string) on the starting of the string.
# $1 and $2 are escaped so you cannot use patterns inside of them.
# In order to avoid problems the pattern ^$LIV_TMP_SEARCH is used so $1 should contain the beginning of the pattern.
# In order to avoid problems avoid using extra new lines before and after the actual text.
# For more info see https://www.digitalocean.com/community/tutorials/the-basics-of-using-the-sed-stream-editor-to-manipulate-text-in-linux
# $1 = Search string
# $2 = Replace string
function liv_sed_replace_start {
    local LIV_TMP_SEARCH=$(liv_sed_escape_search "$1")
    local LIV_TMP_REPLACE=$(liv_sed_escape_replace "$2")

    sed "s/^$LIV_TMP_SEARCH/$LIV_TMP_REPLACE/g"
}

# Replace $1 (search string) with $2 (replace string) on the end of the string.
# $1 and $2 are escaped so you cannot use patterns inside of them.
# In order to avoid problems the pattern ^$LIV_TMP_SEARCH is used so $1 should contain the beginning of the pattern.
# In order to avoid problems avoid using extra new lines before and after the actual text.
# For more info see https://www.digitalocean.com/community/tutorials/the-basics-of-using-the-sed-stream-editor-to-manipulate-text-in-linux
# $1 = Search string
# $2 = Replace string
function liv_sed_replace_end {
    local LIV_TMP_SEARCH=$(liv_sed_escape_search "$1")
    local LIV_TMP_REPLACE=$(liv_sed_escape_replace "$2")

    sed "s/$LIV_TMP_SEARCH\$/$LIV_TMP_REPLACE/g"
}

# Print with color and return to the default config foreground color
# $1 = Message
# $2 = Message color. Default to $LIV_COLOR_DEFAULT
# $3 = Status message
# $4 = Status color. Default to $LIV_COLOR_DEFAULT
# Usage:
# liv_print_color 'Message'
# liv_print_color 'Message' '\e[32m'
# liv_print_color 'Message' '\e[39m' 'DONE'
# liv_print_color 'Message' '\e[39m' 'DONE' '\e[32m'
function liv_print_color {
    if [ "$#" -gt 0 ]; then
        local LIV_MESSAGE="$1"
        local LIV_MESSAGE_COLOR="$LIV_COLOR_DEFAULT"
        local LIV_MESSAGE_STATUS=''
        local LIV_STATUS=''
        local LIV_STATUS_COLOR="$LIV_COLOR_DEFAULT"

        if [ ! -z "$2" ]; then
            LIV_MESSAGE_COLOR="$2"
            if [ ! -z "$3" ]; then
                LIV_STATUS="$3"
                if [ ! -z "$4" ]; then
                    LIV_STATUS_COLOR="$4"
                fi
                LIV_MESSAGE_STATUS="$LIV_MESSAGE_COLOR[$LIV_STATUS_COLOR$LIV_STATUS$LIV_MESSAGE_COLOR] "
            fi
        fi

        echo -e "$LIV_MESSAGE_STATUS$LIV_MESSAGE_COLOR$LIV_MESSAGE$LIV_COLOR_DEFAULT"
    fi
}

# Print default message
# $1 = Message
# $2 = Status message
# Usage:
# liv_print_default 'Message'
# liv_print_default 'Message' 'DONE'
function liv_print_default {
    liv_print_color "$1" "$LIV_COLOR_DEFAULT" "$2" "$LIV_COLOR_DEFAULT"
}

# Print success message
# $1 = Message
# $2 = Status message
# Usage:
# liv_print_success 'Message'
# liv_print_success 'Message' 'DONE'
function liv_print_success {
    liv_print_color "$1" "$LIV_COLOR_DEFAULT" "$2" "$LIV_COLOR_SUCCESS"
}

# Print info message
# $1 = Message
# $2 = Status message
# Usage:
# liv_print_info 'Message'
# liv_print_info 'Message' 'INFO'
function liv_print_info {
    liv_print_color "$1" "$LIV_COLOR_DEFAULT" "$2" "$LIV_COLOR_INFO"
}

# Print warning message
# $1 = Message
# $2 = Status message
# Usage:
# liv_print_warning 'Message'
# liv_print_warning 'Message' 'WARNING'
function liv_print_warning {
    liv_print_color "$1" "$LIV_COLOR_DEFAULT" "$2" "$LIV_COLOR_WARNING"
}

# Print danger message
# $1 = Message
# $2 = Status message
# Usage:
# liv_print_danger 'Message'
# liv_print_danger 'Message' 'FAILED'
function liv_print_danger {
    liv_print_color "$1" "$LIV_COLOR_DEFAULT" "$2" "$LIV_COLOR_DANGER"
}

# Recursively create directories and files.
# $1 = input_dir
# $2 = input_dir_c
# $3 = input_extension
# $4 = output_dir
# $5 = output_extension
function liv_recurse() {
    local input_dir="$1"
    local input_dir_c="$2"
    local input_extension="$3"
    local output_dir="$4"
    local output_extension="$5"

    for i in "$input_dir_c"/*; do
        if [ -d "$i" ]; then
            local output_dir_c=$(echo "$i" | liv_sed_replace_start "$input_dir" '')
            output_dir_c="$output_dir$output_dir_c"

            if [ ! -d "$output_dir_c" ]; then
                mkdir "$output_dir_c"
                echo "dir: $i created"
            fi

            liv_recurse "$input_dir" "$i" "$input_extension" "$output_dir" "$output_extension"
        elif [ -f "$i" ]; then
            local filename_c=$(basename "$i")
            local extension_c="${filename_c##*.}"

            if [ "${extension_c,,}" == "$input_extension" ]; then
                local output_file_c=$(echo "$i" | liv_sed_replace_start "$input_dir" '')
                output_file_c=$(echo "$output_file_c" | liv_sed_replace_end "$input_extension" "$output_extension")
                output_file_c="$output_dir$output_file_c"

                # WinFF format
                echo -e "\e[32mOK\e[0m: $output_file_c"
                ffmpeg -i "$i" -acodec libmp3lame -b:a 160k -ac 2 -ar 44100 "$output_file_c" > /dev/null 2>&1
            else
                echo -e "\033[31mEXCLUDED\e[0m: $i"
            fi
        fi
    done
}
