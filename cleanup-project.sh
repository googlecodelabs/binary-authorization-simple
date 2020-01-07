#!/bin/bash
#
# Copyright 2020 Google LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source ./vars.sh

gcloud container clusters delete $CLUSTER_NAME --zone $ZONE

gcloud container images delete $CONTAINER_PATH --force-delete-tags --quiet

gcloud container binauthz attestors delete $ATTESTOR_ID

curl -vvv -X DELETE \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    "https://containeranalysis.googleapis.com/v1/projects/${GOOGLE_CLOUD_PROJECT}/notes/${NOTE_ID}"

gcloud container binauthz policy import files/allow_all_policy.yaml