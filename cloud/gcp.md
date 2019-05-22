


# gcloud command line examples

```
PROJECT_ID=XXX
INSTANCE_NAME=YYY
SERVICE_ACCOUNT=ZZZ

> gcloud compute --project=$PROJECT_ID
  instances create $INSTANCE_NAME
  --zone=asia-northeast1-c --machine-type=g1-small --subnet=default
  --network-tier=PREMIUM --maintenance-policy=MIGRATE
  --service-account=$SERVICE_ACCOUNT@developer.gserviceaccount.com
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append
  --image=ubuntu-minimal-1904-disco-v20190417 --image-project=ubuntu-os-cloud
  --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=$INSTANCE_NAME
```
