FROM python:3.12-bookworm

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo vim git nano openjdk-17-jdk \
    libcairo2-dev libsndfile1 build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./

RUN python -m pip install --upgrade pip \
    && python -m pip install --no-cache-dir -r requirements.txt \
    && python -m pip install --no-cache-dir jupyter ipykernel \
    && python -m pip uninstall -y triton || true

ENV TORCH_COMPILE_DISABLE=1

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]