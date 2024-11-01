#!/usr/bin/env bash
# @K.Dziuba
# Etc Update for Arch-like systems

# source files
for file in `find ./src/*/* -name '*.sh' `; do
    source $file
done

# main function
main() {
    init
    initDiffTool

    printNotice "--- Processing pacsave files ---"
    for file in `$authPrefix find /etc -name '*.pacsave'`; do
        if [[ -f ${file::-8} ]]; then
            # original file exists -> let's see the difference
            processEtcFile $file ${file::-8}
        else
            # original file do not exist -> let's ask for removal
            printWarning "Unused pacsave found: \n${file}."
            askForFileRemoval ${file}
        fi
    done

    printNotice "--- Processing pacnew files ---"
    for file in `$authPrefix find /etc -name '*.pacnew'`; do
        processEtcFile $file ${file::-7}
    done

    # all done
    printSuccess "" "Done!"
}

# Process single file from etc. Run diff-tool app, then ask for removal.
# $1 - a new file that came to /etc (".pacsave" or ".pacnew" file)
# $2 - a current file (a file that is currently in-use and should be updated)
processEtcFile() {
    if [[ -z $1 || ! -f $1 ]]; then
        printError "Fle A -> Not a file! Got: $1"
        exit 2
    fi

    if [[ -z $2 || ! -f $2 ]]; then
        printError "File B -> Not a file! Got: $2"
        exit 2
    fi

    # get params
    newFile=$1
    inUseFile=$2

    # update
    printText "Comparing: "
    printText "> A: $newFile"
    printText "> B: $inUseFile"
    $authPrefix $diffToolApp "$newFile" "$inUseFile"
    checkLastOp

    # ask for removal
    askForFileRemoval ${newFile}
}

# Ask for removal permission. If user approves it -> then (and only then!) remove the file.
# $1 - A file to remove
askForFileRemoval() {
    printText "Remove the file: ${1}? [y/N] "
    read ans
    if [[ $ans == 'y' ]]; then
        printNotice "Removing: ${1}"
        $authPrefix rm ${1}
    fi
}

# check and init diff-tool application
initDiffTool() {
    printText "Using '${diffToolApp}' as diff-tool..."

    if  [[ ! -z ${diffToolApp} ]] && which ${diffToolApp} | read; then
        diffToolApp=$(which ${diffToolApp})
        printText ""
    else
        printError "... '${diffToolApp}' not found!"
        exit 127
    fi    
}

# pre-run function
init() {
    printInfo "[$0] Starting up ..."

    # set up traps
    trap terminate SIGINT SIGTERM ERR 0
}

# post-run / terminate function
terminate() {
    printInfo "[$0] Terminating ..."
    # ( possible post-run actions )
    exit
}
