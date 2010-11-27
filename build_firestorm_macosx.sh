#!/bin/bash

###
### Constants
###

TRUE=0 # Map the shell's idea of truth to a variable for better documentation
FALSE=1
LOG="`pwd`/logs/build_macosx.log"

###
### Global Variables
###

WANTS_CLEAN=$FALSE
WANTS_CONFIG=$FALSE
WANTS_BUILD=$FALSE
WANTS_PACKAGE=$FALSE
WANTS_VERSION=$FALSE
BTYPE="Release"
CHANNEL="private-`hostname`"

###
### Helper Functions
###

showUsage()
{
        echo
        echo "Usage: "
        echo "========================"
        echo
        echo "  --clean     : Remove past builds & configuration"
        echo "  --config    : General a new architecture-specific config"
        echo "  --version   : Update version number"
        echo "  --rebuild   : Build, reusing unchanged projects to save time"
        echo "  --chan [Release|Beta|Private] : Private is the default, sets channel"
        echo "  --btype [Release|RelWithDebInfo] : Release is default, whether to use symbols"
}

getArgs()
# $* = the options passed in from main
{
        if [ $# -eq 0 ] ; then
              WANTS_CLEAN=$TRUE
              WANTS_CONFIG=$TRUE
              WANTS_BUILD=$TRUE
              WANTS_VERSION=$TRUE
              WANTS_PACKAGE=$TRUE
              return
        fi
        
        while getoptex "clean config version rebuild help chan: btype:" "$@" ; do
        
            case "$OPTOPT" in
            clean)    WANTS_CLEAN=$TRUE;;
            config)   WANTS_CONFIG=$TRUE;;
            version)  WANTS_VERSION=$TRUE;;
            rebuild)  WANTS_BUILD=$TRUE
                      WANTS_VERSION=$TRUE
                      WANTS_PACKAGE=$TRUE;;
            chan)     CHANNEL="$OPTARG";;
            btype)    BTYPE="$OPTARG";;
            
            help)     showUsage && exit 0;;
            
            -*)       showUsage && exit 1;;
            *)        showUsage && exit 1;;            
            esac
        done
        shift $[OPTIND-1]
        if [ $OPTIND -le 1 ] ; then
            showUsage && exit 1
        fi
}


