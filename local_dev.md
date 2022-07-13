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


# Local development explained

This section is used to give a basic understanding of how a developer can write an application that can be ran using EdgeFarm.

*Note: This example application is developed and ran on the local machine only. There is no EdgeFarm whatsoever involved in this process yet!
The output artifact that can be passed over to EdgeFarm is the resulting multi-arch container image that contains the application.*

---

Requirements are:

- [Docker](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/docker/)                  
    Required to containerize applications in preparation for deploying to the target device.
- [Docker-Compose](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/docker-compose/)
A tool for defining and running Docker applications with multiple containers. Used to spin up the development environment on the dev machine to be able to debug locally.
- [Visual Studio Code](https://code.visualstudio.com/download)
- [git](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/git/)

---

### Getting the example

Clone the examples git repository:
```bash
$ git clone https://github.com/edgefarm/examples
$ cd examples/data-export
```

Spin up the dev environment using docker-compose. The development environment contains essential parts of `EdgeFarm.network` that are run locally on your dev machine.

```bash
$ cd dev
$ docker-compose up -d
$ cd ...
```
---

### Prepare streams

In this example, a local stream needs to be created manually. This stream corresponds to the stream that will be created later on the node.

```bash
$ docker run -it --rm --network host \
    --entrypoint /bin/nats \
    synadia/nats-server:nightly \
    -s nats://localhost:4222 stream add \
        test --subjects "EXPORT.*" \
        --ack --max-msgs=100000 \
        --max-bytes=1073741824 \
        --max-age=2d \
        --storage file \
        --retention limits \
        --max-msg-size=-1 \
        --discard old \
        --dupe-window="0s" \
        --replicas 1 \
        --max-msgs-per-subject=-1 \
        --allow-rollup \
        --no-deny-delete \
        --no-deny-purge
```
---

### Listing all streams
```bash
$ docker run -it --rm --network host \
    --entrypoint /bin/nats \
    synadia/nats-server:nightly \
    -s nats://localhost:4222 stream ls
```
---

### Run application
To run the application, the required Python libraries must be installed first:
```
$ cd publish-export-data
$ pip3 install -r requirements.txt
```

Run the application:
```
python3 main.py
```
---

### Receive data locally

```bash
$ docker run -it --rm --network host \
    --entrypoint /bin/nats \
    synadia/nats-server:nightly \
    -s nats://localhost:4222 sub "EXPORT.>"
```

### Start debug session using VS code

1. Öffne das Git Repository `examples` mit VS Code
2. Drücke `Strg+Shift+D`
3. Selektiere `data-export - publish-export-data` im Drop Down Menü
4. Drücke `F5` um die Debug Session zu starten

---

Once your application is running, you can refer to the [Building container images explained](building_images.md) docs.