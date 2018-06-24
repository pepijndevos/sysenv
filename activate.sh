ENVNAME=env
CHROOTDIR=$ENVNAME/chroot
WORKDIR=$ENVNAME/work
ENVDIR=$ENVNAME/overlay

for dir in /* ; do
  if [[ -d $dir ]]; then
    mkdir -p $CHROOTDIR$dir
    mkdir -p $WORKDIR$dir
    mkdir -p $ENVDIR$dir
    case $dir in
      /proc|/dev|/sys|/home)
        mount --rbind $dir $CHROOTDIR$dir
        mount --make-rslave $CHROOTDIR$dir
        ;;
      *)
        mount -t overlay overlay -o lowerdir=$dir,upperdir=$ENVDIR$dir,workdir=$WORKDIR$dir $CHROOTDIR$dir
        ;;
    esac
  fi
done

echo $ENVNAME > $CHROOTDIR/etc/debian_chroot

chroot --userspec=`logname` $CHROOTDIR sh -c "cd $(pwd); bash -il"

umount -R $CHROOTDIR/*
