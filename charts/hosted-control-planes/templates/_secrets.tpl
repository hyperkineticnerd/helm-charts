{{/*
Secrets sshKey
*/}}
{{- define "hosted-control-planes.secrets.sshKey" -}}
'id_rsa.pub': {{ .Values.sshKey.key | quote }}
{{- end }}


{{/*
Secrets pullSecret
*/}}
{{- define "hosted-control-planes.secrets.pullSecret" -}}
'.dockerconfigjson': {{ .Values.pullSecret.secret | quote }}
{{- end }}
