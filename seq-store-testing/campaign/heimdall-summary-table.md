| id | fault | targets | hold s | blocks/s during | network stall s | worst node stall s | per-node reorgs | height backwards | milestone frozen s |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| h01-part-own-cl | partition | 1 vs 1 nodes | 90 | 0.86 | 14 | 105 | 0 | 0 | 15 |
| h02-pause-own-cl | pause | l2-cl-3-validator | 90 | 1.00 | 0 | 0 | 0 | 0 | 4 |
| h03-stop-own-cl | stop | l2-cl-2-validator | 61 | 1.02 | 0 | 0 | 0 | 0 | 4 |
| h04-part-all-cl-short | partition | 1 vs 9 nodes | 60 | 0.80 | 14 | 146 | 0 | 0 | 14 |
| h04r-restart-el1 | stop | l2-el-1-validator | 6 | 1.00 | 0 | 89 | 0 | 0 | 2 |
| h05-part-all-cl-span | partition | 1 vs 9 nodes | 150 | 0.89 | 17 | 141 | 0 | 0 | 15 |
| h05r-restart-el3 | stop | l2-el-3-validator | 6 | 1.33 | 0 | 58 | 0 | 0 | 4 |
| h06-pause-all-cl | pause | l2-cl-9-rpc,l2-cl-8-rpc-archive,l2-cl-7-validator,l2-cl-6-validator,l2-cl-5-validator,l2-cl-4-validator,l2-cl-3-validator,l2-cl-2-validator,l2-cl-1-validator | 61 | 0.09 | 65 | 70 | 11 | 2 | 10 |
| h07-kill-all-cl | kill | l2-cl-9-rpc,l2-cl-8-rpc-archive,l2-cl-7-validator,l2-cl-6-validator,l2-cl-5-validator,l2-cl-4-validator,l2-cl-3-validator,l2-cl-2-validator,l2-cl-1-validator | 72 | 0.14 | 86 | 86 | 9 | 2 | 2 |
| h08-netem-own-cl | netem | l2-cl-2-validator | 90 | 0.83 | 13 | 73 | 0 | 0 | 0 |
| h09-part-witness-all-cl-2 | partition | 1 vs 9 nodes | 0 | - | 0 | 0 | 0 | 0 | 0 |
| h09-part-witness-all-cl-3 | partition | 1 vs 7 nodes | 120 | 1.01 | 0 | 111 | 0 | 0 | 0 |
| h09-part-witness-all-cl | partition | 1 vs 9 nodes | 0 | - | 0 | 1 | 0 | 0 | 0 |
| h10-throttle-own-cl | throttle | l2-cl-2-validator | 91 | 1.01 | 0 | 0 | 0 | 0 | 2 |
