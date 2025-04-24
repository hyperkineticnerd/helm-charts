{{- define "minecraft.labels.modpack.type" -}}
{{- if .Values.modpack.forge.enabled }}
modpack-type: Forge
{{- else if .Values.modpack.fabric.enabled }}
modpack-type: Fabric
{{- end }}
{{- end -}}


{{- define "minecraft.labels.modpack.source" -}}
{{- if .Values.modpack.curseforge.enabled }}
modpack-source: CurseForge
{{- else if .Values.modpack.feed_the_beast.enabled }}
modpack-source: Feed-The-Beast
{{- else if .Values.modpack.modrinth.enabled }}
modpack-source: Modrinth
{{- end }}
{{- end -}}


{{- define "minecraft.default.pod.selectors" -}}
{{- with .Values.modpack.commonLabels }}
{{- toYaml . }}
{{- end }}
modpack: {{ .Values.modpack.slug }}
{{- end -}}


{{- define "minecraft.default.pod.labels" -}}
{{- include "minecraft.default.pod.selectors" . }}
modpack-id: {{ .Values.modpack.slug_id | int64 | quote }}
{{- include "minecraft.labels.modpack.type" . }}
{{- include "minecraft.labels.modpack.source" . }}
modpack-version: {{ .Values.modpack.version }}
modpack-version-id: {{ .Values.modpack.version_id | int64 | quote }}
{{- end -}}
