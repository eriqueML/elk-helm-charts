{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kb-elastic.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kb-elastic.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kb-elastic.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kb-elastic.labels" -}}
app.kubernetes.io/name: {{ include "kb-elastic.name" . }}
helm.sh/chart: {{ include "kb-elastic.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of persistent volume
*/}}
{{- define "persistentVolumeName" -}}
{{- $persistent_volume_name := .Values.persistentVolume.name -}}
{{- default .Release.Namespace -}}-{{- $persistent_volume_name -}}
{{- end -}}

{{/*
Create the name of persistent volume claim
*/}}
{{- define "persistentVolumeClaimName" -}}
{{- $persistent_volume_claim_name := .Values.persistentVolumeClaim.name -}}
{{- default .Release.Namespace -}}-{{- $persistent_volume_claim_name -}}
{{- end -}}

{{/*
Create the name of elasticsearch configmap
*/}}
{{- define "esConfigMapName" -}}
{{- $config_map_es := "elasticsearch-configmap" -}}
{{- default .Release.Namespace -}}-{{- $config_map_es -}}
{{- end -}}

{{/*
Create the name of ror configmap
*/}}
{{- define "rorConfigMapName" -}}
{{- $config_map_ror := "readonlyrest-configmap" -}}
{{- default .Release.Namespace -}}-{{- $config_map_ror -}}
{{- end -}}

{{/*
Create the name of ror keystore configmap
*/}}
{{- define "rorKeystoreConfigMapName" -}}
{{- $config_map_rorkeystore := "readonlyrest-keystore-configmap" -}}
{{- default .Release.Namespace -}}-{{- $config_map_rorkeystore -}}
{{- end -}}

{{/*
Create the name of master service
*/}}
{{- define "masterServiceName" -}}
{{- $master_service_name := .Values.master.service.name -}}
{{- default .Release.Namespace -}}-{{- $master_service_name -}}
{{- end -}}

{{/*
Create the name of data service
*/}}
{{- define "dataServiceName" -}}
{{- $data_service_name := .Values.data.service.name -}}
{{- default .Release.Namespace -}}-{{- $data_service_name -}}
{{- end -}}

{{/*
Create the name of ingest service
*/}}
{{- define "ingestServiceName" -}}
{{- $ingest_service_name := .Values.ingest.service.name -}}
{{- default .Release.Namespace -}}-{{- $ingest_service_name -}}
{{- end -}}

{{/*
Create the name of master service account
*/}}
{{- define "masterServiceAccountName" -}}
{{- $master_service_account_name := .Values.master.serviceAccount.name -}}
{{- default .Release.Namespace -}}-{{- $master_service_account_name -}}
{{- end -}}

{{/*
Create the name of data service account
*/}}
{{- define "dataServiceAccountName" -}}
{{- $data_service_account_name := .Values.data.serviceAccount.name -}}
{{- default .Release.Namespace -}}-{{- $data_service_account_name -}}
{{- end -}}

{{/*
Create the name of ingest service account
*/}}
{{- define "ingestServiceAccountName" -}}
{{- $ingest_service_account_name := .Values.ingest.serviceAccount.name -}}
{{- default .Release.Namespace -}}-{{- $ingest_service_account_name -}}
{{- end -}}

{{/*
Create the name of master statefulSet
*/}}
{{- define "masterStatefulSetName" -}}
{{- $master_statefulset_name := .Values.master.name -}}
{{- default .Release.Namespace -}}-{{- $master_statefulset_name -}}
{{- end -}}

{{/*
Create the name of data statefulSet
*/}}
{{- define "dataStatefulSetName" -}}
{{- $data_statefulset_name := .Values.data.name -}}
{{- default .Release.Namespace -}}-{{- $data_statefulset_name -}}
{{- end -}}

{{/*
Create the name of ingest statefulSet
*/}}
{{- define "ingestStatefulSetName" -}}
{{- $ingest_statefulset_name := .Values.ingest.name -}}
{{- default .Release.Namespace -}}-{{- $ingest_statefulset_name -}}
{{- end -}}

{{/*
Create the names of discovery seed hosts for elasticsearch settings
*/}}
{{- define "kb-elastic.discoverySeedHosts" -}}
{{ include "masterServiceName" . }},
{{- if .Values.data.enabled -}}
{{ include "dataServiceName" . }},
{{- end -}}
{{- if .Values.ingest.enabled -}}
{{ include "ingestServiceName" . }},
{{- end -}}
{{- end -}}

{{/*
Create the names of initial master nodes for elasticsearch settings
*/}}
{{- define "kb-elastic.initialMasterNodes" -}}
{{- $replicas_master := int .Values.master.replicaCount -}}
{{- $master_fullname := include "masterStatefulSetName" . -}}
  {{- range $i, $e := until $replicas_master }}{{- $master_fullname -}}-{{ $e }}, {{- end -}}
{{- end -}}
