#!/bin/bash

echo -n "What is your name?"
read -p "user name:" user_name

mkdir /home/$user_name/klaytn
mkdir /home/$user_name/klaytn/src/
cd /home/$user_name/klaytn/src/
wget http://packages.klaytn.net/klaytn/v1.4.2/kscn-v1.4.2-0-linux-amd64.tar.gz
tar zxvf kscn-v1.4.2-0-linux-amd64.tar.gz
wget http://packages.klaytn.net/klaytn/v1.4.2/homi-v1.4.2-0-linux-amd64.tar.gz
tar zxvf homi-v1.4.2-0-linux-amd64.tar.gz
cd /home/$user_name/klaytn/src/homi-linux-amd64/bin/
./homi setup local --cn-num 4 --test-num 4 --servicechain --p2p-port 30000 -o homi-output
while : 
do
echo "What is your node address?" 
read -p "first node: "first_node
read -p "second node: " second_node
read -p "third node: " third_node
read -p "forth node: " forth_node

echo -n "Are you sure?(y/n)"
read answer

if [ $answer = n ]; then
	echo "Worng IP"
elif [ $answer = y ]; then
	sed -i "2s/@0.0.0.0/@$first_node/g" /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	sed -i "3s/@0.0.0.0/@$second_node/g" /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	sed -i "4s/@0.0.0.0/@$third_node/g" /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	sed -i "5s/@0.0.0.0/@$forth_node/g" /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	sed -i 's/30001/3000/g' /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	sed -i 's/30002/3000/g' /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	sed -i 's/30003/3000/g' /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	cat /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json
	break
fi
done

<<<<<<< HEAD
echo "What is your node user name?" 
read -p "secound node user name: " secound_name
read -p "third node user name: " thrid_name
read -p "forth node user name: " forth_name

scp -r /usr/local/src/homi-linux-amd64/bin/homi-output/script/static-nodes.json $secound_name@$second_node:~/ 
scp -r /usr/local/src/homi-linux-amd64/bin/homi-output/script/static-nodes.json $third_name@$thrid_node:~/ 
scp -r /usr/local/src/homi-linux-amd64/bin/homi-output/script/static-nodes.json $forth_name@$forst_node:~/ 
=======
scp -r /usr/local/src/homi-linux-amd64/bin/homi-output/script/static-nodes.json bigsmalljoe@$second_node:~/ 
scp -r /usr/local/src/homi-linux-amd64/bin/homi-output/script/static-nodes.json bigsmalljoe@$thrid_node:~/ 
scp -r /usr/local/src/homi-linux-amd64/bin/homi-output/script/static-nodes.json bigsmalljoe@$forst_node:~/ 
>>>>>>> 6bf8831ae7ff494997d75bf1700bb2035d1608c9

mkdir /home/$user_name/klaytn/data
cd /home/$user_name/klaytn/src/kscn-linux-amd64/bin
./kscn --datadir /home/$user_name/klaytn/data init /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/genesis.json

cp -r /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/scripts/static-nodes.json /home/$user_name/klaytn/data/

echo -n "Are you main node?"
read main_node

if [ $main_node = y ]; then
	cp -r /home/$user_name/klaytn/src/homi-linux-amd64/bin/homi-output/keys/nodekey1 /home/$user_name/klaytn/data/klay/nodekey
elif [ $main_node = n ]; then
	echo "Your not main service node."
fi

echo -n "Would you change kscnd.conf?(y/n)"
read input

if [ $input = y ]; then
	sed -i "s/PORT=22323/#PORT=22323/g" /home/$user_name/klaytn/src/kscn-linux-amd64/conf/kscnd.conf
	sed -i -r -e "/#PORT=22323/i\PORT=30000" /home/$user_name/klaytn/src/kscn-linux-amd64/conf/kscnd.conf
	sed -i "s/DATA_DIR=/#DATA_DIR=/g" /home/$user_name/klaytn/src/kscn-linux-amd64/conf/kscnd.conf
	sed -i -r -e "/#DATA_DIR/i\DATA_DIR=~/klaytn/data" /home/$user_name/klaytn/src/kscn-linux-amd64/conf/kscnd.conf 
fi

echo -n "Do you start kscnd start?(y/n)"
read answer
 if [ $kscnd = y ]; then
	 ./home/$user_name/klaytn/src/kscnd-linux-amd64/bin/kscnd start
 elif [ $kscnd = n ]; then
	 echo "Installed Service-node"
 fi
