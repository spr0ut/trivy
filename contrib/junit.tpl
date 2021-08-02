<?xml version="1.0" ?>
<testsuites>
{{- range . -}}
{{- if (eq (len .Vulnerabilities) 0) -}}
    <testsuite tests="1" name="{{  .Target }}" errors="0" skipped="0" time="">
        <testcase classname="Trivy image vulnerability scan" name="No vulnerabilies found" time="">
        </testcase>
</testsuite>
{{ else -}}
{{- $failures := len .Vulnerabilities }}
    <testsuite tests="{{ $failures }}" failures="{{ $failures }}" name="{{  .Target }}" errors="0" skipped="0" time="">
    {{- if not (eq .Type "") }}
        <properties>
            <property name="type" value="{{ .Type }}"></property>
        </properties>
        {{- end -}}
        {{ range .Vulnerabilities }}
        <testcase classname="{{ .PkgName }}-{{ .InstalledVersion }}" name="[{{ .Vulnerability.Severity }}] {{ .VulnerabilityID }}" time="">
            <failure message="{{ escapeXML .Title }}" type="description">{{ escapeXML .Description }}</failure>
        </testcase>
    {{- end }}
    </testsuite>
{{- end }}
{{- end }}
</testsuites>
