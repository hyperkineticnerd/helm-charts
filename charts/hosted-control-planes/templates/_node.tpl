{{/*
NodePool.spec
*/}}
{{- define "hosted-control-planes.node-pool.spec" -}}
arch: amd64
clusterName: {{ .Release.Name }}
replicas: 2
management:
{{- include "hosted-control-planes.node-pool.management" . | nindent 4 }}
platform:
{{- include "hosted-control-planes.node-pool.platform" . | nindent 4 }}
release:
  image: {{ .Values.release.image }}
{{- end }}

{{/*
NodePool.platform
*/}}
{{- define "hosted-control-planes.node-pool.management" -}}
autoRepair: false
upgradeType: Replace
{{- end }}


{{/*
NodePool.platform
*/}}
{{- define "hosted-control-planes.node-pool.platform" -}}
type: KubeVirt
kubevirt:
  compute:
    cores: 4
    memory: 16Gi
  rootVolume:
    type: Persistent
    persistent:
      size: 32Gi
  attachDefaultNetwork: true
{{- end }}
