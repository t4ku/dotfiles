#!/bin/bash

panes=`tmux list-panes -F "#{session_name},#{window_index},#{pane_title},#{window_layout},#{pane_active}" | tr '\n' ' '`

pane_cnt=0

for pane in ${panes[@]}
do
    pane_cnt=`expr $pane_cnt + 1`

    # figure out active pane
    pane_info=( `echo "$pane" | tr ',' ' ' ` )

    if [ "${pane_info[4]}" = 1 ]
    then
        ses_id=${pane_info[0]}
        win_idx=${pane_info[1]}
        title=${pane_info[2]}
        layout=${window_layout[3]}
    fi
done

# zoomed pane?

#if [ "$title" = "zoom" ]; then
#
#fi

echo "$layout"
if [[ $pane_cnt -gt 1 ]];then
   #`tmux break-pane`
   echo "break"
fi

#echo $ses_id
#echo $win_idx
#echo $pane_title

#pane_cnt=0
#for pane in $(echo $panes |tr " " "\n")
#do
# pane_cnt=`expr $pane_cnt + 1`
#done
#
#echo $pane_cnt

#echo ${panes_ary[1]}
