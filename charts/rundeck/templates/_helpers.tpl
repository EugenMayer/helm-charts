{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rundeck.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rundeck.fullname" -}}
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
{{- define "rundeck.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Basic labels */}}
{{- define "rundeck.labels" }}
app.kubernetes.io/name: {{ template "rundeck.name" . }}
helm.sh/chart: {{ template "rundeck.chart" . }}
app.kubernetes.io/instance: {{.Release.Name }}
app.kubernetes.io/managed-by: {{.Release.Service }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rundeck.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "rundeck.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create a variable for the service name referenced in the ingress resource.
*/}}
{{- define "rundeck.serviceName" -}}
    {{- if .Values.nginx.enabled -}}
        {{- include "rundeck.fullname" . -}}-nginx
    {{- else -}}
        rundeck-backend
    {{- end -}}
{{- end -}}

{{/*
Create a variable for the service port referenced in the ingress resource.
*/}}
{{- define "rundeck.servicePort" -}}
    {{- if .Values.nginx.enabled -}}
        http
    {{- else -}}
        rundeck
    {{- end -}}
{{- end -}}