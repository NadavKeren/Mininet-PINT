git clone --depth=1 -b v3.18.1 https://github.com/google/protobuf.git
cd protobuf/
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
cd ..

git clone --depth=1 -b v1.43.2 https://github.com/google/grpc.git
cd grpc/
git submodule update --init --recursive
make
sudo make install
sudo ldconfig

sudo apt-get install build-essential cmake libpcre3-dev libavl-dev libev-dev libprotobuf-c-dev protobuf-c-compiler

git clone --depth=1 -b v0.16-r1 https://github.com/CESNET/libyang.git
cd libyang
mkdir build
cd build
cmake ..
make
sudo make install

cd ../..

git clone --depth=1 -b v0.7.5 https://github.com/sysrepo/sysrepo.git
cd sysrepo
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=Off -DCALL_TARGET_BINS_DIRECTLY=Off ..
make
sudo make install
cd ../..

sudo sysrepod -d

git clone https://github.com/p4lang/PI.git
