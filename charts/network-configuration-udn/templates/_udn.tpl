
{{/*
ClusterUserDefinedNetworkSpec
*/}}
{{- define "network-configuration-udn.udn-spec" -}}
{{- if .Values.cudn }}
namespaceSelector: 
{{- include "network-configuration-udn.udn-spec.namespaceSelector" . }}
network:
{{- include "network-configuration-udn.udn-spec.network" . }}
{{- end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec NamespaceSelector
*/}}
{{- define "network-configuration-udn.udn-spec.namespaceSelector" -}}
matchLabels:
{{- range $k,$v := .Values.matchLabels }}
{{- $k | nindent 2 }}: {{ $v | default "''" }}
{{- end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network
*/}}
{{- define "network-configuration-udn.udn-spec.network" -}}
topology: {{ .Values.network.topology }}
{{ if eq .Values.network.topology "Layer2" }}
{{- include "network-configuration-udn.udn-spec.network.layer2" . }}
{{ else if eq .Values.network.topology "Layer3" -}}
{{ include "network-configuration-udn.udn-spec.network.layer3" . }}
{{ end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Layer2
*/}}
{{- define "network-configuration-udn.udn-spec.network.layer2" -}}
layer2:
{{- include "network-configuration-udn.udn-spec.network.role" . | nindent 2 }}
{{- include "network-configuration-udn.udn-spec.network.subnets" . | nindent 2 }}
{{- include "network-configuration-udn.udn-spec.network.ipam" . | nindent 2 }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Layer3
*/}}
{{- define "network-configuration-udn.udn-spec.network.layer3" -}}
layer3:
{{- include "network-configuration-udn.udn-spec.network.role" . | nindent 2 }}
{{- include "network-configuration-udn.udn-spec.network.subnets" . | nindent 2 }}
{{- include "network-configuration-udn.udn-spec.network.ipam" . | nindent 2 }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network IPAM
*/}}
{{- define "network-configuration-udn.udn-spec.network.ipam" -}}
ipam:
  lifecycle: {{ .Values.network.ipam.lifecycle }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Subnets
*/}}
{{- define "network-configuration-udn.udn-spec.network.subnets" -}}
subnets:
{{- range .Values.network.subnets }}
  - {{ . | toYaml }}
{{- end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Role
*/}}
{{- define "network-configuration-udn.udn-spec.network.role" -}}
{{- if eq .Values.network.role "Primary" -}}
role: {{ .Values.network.role }}
{{- else if eq .Values.network.role "Secondary" -}}
role: {{ .Values.network.role }}
{{- end }}
{{- end }}
