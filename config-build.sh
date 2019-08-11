#!/bin/bash

getns() {
  cd namespaces;
  for i in $(kubectl get ns |grep -v NAME|awk '{print $1}')
  do
    echo "kubectl get ns $i -o yaml >$i.yaml"
    kubectl get ns $i -o yaml >$i.yaml
  done
  cd ..
}

getdep() {
  cd deployments;
  for n in $(kubectl get ns |grep -v NAME|awk '{print $1}')
  do
    mkdir $n;cd $n
    for d in $(kubectl get deployments --namespace=$n | grep -v READY | awk '{print $1}' )
    do
      echo "kubectl get deployment $d --namespace=$n -o yaml > $d.yaml"
      kubectl get deployment $d --namespace=$n -o yaml > $d.yaml
    done
    cd ..
  done
  cd ..
}

getsvc(){
  cd services;
  for n in $(kubectl get ns |grep -v NAME|awk '{print $1}')
  do
    mkdir $n;cd $n
    for d in $(kubectl get svc --namespace=$n | grep -v NAME | awk '{print $1}' )
    do
      echo "kubectl get svc $d --namespace=$n -o yaml > $d.yaml"
      kubectl get deployment $d --namespace=$n -o yaml > $d.yaml
    done
    cd ..
  done
  cd ..
}

getns
getdep
# getsvc
