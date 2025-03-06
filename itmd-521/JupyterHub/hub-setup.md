## Installation

### Check prerequisites

- A Linux/Unix based system
- [Python](https://www.python.org/downloads/) 3.8 or greater
- [nodejs/npm](https://www.npmjs.com/)

  - If you are using **`conda`**, the nodejs and npm dependencies will be installed for
    you by conda.

  - If you are using **`pip`**, install a recent version (at least 12.0) of
    [nodejs/npm](https://docs.npmjs.com/getting-started/installing-node).

- If using the default PAM Authenticator, a [pluggable authentication module (PAM)](https://en.wikipedia.org/wiki/Pluggable_authentication_module).
- TLS certificate and key for HTTPS communication
- Domain name

### Install packages
Use `sudo` to install the packages globally.
#### Using `pip`

JupyterHub can be installed with `pip`, and the proxy with `npm`:

```bash
npm install -g configurable-http-proxy
python3 -m pip install jupyterhub
```

If you plan to run notebook servers locally, you will need to install
[JupyterLab or Jupyter notebook](https://jupyter.readthedocs.io/en/latest/install.html):

    python3 -m pip install --upgrade jupyterlab
    python3 -m pip install --upgrade notebook

### Run the Hub server

Use `sudo` to run the below commands for multi user access.

To start the Hub server, run the command:

    jupyterhub

Visit `http://localhost:8000` in your browser, and sign in with your system username and password.

To access the hub at a paticular url use `--ip` flag.

```
jupyterhub --ip 192.168.172.26
```

_Note_: To allow multiple users to sign in to the server, you will need to
run the `jupyterhub` command as a _privileged user_, such as root.
The [wiki](https://github.com/jupyterhub/jupyterhub/wiki/Using-sudo-to-run-JupyterHub-without-root-privileges)
describes how to run the server as a _less privileged user_, which requires
more configuration of the system.

## Configuration

The [Getting Started](https://jupyterhub.readthedocs.io/en/latest/tutorial/index.html#getting-started) section of the
documentation explains the common steps in setting up JupyterHub.

The [**JupyterHub tutorial**](https://github.com/jupyterhub/jupyterhub-tutorial)
provides an in-depth video and sample configurations of JupyterHub.

### Create a configuration file

To generate a default config file with settings and descriptions:

    jupyterhub --generate-config

Add the below lines of code to the `jupyterhub_config.py`  to allow all users to login into the hub.

```
c.Authenticator.allow_all = True
```

To enable admin access add the below line to the `jupyterhub_config.py` file and specify which users are admins

```
c.Authenticator.admin_users = { 'hardway_admin' }
```

More configuration options can be found [here](https://jupyterhub.readthedocs.io/en/stable/reference/config-reference.html).

## Run Jupyterhub as a Service

Below is the service file for the hub

```
[Unit]
Description=jupyterhub
Wants=network-online.target
After=network-online.target

[Service]
#User=jupyterhub
#Group=jupyterhub
Type=simple
ExecStart=/usr/local/bin/jupyterhub -f /home/controller/jupyterhub_config.py --ip 192.168.172.26

[Install]
WantedBy=multi-user.target
```
Replace the `ExecStart` with paths where hub and `jupyterhub_config.py` are located. The `-f` flag is used to load the `jupyterhub_config.py` file from a specified path.

> If any modification has been done to the config file after the hub service has been started. The service needs to be restarted to succesfully load the new config.

## Extensions

There are two ways to install extensions. You can use the extensions menu in hub UI to view and install extensions directly but these installation are per user not reflected globally. 

If an extension needs to installed globally use `pip` with `sudo` from the controller to install them gloablly. Use the same method to install any server side extension requirements.

Installing per user :  

```
pip install --upgrade jupyterlab jupyterlab-git
```
Installing globally :

```
sudo pip install --upgrade jupyterlab jupyterlab-git
```
> The example shown above installes native git source control for the Hub.