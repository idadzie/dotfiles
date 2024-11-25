#
# Init
#

EXCLUDE_USERS=("postgres" "nginx" "www-data")
if [[ " ${EXCLUDE_USERS[@]} " =~ " ${USER} " ]]; then
  return 1
fi

