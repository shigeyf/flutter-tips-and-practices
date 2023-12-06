#!/usr/bin/env bash

_verbose=0
_opterr=0
_feature=""

help() {
  echo "Usage: `basename $0` [-v] [-f <value>] [--feature[=]<value>]" >&2
}

optspec=":fhv-:"
while getopts "$optspec" optchar; do
  case "${optchar}" in
    -)
      case "${OPTARG}" in
        feature)
          val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
          echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
          _feature=${val}
          ;;
        feature=*)
          val=${OPTARG#*=}
          opt=${OPTARG%=$val}
          echo "Parsing option: '--${opt}', value: '${val}'" >&2
          _feature=${val}
          ;;
        *)
          if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
            echo "Unknown option --${OPTARG}" >&2
          fi
          _opterr=1
          ;;
      esac;;
    f)
      val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
      echo "Parsing option: '-${optchar}', value: '${val}'" >&2;
      _feature=${val}
      ;;
    h)
      help
      exit 1
      ;;
    v)
      echo "Parsing option: '-${optchar}'" >&2
      _verbose=1
      ;;
    *)
      if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
          echo "Non-option argument: '-${OPTARG}'" >&2
      fi
      _opterr=1
      ;;
  esac
done

if [ "${_opterr}" == "1" ]; then
  help
  exit 2
fi

if [ -f ${PWD}/lib/main.dart ]; then
  _project_top_dir=${PWD}
  _lib=${_project_top_dir}/lib
  dirs="src src/app src/app/configs src/app/localization src/app/pages src/app/themes src/app/widgets src/dependencies src/features"
  for d in ${dirs}; do
    mkdir -p ${_lib}/${d}
    touch ${_lib}/${d}/.gitkeep
    [ "${_verbose}" == "1" ] && echo "Created directory: ${d}..."
  done

  if [ "x${_feature}" != "x" ]; then
    _fdir=${_lib}/src/features/${_feature}
    fdirs="application data data/repositories domain domain/models domain/repositories presentation presentation/controllers presentation/views presentation/widgets"
    for fd in ${fdirs}; do
      mkdir -p ${_fdir}/${fd}
      touch ${_fdir}/${fd}/.gitkeep
      [ "${_verbose}" == "1" ] && echo "Created directory: src/features/${_feature}/${fd}"
    done
  fi
fi
