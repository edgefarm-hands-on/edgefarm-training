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

# Known Bugs/ Current Limitations / Errata

**1.** Combined `application-network` with participating `edge-worker` components in the same yaml file cannot be updated due to current limitations of `EdgeFarm.network`. 

**Workaround:**
- Split up `edge-worker` and `application-network` in different files. Updating the `edge-worker` components does work.
- Currently, the `application-network` cannot be updated and needs to be deleted completely when making changes to the network configuration.

---

**2**: The first sent data is lost in aggregating jetstreams for approx. 10 seconds after starting up the edge applications.

**Workaround:**
- To be safe, wait approx. 30 seconds after the connection to DAPR was successfull.

---

**3.** **TO BE DELETED WHEN FIXED** Aggregate streams are not cleaned up properly. Even after deleting the `application-network` the aggregate streams are not cleaned up

**Workaround:**
- Either: predefine the correct characteristics of the Stream and never try to change it
- Or: Delete the network, rename the aggregate jetstream in the manifest and create a new network. Note, that the space of the old aggregate streams are not cleaned up.
