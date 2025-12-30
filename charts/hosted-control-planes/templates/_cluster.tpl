{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.labels" -}}
labels:
{{- if .Values.clusterSet.enabled }}
  cluster.open-cluster-management.io/clusterset: {{ .Values.clusterSet.name | quote }}
{{- end }}
{{- end }}


{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.spec" -}}
infraID: {{ .Release.Name }}
channel: {{ .Values.release.channel }}
kubeAPIServerDNSName: {{ printf "api.%s.%s" .Release.Name .Values.cluster.baseDomain }}
dns:
  baseDomain: {{ .Values.cluster.baseDomain }}
{{- include "hosted-control-planes.hosted-cluster.availability" . }}
{{ include "hosted-control-planes.hosted-cluster.etcd" . }}
{{ include "hosted-control-planes.hosted-cluster.platform" . }}
{{ include "hosted-control-planes.hosted-cluster.networking" . }}
{{ include "hosted-control-planes.hosted-cluster.services" . }}
{{ include "hosted-control-planes.hosted-cluster.configuration" . }}
release:
  image: {{ .Values.release.image }}
pullSecret:
  name: {{ printf "pullsecret-cluster-%s" .Release.Name }}
sshKey:
  name: {{ printf "sshkey-cluster-%s" .Release.Name }}
{{- end }}

{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.configuration" -}}
configuration:
  ingress:
    loadBalancer: {}
{{- end }}


{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.etcd" -}}
etcd:
  managementType: Managed
  managed:
    storage:
      type: PersistentVolume
      persistentVolume:
        size: 8Gi
{{- end }}


{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.networking" -}}
networking:
  networkType: OVNKubernetes
  clusterNetwork:
    - cidr: 10.132.0.0/14
  serviceNetwork:
    - cidr: 172.31.0.0/16
{{- end }}


{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.platform" -}}
platform:
  type: KubeVirt
  kubevirt:
    baseDomainPassthrough: true
{{- end }}


{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.services" -}}
services:
  - service: APIServer
    servicePublishingStrategy:
      type: LoadBalancer
      loadBalancer:
        hostname: {{ printf "api.%s.%s" .Release.Name .Values.cluster.baseDomain }}
  - service: OAuthServer
    servicePublishingStrategy:
      type: Route
  - service: OIDC
    servicePublishingStrategy:
      type: Route
  - service: Konnectivity
    servicePublishingStrategy:
      type: Route
  - service: Ignition
    servicePublishingStrategy:
      type: Route
{{- end }}


{{/*
*/}}
{{- define "hosted-control-planes.hosted-cluster.availability" -}}
{{- if .Values.ha.enabled }}
controllerAvailabilityPolicy: HighlyAvailable
{{- else }}
controllerAvailabilityPolicy: SingleReplica
{{- end }}
infrastructureAvailabilityPolicy: HighlyAvailable
{{- end }}
