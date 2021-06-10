# 公式のpytorchイメージを前提にする
FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-runtime
MAINTAINER AceBee007 <acebee007github.robinia@slmail.me>
# ラベルを設定
LABEL description="a personalized pytorch image"
# set this to skip tzdata installation config (maybe not needed)
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir /tblog
RUN apt update
# For useful apps
RUN apt install vim tmux htop wget curl git tzdata cmake libz-dev -y
RUN apt-get update && apt-get install -y libopencv-dev python-opengl
RUN apt install libgl1-mesa-dev -y
RUN apt upgrade python -y
RUN apt upgrade python3 -y
RUN apt clean
# remove some directory to reduce containers size
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install --upgrade pip
RUN pip install gym
RUN pip install tensorboard
RUN pip install tensorboard-plugin-profile
RUN pip install notebook
# need to use SuporcessVecEnv and the stable-baselines3 provide torch implementation
RUN pip install stable-baselines3
# notebokk theme and settings
RUN pip install jupyterthemes
# Theme: solarized_light, show (T)oolbar, (N)ame, code(f)ont roboto(mono), show (k)erne(l), (cellw)idth is 90% of window width
RUN jt -t solarizedl -T -N -f roboto -kl -cellw 90%

