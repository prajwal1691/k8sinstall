#/bin/bash

echo "     Running script with $(whoami)"

echo "     STEP 1: Disabling Swap"
        # First diasbale swap
        sudo swapoff -a
        # And then to disable swap on startup in /etc/fstab
        sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
echo "            -> Done"

echo "     STEP 2: Installing apt-transport-https"
        sudo apt-get install -y apt-transport-https 1>/dev/null
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
        sudo bash -c echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
echo "            -> Done"

echo "     STEP 3: Updating apt"
        sudo apt-get update 1>/dev/null
echo "            -> Updated ...."

echo "     STEP 4: Starting Docker Deamon and enable Service....."
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh 1>/dev/null

echo "     STEP 5: C-Group Error Fix and Restarting Components"
        echo "{ \n \"exec-opts\": [\"native.cgroupdriver=systemd\"]\n}" > /etc/docker/daemon.json
        systemctl daemon-reload
        systemctl restart docker
echo "            -> Done"

echo "     STEP 6: Installing kubenetes master components"
        echo "            -> Installing kubelet"
                sudo apt-get install -y kubelet 1>/dev/null
        echo "            -> Installing kubeadm"
                sudo apt-get install -y kubeadm 1>/dev/null
        echo "            -> Installing kubectl"
                sudo apt-get install -y kubectl 1>/dev/null
        echo "            -> Installing kubernetes-cni"
                sudo apt-get install -y kubernetes-cni 1>/dev/null
     

echo "-----------------------------------------------------------"
echo "  Kubernetes node template is now created "
echo "  Create AMI form this node to create worker nodes"
echo "  Action --> Image --> Create Image"
echo "      Note: This node will be your master node "
echo "-----------------------------------------------------------"
exit
