{{/*
Loop through sourceRepos
*/}}
{{- define "rhacm-gitops-project.project.source-repos" -}}
{{- if $.Values.sourceRepos }}
sourceRepos:
{{- range $key,$value := $.Values.sourceRepos }}
  - {{ $value | squote }}
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
  - group: {{ $value.group | squote }}
    kind: {{ $value.kind | squote }}
    {{- if $value.name }}
    name: {{ $value.name | squote }}
    {{- end }}
{{- end }}
{{- end }}
{{- end -}}
