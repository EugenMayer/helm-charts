## 0.1.2

- Update TrueCharts

## 0.1.1

- Add debug flag
- Change back ghcr.io/eugenmayer/vulnz
- Better logging

## 0.1.0

Breaking change! Please be sure to set the NVD_API_KEY using the new way since the chart was reworked.

- Rework chart to base on TrueCharts.
- introduce persistence for downloaded cache
- Change to ghcr.io/jeremylong/open-vulnerability-data-mirror

## 0.0.3

- use temp. different docker image source `ghcr.io/eugenmayer/vulnz` instead of `ghcr.io/jeremylong/vulnz` until
  the PR https://github.com/jeremylong/Open-Vulnerability-Project/pull/114 has been merged and the official image has
  been released.
