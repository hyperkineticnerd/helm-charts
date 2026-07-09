{{/*
Loop through sourceRepos
*/}}
{{- define "rhacm-gitops-project.project.source-repos" -}}
{{- if $.Values.sourceRepos }}
sourceRepos:
{{- range $key,$value := $.Values.sourceRepos }}
  - {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}


{{/*
Loop through clusterResourceWhitelist
*/}}
{{- define "rhacm-gitops-project.project.cluster-resource-whitelist" -}}
{{- if $.Values.clusterResourceWhitelist }}
clusterResourceWhitelist:
{{- range $key,$value := $.Values.clusterResourceWhitelist }}
  - {{ $value }}
{{- end }}
{{- end }}
{{- end -}}
