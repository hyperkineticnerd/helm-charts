{{/*
ClusterUserDefinedNetworkSpec
*/}}
{{- define "network-configuration-udn.cudn-spec" -}}
{{- if .Values.cudn }}
namespaceSelector: 
{{- include "network-configuration-udn.cudn-spec.namespaceSelector" . }}
network:
{{- include "network-configuration-udn.cudn-spec.network" . }}
{{- end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec NamespaceSelector
*/}}
{{- define "network-configuration-udn.cudn-spec.namespaceSelector" -}}
matchLabels:
{{- range $k,$v := .Values.matchLabels }}
{{- $k | nindent 2 }}: {{ $v | default "''" }}
{{- end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network
*/}}
{{- define "network-configuration-udn.cudn-spec.network" -}}
topology: {{ .Values.network.topology }}
{{ if eq .Values.network.topology "Layer2" }}
{{- include "network-configuration-udn.cudn-spec.network.layer2" . }}
{{ else if eq .Values.network.topology "Layer3" -}}
{{ include "network-configuration-udn.cudn-spec.network.layer3" . }}
{{ else if eq .Values.network.topology "Localnet" -}}
{{ include "network-configuration-udn.cudn-spec.network.localnet" . }}
{{ end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Layer2
*/}}
{{- define "network-configuration-udn.cudn-spec.network.layer2" -}}
layer2:
{{- include "network-configuration-udn.cudn-spec.network.role" . | nindent 2 }}
{{- include "network-configuration-udn.cudn-spec.network.subnets" . | nindent 2 }}
{{- include "network-configuration-udn.cudn-spec.network.ipam" . | nindent 2 }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Layer3
*/}}
{{- define "network-configuration-udn.cudn-spec.network.layer3" -}}
layer3:
{{- include "network-configuration-udn.cudn-spec.network.role" . | nindent 2 }}
{{- include "network-configuration-udn.cudn-spec.network.subnets" . | nindent 2 }}
{{- include "network-configuration-udn.cudn-spec.network.ipam" . | nindent 2 }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Localnet
*/}}
{{- define "network-configuration-udn.cudn-spec.network.localnet" -}}
localnet:
{{- include "network-configuration-udn.cudn-spec.network.role" . | nindent 2 }}
  physicalNetworkName: {{ .Values.network.physicalNetworkName }}
{{- include "network-configuration-udn.cudn-spec.network.ipam" . | nindent 2 }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network IPAM
*/}}
{{- define "network-configuration-udn.cudn-spec.network.ipam" -}}
ipam:
  mode: {{ .Values.network.ipam.mode }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Subnets
*/}}
{{- define "network-configuration-udn.cudn-spec.network.subnets" -}}
subnets:
{{- range .Values.network.subnets }}
  - {{ . | toYaml }}
{{- end }}
{{- end }}


{{/*
ClusterUserDefinedNetworkSpec Network Role
*/}}
{{- define "network-configuration-udn.cudn-spec.network.role" -}}
{{- if eq .Values.network.role "Primary" -}}
role: {{ .Values.network.role }}
{{- else if eq .Values.network.role "Secondary" -}}
role: {{ .Values.network.role }}
{{- end }}
{{- end }}
