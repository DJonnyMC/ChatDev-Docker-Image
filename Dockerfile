FROM ubuntu:22.04

ARG OPENAI_API_KEY

#ENV OPENAI_API_KEY="${OPENAI_API_KEY}"

RUN apt update \
		&& apt install -y wget \
        && apt install -y git

RUN mkdir -p ~/miniconda3 \
        && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
        && bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
        && rm -rf ~/miniconda3/miniconda.sh \
        && ~/miniconda3/bin/conda init bash \
        && ~/miniconda3/bin/conda init zsh 

RUN exec bash \
	&& git clone https://github.com/OpenBMB/ChatDev.git \
        &&conda create -n ChatDev_conda_env python=3.9 -y \
        && conda activate ChatDev_conda_env \
        && cd ChatDev \
        && pip3 install -r requirements.txt \
        && export OPENAI_API_KEY="${OPENAI_API_KEY}"
