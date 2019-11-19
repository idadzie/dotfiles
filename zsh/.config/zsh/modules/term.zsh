#
# Terminal emulator
#

export TERM_PROGRAM
if islinux && (( $PPID > 0 )); then
  TERM_PROGRAM=$(ps -fo cmd -hwcp $PPID)
  [[ ${TERM_PROGRAM[-1]} == '-' ]] && TERM_PROGRAM=${TERM_PROGRAM[0,-2]}
elif cat /proc/1/cgroup | grep docker -qa; then
  TERM_PROGRAM="docker"
fi
