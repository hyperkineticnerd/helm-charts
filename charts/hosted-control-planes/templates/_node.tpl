{{/*
NodePool.spec
*/}}
{{- define "hosted-control-planes.node-pool.spec" -}}
arch: amd64
clusterName: {{ .clusterName }}
replicas: {{ .replicas | default "2" }}
release:
  image: {{ .releaseImage }}
{{ include "hosted-control-planes.node-pool.management" . }}
{{ include "hosted-control-planes.node-pool.platform" . }}
{{ include "hosted-control-planes.node-pool.nodeLabels" . }}
{{ include "hosted-control-planes.node-pool.taints" . }}
{{- end -}}

{{/*
NodePool.management
*/}}
{{- define "hosted-control-planes.node-pool.management" -}}
management:
  autoRepair: false
  upgradeType: Replace
{{- end -}}


{{/*
NodePool.platform
*/}}
{{- define "hosted-control-planes.node-pool.platform" -}}
platform:
  type: KubeVirt
  kubevirt:
    compute:
      cores: 4
      memory: 16Gi
    rootVolume:
      type: Persistent
      persistent:
        size: 120Gi
    attachDefaultNetwork: true
{{- end -}}


{{/*
NodePool.nodeLabels
*/}}
{{- define "hosted-control-planes.node-pool.nodeLabels" -}}
{{- with .nodeLabels -}}
nodeLabels: {{ . }}
{{- end -}}
{{- end -}}


{{/*
NodePool.taints
*/}}
{{- define "hosted-control-planes.node-pool.taints" -}}
{{- with .taints -}}
taints: {{ . }}
{{- end -}}
{{- end -}}
