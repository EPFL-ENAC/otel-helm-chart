{{- define "otel.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "otel.fullname" -}}
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

{{- define "otel.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "otel.labels" -}}
helm.sh/chart: {{ include "otel.chart" . }}
{{ include "otel.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "otel.selectorLabels" -}}
app.kubernetes.io/name: {{ include "otel.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "otel.componentLabels" -}}
{{ include "otel.labels" .ctx }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}

{{- define "otel.componentSelectorLabels" -}}
{{ include "otel.selectorLabels" .ctx }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}

{{- define "otel.collector.image" -}}
{{- $tag := .Values.collector.image.tag | default .Chart.AppVersion -}}
{{- printf "%s:%s" .Values.collector.image.repository $tag -}}
{{- end -}}
