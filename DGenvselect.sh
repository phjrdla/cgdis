PS1="
`hostname`-\${PWD}
>"

DG_SCRIPTS=/home/oracle/scripts
export DG_SCRIPTS
alias cdscr="cd $DG_SCRIPTS"
alias snv="env | sort"

##################### to setup properly ORACLE_HOME ###########################################

typeset -u selection
while :
do
    clear
    echo "CGDIS databases on $(hostname)"
    echo "---------------------------------------------"
    echo "1) COSWARE    "
    echo "2) COSWARETEST"
    echo "3) SIASELAN   "
    echo "4) SECUR      "
    echo "---------------------------------------------"
    echo "r) Refresh screen"
    echo "q) Quit"
    echo
    echo "Enter your selection: "
    read selection
    if [[ -z "$selection" ]]
        then selection=r
    fi

    case $selection in
        1)  ORACLE_SID='COSWARE'
            break
            ;;
        2)  ORACLE_SID='COSWARETEST'
            break
            ;;
        3)  ORACLE_SID='SIASELAN'
            break
            ;;
        4)  ORACLE_SID='SECUR'
            break
            ;;
      r|R)  continue
            ;;
      q|Q)  echo
            break
            ;;
        *)  echo "Invalid selection"
            sleep 1
            ;;
    esac
done

if [[ $selection = 'Q'  ]] 
then
  Echo 'No selection performed'
else
  ### Sets up Oracle environment variables for selected database
  ORAENV_ASK=NO
  . oraenv
  echo "Using $ORACLE_HOME binaries"

  # Linux prompt
  PS1="
`hostname`*\${ORACLE_SID}-\${PWD}
>"

  # Define location for SQL*NET files
  TNS_ADMIN=$ORACLE_HOME/network/admin
  export TNS_ADMIN

  # For java
  CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
  export CLASSPATH

  # A few useful aliases
  alias cdoh="cd $ORACLE_HOME"
  alias cddbs="cd $ORACLE_HOME/dbs"
  alias cdtns="cd $TNS_ADMIN"
  alias cdadm="cd $ORACLE_BASE/admin"
  alias cddia="cd $ORACLE_BASE/diag/rdbms"

  # For alert logs
  alias tlog-coswarec1="tail -50f $ORACLE_BASE/diag/rdbms/coswarec1/COSWARE/trace/alert_COSWARE.log"
  alias vlog-coswarec1="view $ORACLE_BASE/diag/rdbms/coswarec1/COSWARE/trace/alert_COSWARE.log"

fi

