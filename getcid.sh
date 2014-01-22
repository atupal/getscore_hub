#!/usr/bin/env bash

function get_params() {
  query_action='http://bksjw.hust.edu.cn/aam/score/QueryScoreByStudent_queryScore.action'
  cookie='JSESSIONID=0000ggPFhh6lz9sU7xOpPcQndWE:167ihbktf'
  referer='http://bksjw.hust.edu.cn/aam/score/QueryScoreByStudent_readyToQuery.action?cdbh=225'
  data='key1=395439&key2=80532e8924f45e5300ab16272935b2e0&type=cj&stuSfid=U201110090&xqselect=20131'
  
  curl "$query_action"  --data "$data" --cookie "$cookie" --referer "$referer" > out  2>/dev/null
  
  cat out                                                    | 
  grep "action=18"                                           |
  grep -Eio "reportParamsId=[0-9]+|cachedid=A_[0-9]+"        | 
  awk '{ split($1, a, "="); printf a[2] " " }'               |
  grep -Eo '[0-9]+'                                          |
  awk '{ printf $1 " " }'
}

while [[ 1 ]]; do
  get_params
  echo
  sleep 180
done

for i in `seq 1 40`; do
  get_params
  echo 
done
