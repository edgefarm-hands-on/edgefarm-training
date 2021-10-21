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
  - [Bereitgestellte Umgebung](#bereitgestellte-umgebung)
- [Applikationen Entwickeln und Deployen](#applikationen-entwickeln-und-deployen)
  - [Train Simulator](#train-simulator)
  - [Ausführen auf Entwickler PC](#ausführen-auf-entwickler-pc)
  - [Docker Image](#docker-image)
  - [Datenformat](#datenformat)
  - [Routing](#routing)
  - [Deployment](#deployment)
  - [Nutzung der Daten](#nutzung-der-daten)

---

# Entwicklungsumgebung
1. Benötigte Software
2. Bereitgestellte Umgebung

---
<!-- header: Entwicklungsumgebung -->

## Benötigte Software
1. [Docker](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/docker/), buildx, quemu, docker-compose
2. [EdgeFarm CLI](https://docs.ci4rail.com/edgefarm/reference-manual/prerequisites/edgefarm-cli/)
3. [NATS CLI](https://github.com/nats-io/natscli#installation) <!-- omit in toc -->

---

<!-- header: Entwicklungsumgebung -->

## Bereitgestellte Umgebung
1. VPN
2. Account und Tenant
3. Docker Registry Zugang
4. Runtimes
5. Simulator Device

---

<!-- header: Entwicklungsumgebung - Bereitgestellte Umgebung -->

### VPN <!-- omit in toc -->

TODO: Fill

---

### Account und Tenant <!-- omit in toc -->

Tenant: `demo`
Account: `thomas.weber@logomotive.eu`
Password: Via Mail

---

### Runtimes <!-- omit in toc -->

Moducop:
- Name:   axolotl
- Address: 192.168.24.19
- User: root
- Password: cheesebread

Virtual Device: 
- Name: demo_cloud

---

### Docker Registry Zugang <!-- omit in toc -->

---

### Simulator Device <!-- omit in toc -->

Raspberry Pi:
- Address: 192.168.24.42
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

iot device

---

## Docker Image

---

## Datenformat


---

## Routing

---

## Deployment 
1. Deployment file
2. Deployment ausführen
3. Deployment status überprüfen
   1. Per CLI
   2. Auf dem Device
4. Deployment löschen

---

## Nutzung der Daten
1. Datenvisualisierung mit Grafana
2. Datenexport mit NATS


--- 

