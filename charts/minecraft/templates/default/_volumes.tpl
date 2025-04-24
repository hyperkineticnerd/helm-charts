{{- define "minecraft.storage.pvName" -}}
{{- if .Values.storage.nfs.enabled -}}
{{ printf "nfs-%s" .Values.modpack.slug }}
{{- else -}}
{{ printf "pv-%s" .Values.modpack.slug }}
{{- end -}}
{{- end -}}


{{- define "minecraft.storage.pvcName" -}}
{{ printf "%s-data-claim" .Values.modpack.slug }}
{{- end -}}


{{- define "minecraft.default.volumes" -}}
- name: minecraft-server-files
  configMap:
    name: {{ .Values.modpack.slug }}-server-files
- name: minecraft-data
  persistentVolumeClaim:
    claimName: {{ include "minecraft.storage.pvcName" . }}
{{- end -}}


{{- define "minecraft.default.volumeMounts" -}}
- name: minecraft-server-files
  mountPath: /extras
- name: minecraft-data
  mountPath: /data
{{- end -}}
