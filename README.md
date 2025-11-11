# NTPd in Docker (docker-compose) — pool.ntp.org ready

## Overview:
- A minimal repository to run ntpd via docker-compose, preconfigured to participate in pool.ntp.org.
- Default upstream servers are set to the Korea and Japan NTP servers (not pool.ntp.org).
- Serves NTP over UDP port 123.

## Key points:
- UDP 123 must be open on the host firewall and any upstream firewalls/NAT devices (both inbound and outbound).
- Run with docker-compose; simple “up -d” workflow.
- Includes a ready-to-use ntp.conf and docker-compose.yml.
- Suitable as a starting point to join pool.ntp.org (you still need to meet pool requirements and register your server).

## Usage:
- Adjust ntp.conf if you want to change or add regional pools.
- Bring up the service with docker-compose up -d.
- If you want ntpd to discipline the host clock, run with the SYS_TIME capability and ensure the container has permission to bind UDP/123.
- Expose/forward UDP 123 from the host to the container.
- Verify reachability from the internet and monitor offset/stats before registering with pool.ntp.org.

## Notes for pool.ntp.org participation:
- Ensure stable network, correct time, and good reachability on UDP 123.
- Prefer a static public IP and proper reverse DNS if possible.

## License:
- Unlicense (public domain dedication).


## 개요:
- docker-compose로 ntpd를 실행하는 최소 구성 저장소이며, pool.ntp.org 참여를 염두에 둔 기본 설정을 제공합니다.
- 기본 업스트림 서버는 한국 및 일본 NTP 서버(not pool.ntp.org)로 설정되어 있습니다.
- UDP 123 포트로 NTP 서비스를 제공합니다.

## 핵심 사항:
- 호스트와 상위 방화벽/NAT에서 UDP 123 포트(수신/발신)가 반드시 열려 있어야 합니다.
- docker-compose로 간단히 실행할 수 있습니다.
- ntp.conf와 docker-compose.yml이 포함되어 있습니다.
- pool.ntp.org 합류를 위한 출발점으로 사용할 수 있습니다(참여 요건 충족 및 등록은 별도로 필요).

## 사용 방법:
- 지역에 맞는 NTP 풀로 변경하려면 ntp.conf를 수정하세요.
- docker-compose up -d로 서비스를 시작합니다.
- 호스트 시계를 ntpd가 보정하도록 하려면 컨테이너에 SYS_TIME 권한을 부여하는 것을 권장합니다.
- 컨테이너로 UDP 123 포트를 노출/포워딩하세요.
- 인터넷에서의 도달성 및 시간 오프셋을 점검한 후 pool.ntp.org에 등록하세요.

## 참고:
- 안정적인 네트워크, 정확한 시간 유지, UDP 123 도달성 확보가 중요합니다.
- 가능하면 고정 공인 IP와 적절한 역방향 DNS를 권장합니다.

## 라이선스:
- Unlicense (퍼블릭 도메인 선언)