# Virus Scan Action

## Description

This action can be used to scan the repository of a workflow it used in or it can be used to scan a list of images. ClamAV's clamscan is used for virus scanning. Methodology for virus scanning images was adopted from [Dagda](https://github.com/eliasgranderubio/dagda)

## Requirements

* Bash V4. Older versions may work by replace readarray with something similar to:
`IFS=$'\n' read -a images <<< $(cat $images_filename)`

## Input

### mode

Required

This indicates which scanning mode will be used. The two modes are as follows:

* `single`

This mode will cause the repository using the action to be scanned.

* `multi`

This mode will indicate that a text file containing images that should be scanned will be provided with the `image-filename` input.

### image-filename

Optional

This indicates the file that contains the images that should be scanned. This should only be used when the input "mode" is set to `multi`.

## Example

### Example workflow using virus scan action in 'multi' mode

```yaml
on: [push]

jobs:
  virus_scan:
    runs-on: ubuntu-latest
    name: Scan for viruses.
    steps:
      - uses: actions/checkout@v2
      - run:  unset GOPATH
      - run: ./scripts/generate-images.sh
      - id: virus-scan
        uses: rancher/virus-scanning@v1
        with:
          mode: 'multi'
          image-filename: 'rancher-images-v2.6.txt' 
      - run: echo 'Scanned files:'
      - run: cat rancher-images-v2.6.txt
```

### Example output

... Numerous logs will be printed from ClamAv/clamscan and bash scripts.
The logs should be appended with something like the following:

```bash
Infected file(s) found in following image(s): infected-image1:tag, infected-image2:tag
```
