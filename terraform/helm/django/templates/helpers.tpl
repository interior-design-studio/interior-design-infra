{{/*
Return the name of the chart
*/}}
{{- define "django-app.name" -}}
django-app
{{- end }}

{{/*
Return the full name (release-name + chart name)
*/}}
{{- define "django-app.fullname" -}}
{{ .Release.Name }}-{{ include "django-app.name" . }}
{{- end }}