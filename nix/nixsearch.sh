#!/usr/bin/env bash
#needs jq and coreutils
#from: https://gist.github.com/olejorgenb/0c3bafa3c7b63d1a2f83ee13582de7b9
nq () {
  local CACHE="$HOME/.cache/nq-cache"
  if ! ( [ -e $CACHE ] && [ $(stat -c %Y $CACHE) -gt $(( $(date +%s) - 3600*24*7 )) ] ); then
      # read gotcha.. can't pipe to read (as usual zsh beats bash)
      read x MEM_AVAIL_KB UNIT < <(grep MemAvailable: /proc/meminfo) 
      if [[ $UNIT != "kB" || $MEM_AVAIL_KB -lt 1000000 ]]; then
          # nix-env can easily use up to 1GB during -qa
          echo "Refusing to update cache due to low memory ($((MEM_AVAIL_KB/1000))MB)" 1>&2
          echo "Searching in old cache" 1>&2
      else
          echo "update cache" 1>&2
          nice nix-env -qa --file "<nixpkgs>" --json > "$CACHE"
      fi
  fi
  jq -r 'to_entries | .[] | .key + "|" + .value.meta.description' < "$CACHE" |
    {
       if [ $# -gt 0 ]; then
          # double grep because coloring breaks column's char count
          # $* so that we include spaces (could do .* instead?)
            grep -i "$*" | column -t -s "|" | grep --color=always -i "$*"
       else
            column -t -s "|"
       fi
    }
}
nq "$@"
