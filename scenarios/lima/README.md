# Lima Scenarios

This directory includes various Nomad + Consul scenarios that runs on Lima VMs.

## Usage

The following steps should be done before trying to run the scenarios.

1. Create the cidata.iso from the `<repo-root>/packer/userdata` directory.
    ```
    $ make
    mkisofs -output cidata.iso -volid cidata -joliet -rock user-data meta-data
    Total translation table size: 0
    Total rockridge attributes bytes: 363
    Total directory bytes: 0
    Path table size(bytes): 10
    Max brk space used 0
    182 extents written (0 MB)
    ```

2. Build a source image using packer. If you are intending to use the default versions configued in the repo, run packer without any arguments. This will create the image file inside `<repo-root>/packer/artifacts/qemu/c-<consul-version>-n-<nomad-version>` directory.
    ```
    packer build hashibox.pkr.hcl
    ```
    
    If you have custom versions of Consul or Nomad, use packer variables to set the variables (either using args or the var file) and run packer build.

    ```
    packer build -var-file variables.pkrvars.hcl hashibox.pkr.hcl
    ```

3. Once the above two steps are done, you can go to specific scenario directory and run the makefile. 
    ```
    make create consul=1.18.1 nomad=1.7.7
    ```
The makefiles commonly supports the following targets:

    * `create`: This creates and starts lima VM[s]
    * `start`: This starts the VM[s]
    * `stop`: This stops the VM[s]
    * `destroy`: This stops and delets the VM[s]