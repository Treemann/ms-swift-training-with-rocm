# step0: install related libraries for IB, after that you can use 'ibv_devices' to check IB
sudo apt update
sudo apt -y install linux-headers-"$(uname -r)"  libelf-dev
sudo apt -y install wget gcc make libtool autoconf  librdmacm-dev rdmacm-utils infiniband-diags ibverbs-utils perftest ethtool  libibverbs-dev rdma-core strace

# step1: [TODO] manually copy related files from host to the local directory: usr, etc
# copy host:/usr/local/lib/libbnxt_re* to local path (also mounted to the container): usr/local/lib/
# copy host:/etc/libibverbs.d/* to local path (also mounted to the container): etc/libibverbs.d/
# copy host:/etc/infiniband-diags/* to local path (also mounted to the container): etc/infiniband-diags/

# step2: rename the original bcm driver lib to make lib from step2 take effect
find /usr/lib64/  /usr/lib -name "libbnxt_re-rdmav*.so"  -exec mv {} {}.inbox \;

# step3: copy from mounted local directory to the container
cp usr/local/lib/libbnxt_re* /usr/local/lib/
cp etc/libibverbs.d/* /etc/libibverbs.d/
cp etc/infiniband-diags/* /etc/infiniband-diags/

# step4: add to the shared library search path
sudo sh -c "echo /usr/local/lib >> /etc/ld.so.conf"
sudo ldconfig
