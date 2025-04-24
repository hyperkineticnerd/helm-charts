{{- define "minecraft.modpack.env" -}}
{{- if .Values.modpack.forge.enabled }}
{{- include "minecraft.modpack.forge" . }}
{{- else if .Values.modpack.modrinth.enabled }}
{{- include "minecraft.modpack.modrinth" . }}
{{- else if .Values.modpack.fabric.enabled }}
{{- include "minecraft.modpack.fabric" . }}
{{- end }}
{{- if .Values.modpack.level -}}
{{- include "minecraft.modpack.level" . }}
{{- end -}}
{{- end -}}


{{- define "minecraft.modpack.extraEnv" -}}
{{- if .Values.modpack.extraEnv }}
{{- toYaml .Values.modpack.extraEnv }}
{{- end }}
{{- end -}}


{{- define "minecraft.modpack.level" -}}
{{- if .Values.modpack.level }}
LEVEL: {{ .Values.modpack.level }}
{{- end }}
{{- end -}}


{{- define "minecraft.modpack.forge" -}}
{{- if .Values.modpack.curseforge.enabled }}
{{- include "minecraft.modpack.forge.curseforge" . }}
{{- else if .Values.modpack.feed_the_beast.enabled }}
{{- include "minecraft.modpack.forge.ftb" . }}
{{- else -}}
TYPE: FORGE
FORGE_VERSION: {{ .Values.modpack.forge.version }}
GENERIC_PACK: {{ .Values.modpack.curseforge.page_url }}
{{- end }}
{{- end -}}


{{- define "minecraft.modpack.forge.curseforge" -}}
{{- if .Values.modpack.curseforge.auto }}
{{- include "minecraft.modpack.forge.curseforge.auto" . }}
{{- else -}}
TYPE: CURSEFORGE
CF_BASE_DIR: /data
{{- if .Values.modpack.curseforge.page_url }}
CF_SERVER_MOD: {{ .Values.modpack.curseforge.page_url }}
{{- end }}
{{- end }}
{{- end -}}


{{- define "minecraft.modpack.forge.curseforge.auto" -}}
TYPE: AUTO_CURSEFORGE
CF_SLUG: {{ .Values.modpack.slug_id | quote }}
CF_FILE_ID: {{ .Values.modpack.version_id | int64 | quote }}
{{- if .Values.modpack.curseforge.api_key }}
CF_API_KEY: {{ .Values.modpack.curseforge.api_key }}
{{- end }}
{{/*- if .Values.modpack.curseforge.page_url }}
CF_PAGE_URL: {{ .Values.modpack.curseforge.page_url }}
{{- end */}}
{{- end -}}


{{- define "minecraft.modpack.forge.ftb" -}}
TYPE: FTBA
FTB_MODPACK_ID: {{ .Values.modpack.slug_id | int64 | quote }}
FTB_MODPACK_VERSION_ID: {{ .Values.modpack.version_id | int64 | quote }}
{{- end -}}


{{- define "minecraft.modpack.fabric" -}}
TYPE: FABRIC
{{- end -}}


{{- define "minecraft.modpack.serverFiles" -}}
- name: minecraft-server-files
  configMap:
    name: {{ .Values.modpack.slug }}-server-files
{{- end -}}


{{- define "minecraft.modpack.modrinth" -}}
TYPE: MODRINTH
MODRINTH_LOADER: {{ .Values.modpack.modrinth.loader | quote }}
MODRINTH_MODPACK: {{ .Values.modpack.slug_id | quote }}
MODRINTH_VERSION: {{ .Values.modpack.version_id | quote }}
{{- end -}}
