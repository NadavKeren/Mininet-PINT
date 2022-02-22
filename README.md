# Running PINT on Mininet

This repository gives the sample code to run and test PINT on Mininet.

## Requirements
1. Mininet supporting bmv2 (https://github.com/nsg-ethz/p4-learning)
2. networkx (pip install networkx)
3. scapy (pip install scapy)
4. numpy (pip install numpy)

## Installation
1. Download the 18.04 VM of Mininet
2. Extend the virtual drive of the VM to a bigger size (i.e 20GB). On Virtualbox, enter File -> Virtual Media Manager -> On hard-disks tab (the default tab) change the size of the relevant VDI file.
3. Extend the size of the filesystem in the VM itself:

    3.1 Install parted using apt - `sudo apt install parted`

    3.2 Use parted with root user - `sudo parted`

    3.3 List all partitions using `print all`

    3.4 Find the `ext4` partition (suppose to be /dev/sda5), and the "extended" partition (/dev/sda2).

    3.5 Resize the partitions (first the **extended** and only then the ext4) using `resizepart` - choose the partition number as listed in the print output, and then choose the end sector to be 20000 (20GB)

    3.6 Exit the parted utility (using Ctrl+C)

    3.7 Resize the ext4 filesystem using `sudo resize2fs /dev/sda5` (assuming it is on /dev/sda5).

4. Install the requirements:

    4.1 Install nanomsg

    4.2 Install thrift

    4.3 Install behavioral model v2

    4.4 Install the pip requirements (networkx, scapy, numpy)

## Steps to run PINT
- Create topology.

Ensure you are running this in VM with Mininet.
Create a Mininet topology to conduct path tracing on path size N.

`python topo_allocator.py 5`

where 5 indicates that path tracing needs to be conducted on five switches. In our paper, we used N= 5, 36, 59.

- Start Mininet.

Start Mininet with the newly constructed topology.

`sudo p4run --config p4app.json`

- Start path tracing.

Start path tracing by specifying the length of path (N).

`sudo python exp.py 5`

where 5 indicates the length of path.

- Generate results.

Generate results using:

`python generate_results.py 5`

where 5 indicates the length of path. The results can be found under final_results/5. There
will be three files, indicating the average, median and tail number of packets required to conduct
path tracing for path length of 5. This will also contain results for ASM and PPM techniques.

# Running PINT for delay quantiles

## Requirements
1. Python 3.7.5
2. numpy (pip install numpy)

## Setting up Python 3.7.5 in Mininet VM

- Install Miniconda: https://docs.conda.io/en/latest/miniconda.html
- Create a new Python 3.7.5 environment.
- Run PINT for delay quantiles in that environment.

## Steps to run PINT for delay quantiles

- Generate delay data obtained from ns3 simulations.

`python generate_delay_data.py file_name`

where file_name is the location of delay data generated from ns3 simulations. A sample
processed data is present in experiments/delays/processed_data

- Generate results

`python generate_delay_results.py`

This generates the average, median and tail latencies in final_results/delays. 
