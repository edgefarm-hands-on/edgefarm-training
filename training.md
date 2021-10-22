---
marp: true
title: Training Presentation
paginate: true

style: |
  header, footer {
    font-size: 25pt;
  }
---


# Ablauf <!-- omit in toc -->
- [Entwicklungsumgebung](#entwicklungsumgebung)
  - [Benötigte Software](#benötigte-software)
  - [Benötigte Logins](#benötigte-logins)
  - [Bereitgestellte Umgebung](#bereitgestellte-umgebung)
- [Applikationen Entwickeln und Deployen](#applikationen-entwickeln-und-deployen)
  - [Train Simulator](#train-simulator)
  - [Ausführen auf Entwickler PC](#ausführen-auf-entwickler-pc)
    - [Repository holen](#repository-holen)
    - [Optional: Train Simulator lokal starten](#optional-train-simulator-lokal-starten)
    - [NATS Server starten](#nats-server-starten)
    - [EdgeFarm Service Module starten](#edgefarm-service-module-starten)
    - [Applikation ausführen](#applikation-ausführen)
  - [Docker Image](#docker-image)
  - [Datenformat](#datenformat)
  - [Routing](#routing)
  - [Deployment](#deployment)
  - [Nutzung der Daten](#nutzung-der-daten)

---

# Entwicklungsumgebung
1. Benötigte Software
2. Benötigte Logins
3. Bereitgestellte Umgebung

---
<!-- header: Entwicklungsumgebung -->

## Benötigte Software
1. [WireGuard](https://www.wireguard.com/install/)
1. [Docker](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/docker/)
2. [Docker-Compose](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/docker-compose/)
3. [QEMU](https://qemu.weilnetz.de/w64/)
4. [EdgeFarm CLI](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/edgefarm-cli/)
5. [NATS CLI](https://github.com/nats-io/natscli#installation) <!-- omit in toc -->
6. [git](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/git/) (optional)

---

## Benötigte Logins
1. [Docker Hub](https://hub.docker.com/signup) (alternativ: andere private registry?)
2. [GitHub](https://github.com/join) (optional)

---

## Bereitgestellte Umgebung
1. EdgeFarm Zugänge
2. VPN Einrichten
3. Runtimes
4. Simulator Device

---

<!-- header: Entwicklungsumgebung - Bereitgestellte Umgebung -->

### EdgeFarm Zugänge <!-- omit in toc -->

Benötigte Informationen sind:
- VPN Private Key
- Tenant Name
- Account Name
- Account Password
- NATs Endpoint Credentials File
- IoT Device Connection String (zum Ausführen auf Entwickler PC)

Infos werden per Mail zur Verfügung gestellt.

---

### VPN Einrichten <!-- omit in toc -->

- WireGuard starten und mit `STRG + n` einen neuen Tunnel erstellen
- Namen für die Konfiguration eingeben: e.g. `ci4rail-vpn`
- Füge den folgenden Inhalt in das große Feld:
    ```
    [Interface]
    PrivateKey = <VPN Private Key>
    Address = 10.7.0.2/24

    [Peer]
    PublicKey = 0vmHOS8fZJc3VLGqA9d7e/4XB5VAfcxGOmOXrJYghR0=
    AllowedIPs = 10.7.0.0/24, 192.168.24.19/32, 192.168.24.42/32
    Endpoint = 148.251.135.244:51821
    ```
- Speichern und Aktivieren der Konfiguration

---

### Runtimes <!-- omit in toc -->

Moducop:
- Name:   axolotl
- Addresse: 192.168.24.19
- User: root
- Password: cheesebread

Virtual Device: 
- Name: demo_cloud

---

### Simulator Device <!-- omit in toc -->

Raspberry Pi:
- Addressed: 192.168.24.42
- Node Red Oberfläche: http://192.168.24.42:1880/
- Node Red UI: http://192.168.24.42:1880/ui

---

<!-- header: "" -->

# Applikationen Entwickeln und Deployen
1. Train Simulator
2. Ausführen auf Entwickler PC
3. Docker Image
4. Datenformat
5. Routing
6. Deployment
7. Nutzung der Daten

---

<!-- header: Applikationen Entwickeln und Deployen -->

## Train Simulator
![-](images/demo-arch.svg)

---

## Ausführen auf Entwickler PC
1. Repository holen
2. Optional: Train Simulator lokal starten
3. NATS Server starten
4. EdgeFarm Service Module starten
5. Applikation ausführen

---

<!-- header: Applikationen Entwickeln und Deployen - Ausführen auf Entwickler PC -->

### Repository holen
Repository mit Beispielen und Simulator clonen:
```
git clone git@github.com:edgefarm/train-simulation.git
```

---

### Optional: Train Simulator lokal starten
Mit docker-compose hochfahren:
```bash
$ cd simulator
$ docker-compose up 
```

Füge `mosquitto` to Hosts Datei `C:\Windows\System32\drivers\etc\hosts`:
```
127.0.0.1 mosquitto
```

---

### NATS Server starten
```bash
$ docker run -p 4222:4222 \
             -p 6222:6222 \
             -p 8222:8222 \
             --name nats \
             --network simulator_edgefarm-simulator \
             -d nats
```

Füge `nats` to Hosts Datei `C:\Windows\System32\drivers\etc\hosts`:
```
127.0.0.1 nats
```

---

### EdgeFarm Service Module starten

`mqtt-bridge` starten, verbinden auf lokalen MQTT Server:
```bash
$ docker run --network simulator_edgefarm-simulator  ci4rail/mqtt-bridge:latest
```

`mqtt-bridge` starten, verbinden auf MQTT Server auf Raspberry Pi:
```bash
$ docker run -e MQTT_SERVER=192.168.24.42:1883 \ 
             --network simulator_edgefarm-simulator ci4rail/mqtt-bridge:latest
```

---

Starten von `ads-to-evhub`, welcher das EdgeFarm Service Module `ads-node-module` in der Development Entwicklung ersetzt:
```bash
$ docker run -e KAFKA_ADDRESS=<KAFKA_ADDRESS> \
             -e KAFKA_PASSWORD=Endpoint=<KAFKA_PASSWORD> \
             --network simulator_edgefarm-simulator ci4rail/ads-to-evhub:latest
```

---

### Applikation ausführen

Docker Image der Applikation bauen:
```bash
$ docker build -t <app name> --build-arg VERSION=main .
```

Docker Image ausführen:
```bash
$ docker run --network simulator_edgefarm-simulator <app name>
```
---

## Docker Image
1. Lokal bauen und ausführen
2. Image Pushen
3. Cross Build

---

<!-- header: Applikationen Entwickeln und Deployen - Docker Image -->

### Lokal bauen und ausführen <!-- omit in toc -->

Docker Image bauen:
```bash
$ docker build -t <docker repository>/<image name>[:<tag>] --build-arg VERSION=main .
```

Docker Image ausführen:
```bash
$ docker run <docker repository>/<image name>[:<tag>]
```

---


### Image Pushen <!-- omit in toc -->

Mit Docker Account einloggen:
```bash
$ docker login
```

Image pushen:
```
docker push <docker repository>/<image name>[:<tag>]
```

---

### Cross Build <!-- omit in toc -->

Initial:
```bash
$ docker buildx create --use
```

Bauen und pushen mit buildx:
```bash
$ docker buildx build --push --platform linux/arm64,linux/amd64 --build-arg VERSION=main --tag <docker repository>/<image name>:<tag> .
```

---

<!-- header: Applikationen Entwickeln und Deployen -->

## Datenformat
Apache Avro:
- Umfangreiche Datenstrukturen
- Kompaktes, schnelles, binäres Datenformat
- Library Support für viele Programmiersprachen
- Schemas 

---

<!-- header: Applikationen Entwickeln und Deployen - Datenformat -->

```
{
    "name": "vibrationPeak",
    "type": "record",
    "fields": [
        {
            "name": "meta",
            "type": {
                "name": "t_meta",
                "type": "record",
                "fields": [
                    {
                        "name": "version",
                        "type": "bytes"
                    }
                ]
            }
        },
        {
            "name": "data",
            "type": {
                "name": "t_data",
                "type": "record",
                "fields": [
                    {
                        "name": "time",
                        "type": {
                            "doc": "time of measurement in microseconds since 1.1.1970",
                            "type": "long",
                            "logicalType": "timestamp-micros"
                        }
                    },
                    {
                        "doc": "Latitude (°)",
                        "name": "lat",
                        "type": "double"
                    },
                    {
                        "doc": "Longitude (°)",
                        "name": "lon",
                        "type": "double"
                    },
                    {
                        "doc": "RMS of measurement (m/s^2)",
                        "name": "vibrationIntensity",
                        "type": "double"
                    }
                ]
            }
        }
    ]
}
```

---

![-](images/datenformat.drawio.svg)

---

<!-- header: Applikationen Entwickeln und Deployen -->

## Routing

![-](images/Routing.drawio.svg)

---

## Deployment 
1. Deployment File
2. Deployment ausführen
3. Deployment löschen
4. Deployment Status überprüfen

---

<!-- header: Applikationen Entwickeln und Deployen - Deployment -->

### Deployment File <!-- omit in toc -->

```yaml
---
application: basis
modules:
  - name: mqtt-bridge
    image: ci4rail/mqtt-bridge:latest
    type: edge
    createOptions: "{}"
    labelSelector:
      rpi: axolotl
    imagePullPolicy: on-create
    restartPolicy: always
    status: running
    startupOrder: 1
    envs:
      MQTT_SERVER: 192.168.24.42:1883
```

---

### Deployment ausführen <!-- omit in toc -->

```bash
$ edgefarm applications apply -f <path/to/deployment file>
```

### Deployment löschen <!-- omit in toc -->
```bash
$ edgefarm applications delete deployment <application>
```

---

### Deployment Status überprüfen <!-- omit in toc -->

Deployments anzeigen per EdgeFarm CLI:
```bash
$ edgefarm applications get deployments
```

Status der Deployments anzeigen per EdgeFarm CLI:
```bash
$ edgefarm applications get deployments -o w -m
```

Auf dem Device kann man den status der laufenden Container sehen:
```bash
$ docker ps
```

---

## Nutzung der Daten
1. Datenvisualisierung mit Grafana
2. Datenexport mit NATS


---

### Datenvisualisierung mit Grafana <!-- omit in toc -->

- URL: https://<tenant ID>.grafana.edgefarm.io
- Login mit EdgeFarm Account über `Sign in with Auth0`
- Existierende `demo` Dashboards können über `Dashboards > Manage` erreicht werden

--- 

### Datenexport mit NATS <!-- omit in toc -->

Daten via NATS CLI abrufen:
```bash
$ nats consumer next EXPORT CUSTOMER \
        -s tls://connect.ngs.global:4222 \
        --creds=natsEndpoint.creds \
        -r
{"app":"hvac","module":"hvac_push-temperature","payload":{"temp":31.33},"time":"\"2021-08-31T06:20:12Z\""}
```
