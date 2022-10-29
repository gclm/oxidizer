##########################################################
# config
##########################################################

# config files
$Global:Element.g = "$HOME\.gitconfig"
# backup files
$Global:Oxide.bkg = "$env:BACKUP\git\.gitconfig"
$Global:Oxide.bkgi = "$env:BACKUP\git\.gitignore"

##########################################################
# main
##########################################################

function gii { git init $args }
function gdf { git diff $args }
function gpl { git pull $args }
function gps { git push $args }
function gst { git status $args }
function gcm { git commit $args }

# ui
function gui { gitui }

# git add
function ga {
    if ([string]::IsNullOrEmpty($args)) { git add . }
    else { git add $args }
}

function gig {
    git rm -rf --cached .
    git add .
    git commit -m "🗑 remove all ignored files"
}

##########################################################
# branch & download
##########################################################

# git clone
# dl: download
function gdl {
    param ( $url, $mode )
    Switch ( $mode ) {
        a { git clone $url }
        Default { git clone --depth 1 $url }
    }
}

##########################################################
# clean
##########################################################

function gf { git filter-repo $args }

# clean files
function gcl {
    Switch ( $args[1] ) {
        s { git filter-repo --strip-blobs-bigger-than $args[2] }
        i { git filter-repo --strip-blobs-with-ids $args[2] }
        p { git filter-repo --invert-paths --path-glob $args[2] }
        a {
            git checkout --orphan new
            git add -A
            git commit -am "🎉 New Start"
            if ([string]::IsNullOrEmpty($args[2])) { $branch = master }
            else { $branch = $args[2] }
            git branch -D $branch
            git branch -m $branch
            git push -f origin $branch
        }
        Default { git repack -a -d --depth=250 --window=250 }
    }
}

function grpb() {
    git remote add origin $args[1]
    if ([string]::IsNullOrEmpty($args[2])) { $branch = master }
    else { $branch = $args[2] }
    git pull $args[1] $branch
    git push --set-upstream origin $branch
}

# list fat files
function gjk {
    param ( $num )
    if ([string]::IsNullOrEmpty($num)) { $number = 10 }
    else { $number = $num }

    git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | Where-Object { $_ -like "blob*" } | Sort-Object { [int]($_ -split "\s+")[2] } | Select-Object -Last $number
}

##########################################################
# tag
##########################################################

function gtrm {
    git tag --delete $args
    git push --delete origin $args
}
