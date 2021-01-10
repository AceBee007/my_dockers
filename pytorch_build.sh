echo 'Building docker'
sudo docker build --network host -f pytorch_dockerfile -t acebee007/pytorch:latest .
mkdir ../pytorch_workspace
mkdir ../pytorch_workspace/root
mkdir ../pytorch_workspace/workspace
mkdir ../pytorch_workspace/tblog
