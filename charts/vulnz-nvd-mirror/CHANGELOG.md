## 0.4.5

- Add kill signal capability to the container so supervisor can handle the shutdown gracefully
- Higher memory limit for the container

## 0.4.4

- Leave some memory for apache

## 0.4.3

- Fix resource limits being to restrictive by default, crashing the app

## 0.4.2

- upgrade vulnz to 7.1.0

## 0.4.1

- upgrade vulnz to 7.0.2
- remove predefined JAVA_OPT settings, set default memory limit instead

## 0.4.0

- adjust mounted PVC permissions to match app's user

## 0.3.2

- upgrade vulnz to 7.0.1

## 0.3.1

- fix vulnz image to match 7.0.0

## 0.3.0

- upgrade vulnz to 7.0.0

## 0.2.1

- fix OCI image version and coords

## 0.2.0
- update to ghcr.io/jeremylong/open-vulnerability-data-mirror 6.2.0

## 0.1.3

- Switch image back to j 6.0.1 including the cron-fix
- Update TrueCharts

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
