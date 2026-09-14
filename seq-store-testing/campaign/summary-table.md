| id | fault | targets | hold s | blocks/s during | network stall s | worst node stall s | per-node reorgs | height backwards | milestone frozen s |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| p01-kill-inturn | kill | l2-el-1-validator | 46 | 0.78 | 11 | 64 | 0 | 1 | 10 |
| p02-kill-2of3 | kill | l2-el-2-validator,l2-el-3-validator | 93 | 0.90 | 7 | 7 | 0 | 0 | 11 |
| p03-kill-3of3 | kill | l2-el-1-validator,l2-el-2-validator,l2-el-3-validator | 64 | 0.00 | 95 | 95 | 0 | 0 | 95 |
| p04-pause-inturn | pause | l2-el-2-validator | 60 | 0.82 | 7 | 10 | 0 | 0 | 10 |
| p05-part-inturn-bor | partition | 1 vs 8 nodes | 91 | 0.73 | 12 | 89 | 0 | 1 | 9 |
| p06-part-inturn-cl | partition | 1 vs 8 nodes | 91 | 0.99 | 0 | 5 | 0 | 0 | 3 |
| p07-netem-inturn | netem-latency 800ms | l2-el-1-validator | 90 | 0.47 | 1 | 1 | 0 | 0 | 4 |
| p08-kill-inturn-cl | kill | l2-cl-3-validator | 61 | 1.00 | 0 | 0 | 0 | 0 | 3 |
| p09-kill-rabbit | kill | l2-cl-1-rabbitmq | 60 | 1.00 | 0 | 0 | 0 | 0 | 2 |
| p10-pause-3cl | pause | l2-cl-4-validator,l2-cl-5-validator,l2-cl-6-validator | 90 | 0.99 | 29 | 29 | 0 | 0 | 93 |
| p11-kill-witness4 | kill | l2-el-4-validator,l2-el-5-validator,l2-el-6-validator,l2-el-7-validator | 65 | 1.02 | 98 | 98 | 0 | 4 | 94 |
| p12-kill-rpc9 | kill | l2-el-9-rpc | 46 | 1.00 | 0 | 2 | 0 | 0 | 2 |
| p13-pause-3cl-long | pause | l2-cl-4-validator,l2-cl-5-validator,l2-cl-6-validator | 240 | 0.81 | 60 | 60 | 0 | 0 | 242 |
| p14-part-inturn-all | partition | 1 vs 17 nodes | 91 | 0.92 | 6 | 90 | 0 | 2 | 8 |
| p15-loss-inturn | netem-latency 1ms loss 30% | l2-el-3-validator | 90 | 0.78 | 2 | 2 | 0 | 0 | 2 |
| p16-kill-l1 | kill | el-1-geth-lighthouse | 121 | 1.00 | 0 | 0 | 0 | 0 | 2 |
| p17-kill-prod-cl | kill | l2-cl-1-validator,l2-cl-2-validator,l2-cl-3-validator | 93 | 1.01 | 0 | 0 | 0 | 0 | 94 |
| s01-pause-ingress | pause | ingress | 60 | 0.75 | 0 | 0 | 0 | 0 | 2 |
| s02-kill-ingress | kill | ingress | 45 | 0.78 | 1 | 1 | 0 | 0 | 2 |
| s03-kill-rp0 | kill | redpanda-0 | 61 | 1.00 | 0 | 0 | 0 | 0 | 2 |
| s04-kill-rp2 | kill | redpanda-0,redpanda-1 | 62 | 0.74 | 1 | 2 | 0 | 0 | 2 |
| s05-pause-gateways | pause | gateway-0,gateway-1,gateway-2 | 60 | 0.47 | 3 | 3 | 0 | 0 | 2 |
| s06-kill-envoy | kill | gateway | 45 | 0.71 | 4 | 4 | 0 | 0 | 3 |
| s07-netem-ingress | netem-latency 400ms | ingress | 90 | 0.67 | 0 | 0 | 0 | 0 | 2 |
| s08-part-ingress-rp | partition | 1 vs 3 nodes | 60 | 0.74 | 1 | 2 | 0 | 0 | 2 |
| s09-part-prod-store | partition | 3 vs 9 nodes | 61 | 0.61 | 2 | 2 | 0 | 0 | 2 |
| s10-kill-auditor | kill | auditor | 46 | 1.00 | 2 | 2 | 0 | 0 | 2 |
| s11-netem-gateway | netem-latency 400ms | gateway | 90 | 0.51 | 2 | 2 | 0 | 0 | 2 |
| s12-pause-gw0 | pause | gateway-0 | 60 | 1.00 | 0 | 0 | 0 | 0 | 2 |
| s13-netem-gw0 | netem-latency 400ms | gateway-0 | 90 | 1.00 | 0 | 0 | 0 | 0 | 2 |
