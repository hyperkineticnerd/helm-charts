{{- define "minecraft.default.service.ports" -}}
- name: minecraft
  port: {{ .Values.service.externalPort }}
  targetPort: {{ .Values.server.serverPort }}
  {{- if eq .Values.service.serviceType "NodePort" }}
  nodePort: {{ .Values.service.nodePort }}
  {{- end }}
  protocol: TCP
{{- end -}}


{{- define "minecraft.default.service.annotations" -}}
{{- if $.Values.service.annotations -}}
annotations:
{{- with .Values.service.annotations  -}}
{{ toYaml . | nindent 2 }}
{{- end -}}
{{- end -}}
{{- end -}}


{{- define "minecraft.default.service.labels" -}}
labels:
{{- include "minecraft.default.pod.labels" . | nindent 2 }}
{{- end -}}
