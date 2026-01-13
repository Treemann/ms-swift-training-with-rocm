DOCKER=docker.io/rocm/pytorch-training:v25.9_gfx942
NAME=rocm-pt-v25.9

# docker run -it \
podman run -it \
    --network host --ipc host \
    --privileged \
    -v /shared/amdgpu:/shared/amdgpu \
    -w ${PWD} \
    --name ${NAME} \
    ${DOCKER} \
    /bin/bash
