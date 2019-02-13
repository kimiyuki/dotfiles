#syndaemon -i 0.5 -R -d
if [ $HOSTNAME == 'mb2' ]; then
  synclient AreaLeftEdge=100 AreaRightEdge=1200
  synclient AreaTopEdge=50 AreaBottomEdge=800
fi
