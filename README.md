# Continious Integration Boilerplate

Noramlly, CI includes 2 independent runs:

* Building application according to environment (staging, production, testing etc.)
* Deploying application to server or to farm, such as staging server, production server

Usually, on small projects environment configuration and server hadly linked, but there's some cases (clusters, multiplatform testing) 
this steps are different and require extra-configuration, that only build process unable to reach.

This boilerplate optimized to support this kind of behaviour, separating 2 processes of build and deployment through Ant build file with configuration
of environment and Capistrano deployment scripts

## Installation

Add this repository as submodule:

```bash
	$ git submodule add <repo> --init
```

or just copy and unpack tarball to your desired location

## Tune it

In root of CI Boilerplate you will find 2 files:

* build.xml - Ant configuration to build your application
* deploy.rb - Capistrano deployment script with major actions required to deploy
* deploy/*.rb - Deployment stages for Capistrano


## Run

To build your application run

```bash
	<your application directory>$ cd ci
	<your application directory>/ci>$ ant <target>
```

To deploy your application you should do

```bash
	<your application directory>$ cd ci
	<your application directory>/ci>$ cap <stage> deploy
```

If you do first run deployment:

```bash
	<your application directory>$ cd ci
	<your application directory>/ci>$ cap <stage> deploy:setup
```

## Links

Capistrano documentation could be found 

* https://github.com/leehambley/capistrano-handbook/blob/master/index.markdown
* https://github.com/capistrano/capistrano/wiki/2.x-Getting-Started
* https://help.github.com/articles/deploying-with-capistrano


