<!--
paginate: true
title: EdgeFarm Training
header: 'EdgeFarm Training'
footer: '![height:25px](./img/ci4rail_logo.png)'
style: |
  header, footer {
    font-size: 10pt;
  }
  h1{
      padding: 0;
      margin: 0;
  }
  h2, h3{
      padding: 0;
      margin: 5px;
  }
-->

# Building container images explained

You can build container images several ways, either locally or by an CI-system. 
The special about this section is, that the resulting container images are built for multiple CPU architectures. This is called a multi-arch image.
This section describes both local build and build via Github Actions.

*Note: Other CI sytems like Concourse, CircleCI, Jenkins do also work for building container images.*

In every case you need to have access to a container registry. This Section uses Docker Hub. If you want to follow along, it is recommended to create a free account at [Docker Hub](https://hub.docker.com/signup) or you can use a private registry.

---

### Local build

For local building multi arch images please refer to the [docker training](https://github.com/edgefarm-hands-on/docker-training/blob/main/README.md#cross-compiling-for-different-cpu-architectures).

### Automatic build using Github Actions

There is the popular Github Action called `build-and-push-docker-images`.

Please refer to the [docs](https://github.com/marketplace/actions/build-and-push-docker-images#usage).