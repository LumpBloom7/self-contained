# Bloom's container repository

This repository contains container setups that should work on all systems, while providing sufficient quality of life for the common developer.

> All commands assume your terminal working directory is this folder.

> You may need to restart your system one or more times during setup

## Pre-requisites

0. Ensure you are using Wayland instead of X11
	* This can be typically set during login. Most people can find a settings menu in the bottom right corner.
	* Refer to a search engine for more details.
1. Install [Docker](https://docs.docker.com/engine/install) or [Podman](https://podman.io/docs/installation#installing-on-linux)
	* Follow the relevant steps for your system
2. Install [docker-compose](https://docs.docker.com/compose/install/linux/#install-using-the-repository)


### NVIDIA USERS
All NVIDIA users should install the NVIDIA drivers and [install the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) in order to be able to leverage NVIDIA hardware within the container.

> If you're running on a Laptop with dual GPU, also follow [the NVIDIA specific README](./NVIDIA_README.MD)

## 1. Automatic X11 forwarding
> You only need to do this once

Many container configurations is designed with the capability to present windows for programs within the container on the host system.

In order to ensure that the authorisation token is in the same location everytime, a SystemD service is used to copy the file everytime the user logs in.

To install and enable this service, run the following commands. 

```sh
cp _utils/xauthority.service ~/.config/systemd/user/
systemctl enable --user --now xauthority.service
```

## 2. Building the container image

Once the fundamentals are set-up. You can now build your own container

First navigate to the target container directory (in this case we are using `IsaacSim`)

```sh
cd IsaacSim
```

Then we can build an image for this container, using a file that describes how to build the image.

```sh
[docker|podman] compose build
```

This may take some depending on the image, so sit back and have a cup of tea.

## 3. Deploying the container
Assuming the build process succeeded, we can now deploy our container instance.

```sh
[docker|podman] compose up -d
```

This will spin up a container with the image that was built earlier. And will print the name of the container in the terminal. In this case the terminal name is `container_isaac_sim`.

You can access the container via the following command. You may replace the container name with the appropriate one if you chose a different configuration.
```sh
[docker|podman] exec -ti container_isaac_sim bash
```

Now you can run programs in the container. In our guide, we deployed the IsaacSim container, so we can attempt to run that.

```sh
isaacsim
```
 
If everything went right, we should see the IsaacSim window appear on our desktops.

## 4. Accessing the container via VSCode

A convenient way to access and code within the container is to use the [Remote development extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).

Once installed, there would be an icon in the sidebar that shows all of the running (and not running) containers. You can attach to any of them via a click of a button!

Once attached, the terminal and filesystem will reflect the contents of the container.

# Important tips
* Make use of Git to save your codebase. In the event that the container is inaccessible, retrieving your code is impractical. Form good habits and ensure your code is committed to GitHub/GitLab