function getoptex()
{
  let $# || return 1
  local optlist="${1#;}"
  let OPTIND || OPTIND=1
  [ $OPTIND -lt $# ] || return 1
  shift $OPTIND
  if [ "$1" != "-" -a "$1" != "${1#-}" ]
  then OPTIND=$[OPTIND+1]; if [ "$1" != "--" ]
  then
        local o
        o="-${1#-$OPTOFS}"
        for opt in ${optlist#;}
        do
          OPTOPT="${opt%[;.:]}"
          unset OPTARG
          local opttype="${opt##*[^;:.]}"
          [ -z "$opttype" ] && opttype=";"
          if [ ${#OPTOPT} -gt 1 ]
          then # long-named option
                case $o in
                  "--$OPTOPT")
                        if [ "$opttype" != ":" ]; then return 0; fi
                        OPTARG="$2"
                        if [ -z "$OPTARG" ];
                        then # error: must have an agrument
                          let OPTERR && echo "$0: error: $OPTOPT must have an argument" >&2
                          OPTARG="$OPTOPT";
                          OPTOPT="?"
                          return 1;
                        fi
                        OPTIND=$[OPTIND+1] # skip option's argument
                        return 0
                  ;;
                  "--$OPTOPT="*)
                        if [ "$opttype" = ";" ];
                        then  # error: must not have arguments
                          let OPTERR && echo "$0: error: $OPTOPT must not have arguments" >&2
                          OPTARG="$OPTOPT"
                          OPTOPT="?"
                          return 1
                        fi
                        OPTARG=${o#"--$OPTOPT="}
                        return 0
                  ;;
                esac
          else # short-named option
                case "$o" in
                  "-$OPTOPT")
                        unset OPTOFS
                        [ "$opttype" != ":" ] && return 0
                        OPTARG="$2"
                        if [ -z "$OPTARG" ]
                        then
                          echo "$0: error: -$OPTOPT must have an argument" >&2
                          OPTARG="$OPTOPT"
                          OPTOPT="?"
                          return 1
                        fi
                        OPTIND=$[OPTIND+1] # skip option's argument
                        return 0
                  ;;
                  "-$OPTOPT"*)
                        if [ $opttype = ";" ]
                        then # an option with no argument is in a chain of options
                          OPTOFS="$OPTOFS?" # move to the next option in the chain
                          OPTIND=$[OPTIND-1] # the chain still has other options
                          return 0
                        else
                          unset OPTOFS
                          OPTARG="${o#-$OPTOPT}"
                          return 0
                        fi
                  ;;
                esac
          fi
        done
        echo "$0: error: invalid option: $o"
  fi; fi
  OPTOPT="?"
  unset OPTARG
  return 1
}

function optlistex
{
  local l="$1"
  local m # mask
  local r # to store result
  while [ ${#m} -lt $[${#l}-1] ]; do m="$m?"; done # create a "???..." mask
  while [ -n "$l" ]
  do
        r="${r:+"$r "}${l%$m}" # append the first character of $l to $r
        l="${l#?}" # cut the first charecter from $l
        m="${m#?}"  # cut one "?" sign from m
        if [ -n "${l%%[^:.;]*}" ]
        then # a special character (";", ".", or ":") was found
          r="$r${l%$m}" # append it to $r
          l="${l#?}" # cut the special character from l
          m="${m#?}"  # cut one more "?" sign
        fi
  done
  echo $r
}

function getopt()
{
  local optlist=`optlistex "$1"`
  shift
  getoptex "$optlist" "$@"
  return $?
}


###
###  Main Logic
### 

getArgs $*

if [ ! -d `dirname $LOG` ] ; then
	mkdir -p `dirname $LOG`
fi

pushd indra >/dev/null
if [ $WANTS_CLEAN -eq $TRUE ] ; then
	./develop.py clean
	find . -name "*.pyc" -exec rm {} \;
fi

if [ $WANTS_CONFIG -eq $TRUE ] ; then
	mkdir -p ../logs > /dev/null 2>&1
	./develop.py -t $BTYPE configure -DPACKAGE:BOOL=ON -DLL_TESTS:BOOL=OFF -DVIEWER_CHANNEL:STRING=Firestorm-$CHANNEL -DVIEWER_LOGIN_CHANNEL:STRING=Firestorm-$CHANNEL 2>&1 | tee $LOG
	# LL build wants this directory to exist, but doesn't make it itself.
	mkdir -p ./build-darwin-i386/newview/Release/Firestorm.app
fi

if [ $WANTS_VERSION -eq $TRUE ] ; then
	echo -n "Setting build version to "
        buildVer=`hg summary | head -1 | cut -d " "  -f 2 | cut -d : -f 1`
        echo "$buildVer."
        cp llcommon/llversionviewer.h llcommon/llversionviewer.h.build
        sed -e "s#LL_VERSION_BUILD = .*\$#LL_VERSION_BUILD = ${buildVer};#" \
        	-e "s#LL_CHANNEL = .*\$#LL_CHANNEL = \"Firestorm-$CHANNEL\";#" \
        	llcommon/llversionviewer.h.build > llcommon/llversionviewer.h
fi

if [ $WANTS_BUILD -eq $TRUE ] ; then

	echo "Building in progress. Check $LOG for verbose status."
	# -sdk macosx10.6
	xcodebuild -project build-darwin-i386/SecondLife.xcodeproj \
		-alltargets -configuration $BTYPE GCC_VERSION=4.2 \
		-sdk macosx10.6 GCC_OPTIMIZATION_LEVEL=3 ARCHS=i386 \
		GCC_ENABLE_SSE3_EXTENSIONS=YES 2>&1 | tee $LOG | \
		grep -e "[(make.*Error)|(xcodebuild.*Error)] "
	trap - INT TERM EXIT
	# Save the .h file we built with in case of errors in compile.
	# Except during the build process, the .h file should ALWAYS be the
	# same as existed in the source repository to avoid merge conflicts
	# during updates.
	mv llcommon/llversionviewer.h llcommon/llversionviewer.h.built
	mv llcommon/llversionviewer.h.build llcommon/llversionviewer.h
	echo "Complete."
fi
popd > /dev/null
