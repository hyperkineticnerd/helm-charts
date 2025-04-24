{{- define "minecraft.default.pod.env" -}}
- name: EULA
  value: "TRUE"
{{- end -}}


{{- define "minecraft.default.pod.envFrom" -}}
- configMapRef:
    name: {{ .Values.modpack.slug }}-env
{{- end -}}


{{- define "minecraft.default.pod.ports" -}}
- name: minecraft
  containerPort: 25565
  protocol: TCP
{{- end -}}


{{- define "minecraft.default.pod.resources" -}}
{{- if .Values.deployment.resources | default dict -}}
{{ toYaml .Values.deployment.resources }}
{{- else -}}
requests:
  cpu: "4"
  memory: 12Gi
limits:
  cpu: "8"
  memory: 24Gi
{{- end -}}
{{- end -}}


{{- define "minecraft.default.pod.securityContext" -}}
{{- if .Values.deployment.securityContext | default dict -}}
{{ toYaml .Values.deployment.securityContext }}
{{- else -}}
allowPrivilegeEscalation: false
runAsNonRoot: true
capabilities:
  drop:
  - ALL
seccompProfile:
  type: RuntimeDefault
{{- end -}}
{{- end -}}


{{- define "minecraft.default.pod.containers" -}}
- name: server
  image: {{ default "itzg/minecraft-server:java17" .Values.global.image }}
  # imagePullPolicy: Always
  ports:
    {{- include "minecraft.default.pod.ports" . | nindent 4 }}
  resources:
    {{- include "minecraft.default.pod.resources" . | nindent 4 }}
  securityContext:
    {{- include "minecraft.default.pod.securityContext" . | nindent 4 }}
  env:
    {{- include "minecraft.default.pod.env" . | nindent 4 }}
  envFrom:
    {{- include "minecraft.default.pod.envFrom" . | nindent 4 }}
  volumeMounts:
    {{- include "minecraft.default.volumeMounts" . | nindent 4 }}
{{- end -}}
