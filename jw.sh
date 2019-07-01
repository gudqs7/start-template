AUTHOR=$1
N_DATE=$2

if [ $# -eq 0 ] 
then 
  AUTHOR='gudqs7'
fi

if [ $# -le 1 ] 
then
  N_DATE='2018-06-11'
  N_DATE=`date -v-1d -v-fri +"%Y-%m-%d" `
fi


git lw | grep $AUTHOR | awk -F'--' '{if( $1 >= "'$N_DATE'" ) { print $1 " " $2 } }' |awk '!a[$0]++{print}' | egrep -v "(Merge*)"

#git config --global alias.lw "log --pretty=format:'%cd--%s--%an--%h' --date=format:%Y-%m-%d"
