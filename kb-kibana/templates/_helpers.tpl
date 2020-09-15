{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kb-kibana.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kb-kibana.fullname" -}}
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
{{- define "kb-kibana.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kb-kibana.labels" -}}
app.kubernetes.io/name: {{ include "kb-kibana.name" . }}
helm.sh/chart: {{ include "kb-kibana.chart" . }}
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
{{- define "kibanaConfigMapName" -}}
{{- $config_map_kibana := "kibana-configmap" -}}
{{- default .Release.Namespace -}}-{{- $config_map_kibana -}}
{{- end -}}

{{/*
Create the name of kibana service
*/}}
{{- define "kibanaServiceName" -}}
{{- $kibana_service_name := .Values.service.name -}}
{{- default .Release.Namespace -}}-{{- $kibana_service_name -}}
{{- end -}}

{{/*
Create the name of kibana service account to use
*/}}
{{- define "kibanaServiceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- $kibana_service_account_name := .Values.serviceAccount.name -}}
{{- default .Release.Namespace -}}-{{- $kibana_service_account_name -}}    
{{- end -}}
{{- end -}}

{{/*
Create the name of kibana credentials
*/}}
{{- define "kibanaCredentialsName" -}}
{{- $kibana_credentials := .Values.secretName -}}
{{- default .Release.Namespace -}}-{{- $kibana_credentials -}}
{{- end -}}

{{/*
Create the name of kibana tls secret
*/}}
{{- define "kibanaTlsSecretName" -}}
{{- $kibana_tls_secret := "kibana-tls-secret" -}}
{{- default .Release.Namespace -}}-{{- $kibana_tls_secret -}}
{{- end -}}

{{/*
Create the name of kibana ingress
*/}}
{{- define "kibanaIngressName" -}}
{{- $kibana_ingress_name := .Values.ingress.name -}}
{{- default .Release.Namespace -}}-{{- $kibana_ingress_name -}}
{{- end -}}

{{/*
Create the name of kibana deployment
*/}}
{{- define "kibanaDeploymentName" -}}
{{- $kibana_deployment_name := .Values.deployment.name -}}
{{- default .Release.Namespace -}}-{{- $kibana_deployment_name -}}
{{- end -}}

{{/*
Create url to elasticsearch deployment
*/}}
{{- define "elasticsearchUrl" -}}
{{- $elasticsearch_service_name := "elasticsearch-master" -}}
{{- default .Release.Namespace -}}-{{- $elasticsearch_service_name -}}
{{- end -}}
