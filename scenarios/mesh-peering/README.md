# Mesh Peering
  
In this scenario, we run two sample applications each in their own Datacenters. The dashboard application runs in DC2, which dials the counting application in DC1 via the Mesh Gateway. Both DCs are peered using Consul Cluster Peering introduced (Beta) in Consul 1.13.

## Diagram



## Instruction

```
$ docker-compose up -d
Creating network "mesh-peering_default" with the default driver
Creating mesh-peering_mesh-dc2_1          ... done
Creating mesh-peering_mesh-dc1_1          ... done
Creating mesh-peering_dashboard_1         ... done
Creating mesh-peering_consul-server-dc2_1 ... done
Creating mesh-peering_consul-server-dc1_1 ... done
Creating mesh-peering_counting_1          ... done
```

```
$ curl -s -X POST --data '{"PeerName": "dc2"}' http://localhost:8500/v1/peering/token | jq --arg peername dc2 '. + {PeerName: $peername}' | curl -s -X POST --data-binary @- http://localhost:7500/v1/peering/establish
{}
```

```
$ curl localhost:8500/v1/peerings?pretty
[
    {
        "ID": "f12c37b5-567b-47fe-fa67-2cf77b12f017",
        "Name": "dc2",
        "State": "ACTIVE",
        "ImportedServiceCount": 0,
        "ExportedServiceCount": 2,
        "CreateIndex": 17,
        "ModifyIndex": 17
    }
]
```

```
$ docker-compose exec dashboard curl localhost:5000
{"count":1,"hostname":"ff9c87b606dc"}
```
