# Kubernetes apps development environment on Docker

Kubernetes application development environment anywehere.

## Including software

|software          |version|
|------------------|-------|
|kubectl           |v1.9.0 |
|Helm              |v2.8.0 |
|Open SSH          ||
|bash              ||
|make              ||
|curl              ||
|Vim               ||
|Visual Studio Code||
|.NET Core SDK     |v2.1.4 |
|Open JDK          |v8u151 |
|Go                |v1.10  |
|node.js           |v9.6.1 |

## How to use this container image

### on macOS

#### Pre requirements software

|software|version|
|--------|-------|
|xQuarts |v2.7.11|

#### How to run docker container and start development

1. start docker container as daemon.

```
docker run -d -v ${HOME}/.kube:/home/me/.kube -p 2200:22 archway/k8s-dev:$(tag)
```

2. connect SSH to docker container

```
ssh -p 2200 -X me@localhost
```

3. input password `1qax2wsx` on ssh prompt.
4. start Visual Studio Code
```
code .
```

### on Windows

#### Pre requirements software

|software|version|
|--------|-------|
|[MobaXterm](https://mobaxterm.mobatek.net/download-home-edition.html)|v10.5|

#### How to run docker container and start development

1. start docker container as daemon.

```
docker run -d -v /c/User/%USERNAME%/.kube:/home/me/.kube -p 2200:22 archway/k8s-dev:latest
```

2. start MobaXterm.
3. select `Session` menu button, and open `Session settings` window.
4. select `SSH` menu button.
5. input parameters and click OK button.

|input                                |value    |
|-------------------------------------|---------|
|Remote host                          |localhost|
|Specify username                     |me       |
|Port                                 |2200     |
|Advanced SSH settings > X11Forwarding|check    |

6. input password `1qax2wsx` on MobaXterm prompt.