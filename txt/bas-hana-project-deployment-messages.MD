```
> Executing task: echo 'Prepared environment for deployment' && (npm ls --depth 0 --production || npm install) && (npm start -- --exit) <

Prepared environment for deployment
npm WARN config production Use `--omit=dev` instead.
deploy@ /home/user/projects/hana-cf-get-started-trial/db
`-- UNMET DEPENDENCY @sap/hdi-deploy@^4

npm ERR! code ELSPROBLEMS
npm ERR! missing: @sap/hdi-deploy@^4, required by deploy@

npm ERR! A complete log of this run can be found in:
npm ERR!     /home/user/.npm/_logs/2022-10-06T17_14_33_711Z-debug-0.log

added 31 packages in 4s
npm notice 
npm notice New minor version of npm available! 8.11.0 -> 8.19.2
npm notice Changelog: https://github.com/npm/cli/releases/tag/v8.19.2
npm notice Run npm install -g npm@8.19.2 to update!
npm notice 

> start
> node node_modules/@sap/hdi-deploy/deploy.js --auto-undeploy --exit "--exit"

@sap/hdi-deploy, version 4.4.1 (mode default), server version 4.00.000.00.1664279080 (4.0.0.0), node version 16.16.0, HDI version 1009, container API version 1004
Deployment started at 2022-10-06 17:14:38
Using hana-client for connection
Using default environment variables from file "default-env.json"
No ignore file at /home/user/projects/hana-cf-get-started-trial/db/.hdiignore.
Collecting files...
Collecting files... ok (0s 2ms)
1 directories collected
2 files collected
0 reusable modules collected
Target service: my-hdi-20221006
Session variable APPLICATION is set to "SAP_HDI//".
Could not determine status of last build: Could not find any information about the previous deployment.
Processing revoke files...
Processing revoke files... ok (0s 0ms)
Processing grants files...
Processing grants files... ok (0s 0ms)
Preprocessing files...
Preprocessing files... ok (0s 0ms)
Connecting to the container "DB_1"...
Connecting to the container "DB_1"... ok (0s 113ms)
Locking the container "DB_1"...
Locking the container "DB_1"... ok (0s 300ms)
Synchronizing files with the container "DB_1"...
  Deleting files...
  Deleting files... ok
  Writing files...
  Writing files... ok
Synchronizing files with the container "DB_1"... ok (0s 528ms)
added files: [
  "src/.hdiconfig",
  "src/community.hdbtable"
]
modified files: []
deleted files: []
2 modified or added files are scheduled for deploy based on delta detection
0 deleted files are scheduled for undeploy based on delta detection (filtered by undeploy allowlist)
0 files are scheduled for deploy based on explicit specification
0 files are scheduled for undeploy based on explicit specification
Deploying to the container "DB_1"...
Polling messages for request id: 35
 Starting make in the container "DB_1" with 2 files to deploy, 0 files to undeploy... 
  Disabling table replication for the container schema "DB_1"... 
  Disabling table replication for the container schema "DB_1"... ok  (0s 9ms)
  Migrating libraries... 
  Migrating libraries... ok  (0s 10ms)
  Making... 
   Preparing... 
   Preparing the make transaction... 
   Preparing the make transaction... ok  (0s 633ms)
   Deploying the configuration file "src/.hdiconfig"... 
   Warning: Could not find a configured library that contains the "com.sap.hana.di.afllangprocedure" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.cds" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.fulltextindex" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.textconfig" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.textdictionary" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.textminingconfig" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.textrule" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.textrule.include" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.textrule.lexicon" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Warning: Could not find a configured library that contains the "com.sap.hana.di.virtualfunctionpackage.hadoop" build plugin [8211539]
     at "src/.hdiconfig" (0:0)
   Deploying the configuration file "src/.hdiconfig"... ok  (0s 62ms)
   Adding "src/community.hdbtable" for deploy... 
   Adding "src/community.hdbtable" for deploy... ok  (0s 21ms)
   Preparing... ok  (0s 791ms)
   Calculating dependencies... 
    Expanding... 
     Expanding "src/community.hdbtable"... 
     Expanding "src/community.hdbtable"... ok  (0s 9ms)
    Expanding... ok  (0s 55ms)
    Precompiling... 
     Precompiling "src/community.hdbtable"... 
     Precompiling "src/community.hdbtable"... ok  (0s 6ms)
    Precompiling... ok  (0s 18ms)
    Merging... 
    Merging... ok  (0s 26ms)
   Calculating dependencies... ok  (0s 164ms)
   Processing work list... 
    Deploying "src/community.hdbtable"... 
    Deploying "src/community.hdbtable"... ok  (0s 25ms)
   Processing work list... ok  (0s 37ms)
   Finalizing... 
   Finalizing... ok  (0s 98ms)
   Make succeeded (10 warnings): 2 files deployed (effective 2), 0 files undeployed (effective 0), 0 dependent files redeployed 
  Making... ok  (1s 226ms)
  Enabling table replication for the container schema "DB_1"... 
  Enabling table replication for the container schema "DB_1"... ok  (0s 40ms)
 Starting make in the container "DB_1" with 2 files to deploy, 0 files to undeploy... ok  (1s 326ms)
Deploying to the container "DB_1"... ok (1s 724ms)
No default-access-role handling needed; global role "DB_1::access_role" will not be adapted
Unlocking the container "DB_1"...
Unlocking the container "DB_1"... ok (0s 0ms)
Deployment to container DB_1 done [Deployment ID: none].
Deployment ended at 2022-10-06 17:14:42
(3s 912ms)

Terminal will be reused by tasks. 
```
