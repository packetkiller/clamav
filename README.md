# ClamAV

ClamAV® is an open-source antivirus engine for detecting trojans, viruses, malware & other malicious threats.

https://www.clamav.net/

## Image

`harbor.deep.sev1tech.com/library/clamav`

## CI Components

### Secure Download

##### Description

Download a file from a given URL, verify checksums, and scan it with ClamAV's `clamscan`. If all check succeed, save it as the given filename as an artifact that can be made available to later stages of the pipeline

##### Usage

```
variables:
  TRIVY_VERSION: 0.48.1

include:
  - component: gitlab.deep.sev1tech.com/deep/public/pipeline-tools/clamav/secure-download@<version>
    inputs:
      name: download trivy
      download_base_url: https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}
      download_filename: trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz
      download_checksum_filename: trivy_${TRIVY_VERSION}_checksums.txt
      artifact_filename: trivy.tar.gz
```

##### Inputs

| Name | Description | Default |
| --- | --- | --- |
| `stage` | pipeline stage to place the job in | `download` |
| `job_image` | container image to run the job in | `harbor.deep.sev1tech.com/library/clamav:1.2.1` |
| `job_name_postfix` | string to append to `download ` to create the job name  | `null` |
| `download_base_url` | base url of the location for the download (generally a github release page) | `null` |
| `download_filename` | the filename to download from the base url | `null` |
| `download_checksum_filename` | checksum filename to use to verify file integrity | `null` |
| `artifact_filename` | filename to save the artifact as | `null` |

##### Artifacts

###### Files

| Name | Description |
| --- | --- |
| `<artifact_filename>` | Downloaded file |
| `clamscan-version.txt` | Version information for ClamAV |
| `clamscan.txt` | ClamScan Results |
