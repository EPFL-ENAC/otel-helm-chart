# OTel (OpenTelemetry) Collector helm chart

## Test the chart

Create a myValues.yaml file:

```bash
echo "fullnameOverride: myotel
collector:
  config:
    receivers:
    processors:
  metrics:
    grafanaMonitor:
      enabled: false
" > myValues.yaml
```

Then test the chart

```bash
helm template myname . -f myValues.yaml
```
