TARGET=${1}
DRYRUN=${2}

[[ -z ${TARGET} ]] && echo -e "Please specify the deploy target:\nAniSong: mympd01\nEngSong: mympd02\nclassic: mympd03" && exit 0;
[[ ! -z ${DRYRUN} && ${DRYRUN} != "--dryrun" ]] && echo -e "The 2nd arg should be empty or --dryrun" && exit 0;
[[ "${TARGET}" != "mympd01" && \
   "${TARGET}" != "mympd02" && \
   "${TARGET}" != "mympd03" ]] && echo -e "Please specify the deploy target:\nAniSong: mympd01\nEngSong: mympd02\nclassic: mympd03" && exit 0;
COMPOSE_NAME="docker-compose-${TARGET}.yaml"

TMP_COMPOSE=`echo -e "version: \"3.8\"" && docker-compose -f <(cat docker-compose-mympd-base.yaml ${COMPOSE_NAME} | sed "s|-\ \./|-\ $(pwd)/|g") config`
TMP_COMPOSE=`echo -e "${TMP_COMPOSE}" | sed "s|^\ *name:.*||g"`
TMP_COMPOSE=`echo -e "${TMP_COMPOSE}" | sed "s|version:\ '3'||g"`

[[ ! -z ${DRYRUN} ]] && echo -e "DRYRUN......\n\n${TMP_COMPOSE}" && exit 0;
#echo -E "${TMP}"
docker stack deploy --compose-file <(echo -e "${TMP_COMPOSE}") ${TARGET}


