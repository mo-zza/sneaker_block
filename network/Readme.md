# 서비스 체인 구성 및 배포

1. GCP 이용 서비스 체인 구성 및 배포 완료
2. kscnd.conf - port, datadir, subbridge 수정 완료
3. 4개 노드 통신 확인
4. block 생성 확인
        ##service_chain_install##

        ##main_service_node##
        wget http://packages.klaytn.net/klaytn/v1.4.2/kscn-v1.4.2-0-linux-amd64.tar.gz
        tar zxvf kscn-v1.4.2-0-linux-amd64.tar.gz
        wget http://packages.klaytn.net/klaytn/v1.4.2/homi-v1.4.2-0-linux-amd64.tar.gz
        tar zxvf homi-v1.4.2-0linux-amd64.tar.gz
        cd homi-linux-amd64/bin
        ./homi setup local --cn-num 4 --test-num 1 --servicechain --p2p-port 30000 -o homi-output
        ##--cn-num = service node 갯수, --test-num = testkey 생성 갯수, --p2p-port = node 통신 포트, -o = output 파일 명##
        vim homi-output/scripts/static-nodes.json
        ##service chain IP와 통신 port 지정##
        scp -r homi-output user@nodeIP:~/

        ##node 초기화(모든 node에서 사용)##
        wget http://packages.klaytn.net/klaytn/v1.4.2/kscn-v1.4.2-0-linux-amd64.tar.gz
        tar zxvf kscn-v1.4.2-0-linux-amd64.tar.gz
        mkdir ~/data
        ./kscn --datadir ~/data init ~/homi-output/script/genesis.json
        cp -r ~/homi-output/script/static-nodes.json ~/data/
        cp -r ~/homi-output/keys/nodekey{node number} ~/data/klay/nodekey
        vim kscn-linux-amd64/conf/kscnd.conf
        ##port, data_dir, sc_sub_bridge 수정##
        ##port = 30000, data_dir = ~/data, sc_sub_bridge=0(main node에서는 1로 만들어야 EN과 연결 가능)##
        ./kscnd start
        netstat -nlpt | kscn
        ##kscn으로 되어 있는 포트가 30000, 30001(node port), 8551, 8552(rpc port) 열려있으면 kscnd 정상 작동##

        ##block check##
        kscn attach --datadir ~/data
        > klay.blockNumber
        43
        ##blockNumber가 0이 아니면 정상 작동##
