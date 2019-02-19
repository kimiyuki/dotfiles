echo 'how can I fix this problem????'
#sudo rmmod i2c_hid
#sudo modprobe i2c_hid
echo "$HOSTNAME"
# use "_" by シェルスクリプトシンプルレシピ
if [ "_$HOSTNAME" = "_mb2" ]; then
  echo 'start'
  echo "does not work properly, why?"
  syndaemon -i 0.3 -R -d
  synclient AreaLeftEdge=100 AreaRightEdge=1200
  synclient AreaTopEdge=50 AreaBottomEdge=800
  result=$(synclient -l|grep area.*edge)
  echo "$result"
fi
