# Filthy
A simple service to check if a string contains foul language.

A response of `true` means you're all clean, `false` means you've got a potty mouth.

## Example
    curl -d "this is a really dirty string" filthy.herokuapp.com
    => true
    curl -d "{'content':'this is a super dirty string'}" filthy.herokuapp.com
    => true
    curl -d "content=this is the dirtiest of strings" filthy.herokuapp.com
    => true


