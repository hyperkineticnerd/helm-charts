{{/*
*/}}
{{- define "hosted-control-planes.managed-cluster.metadata" -}}
metadata:
  name: {{ .Release.Name }}
  annotations:
{{- include "hosted-control-planes.managed-cluster.annotations" . | nindent 4 }}
  labels:
    name: {{ .Release.Name }}
{{- include "hosted-control-planes.managed-cluster.labels" . | nindent 4 }}
{{- end }}


{{/*
*/}}
{{- define "hosted-control-planes.managed-cluster.spec" -}}
spec:
  hubAcceptsClient: true
{{- end }}


{{/*
ManagedCluster.Annotations
*/}}
{{- define "hosted-control-planes.managed-cluster.annotations" -}}
import.open-cluster-management.io/hosting-cluster-name: local-cluster
import.open-cluster-management.io/klusterlet-deploy-mode: Hosted
open-cluster-management/created-via: hypershift
{{- end }}


{{/*
ManagedCluster.Labels
*/}}
{{- define "hosted-control-planes.managed-cluster.labels" -}}
{{- if .Values.clusterSet.enabled -}}
cluster.open-cluster-management.io/clusterset: {{ .Values.clusterSet.name | quote }}
{{- end }}
cloud: BareMetal
vendor: OpenShift
{{- end }}
