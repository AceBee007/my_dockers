echo 'Building docker'
sudo docker build --network host -f pytorch_dockerfile -t acebee007/pytorch:latest .
mkdir ../project_workspace
mkdir ../project_workspace/tf
mkdir ../project_workspace/root
mkdir ../project_workspace/tblog
