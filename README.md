Yocto docker builder image
==========================

This image will install an operating system ready to build Yocto Project.

Use:

```
docker run -it --rm <container-id>
```

For example, to use the pre-build images available in dockerhub:

```
docker run -it --rm aggurio/yocto-builder:<version>
```

For example,

```
docker run -it --rm aggurio/yocto-builder:2.6
```

Build:

```
docker build \
-t yocto-builder:<version> \
--build-arg UBUNTU_VERSION="bionic" \
--no-cache .
```
