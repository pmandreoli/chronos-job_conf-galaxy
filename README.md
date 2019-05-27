# job\_conf-galaxy

job.conf.xml file | description| issues
---|---|---|
*chronos\_job\_conf.xml* | configuration to run galaxy in a apache MESOS cluster | the jobs are run but there are problem in linking the results in the history, the runner chronos.py called by the chronos destination block have some lack: is not possible to attach other volumes (as cvmfs for refdata) and the job is not executed in the default working  directory and this parameter can not be set 
*docker\_default\_local\_job\_conf.xml* | configuration to run galaxy with jobs dockerized by mulled | the configuration work without problems is also possible to attach cvmfs volumes for refdata some of the tools can't be run with mulled, for this reason is better to specify the tools that run with Conda in the tool block  
*singularity\_job\_conf.xml* | configuration file to run jobs in Singularity container | it works well with attached cvmfs volumes (one for singularity images, /cvmfs/singularity.galaxyproject.org, and one for refdata) but the version of galaxy must be >= 18.09 because only in this version the development team add the singularity block ```<param id="singularity_image_dir">PATH</param>``` 
*docker\_optional\_job\_conf.xml* | configuration to run specific tools on docker destination, Conda will be the default dependency resolver | it works but all Docker tools has to be defined in the ```<tools></tools>``` block.To resolve this problem i tried to use dinamic destination ```xml <destination id="docker\_dispatch" runner="dynamic">``` but to not avail. The docker container are run with sudo

In all the configuration the upload1 tool is setted to be run in local destination in order to allow the upload of files. 
