{{- define "openshift.scc.profile_name" }}
{{ printf "system:openshift:scc:%s"  .Values.scc.profile }}
{{- end }}
