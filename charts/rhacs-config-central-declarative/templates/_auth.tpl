{{/* 
*/}}
{{- define "rhacs-config-central-declarative.declarative-configurations.auth" -}}
name: OpenShift
minimumRole: {{ default "Analyst" .Values.minimumRole }}
uiEndpoint: {{ .Values.centralEndpoint }}
{{- if .Values.centralReencryptEndpoint }}
extraUIEndpoints:
  - {{ .Values.centralReencryptEndpoint }}
{{- end -}}
{{ range .Values.groups }}
groups:
  - key: groups
    value: {{ .name }}
    role: {{ .role }}
{{ end -}}
openshift:
  enable: true
{{- end -}}
