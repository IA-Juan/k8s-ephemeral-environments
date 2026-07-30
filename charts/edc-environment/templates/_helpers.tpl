{{- define "edc.name" -}}

edc-environment

{{- end }}


{{- define "edc.fullname" -}}

{{ .Release.Name }}-web

{{- end }}