# nix-darwin

[English](README.md)

`nix-darwin`, `home-manager`, `nix-homebrew`, `sops-nix`를 이용해 macOS 설정을
선언적으로 관리하는 저장소입니다. 작은 aspect 모듈을 조합해 호스트별 구성을
만들며 Home Manager는 nix-darwin에 통합해 사용합니다.

## 이 저장소가 관리하는 것

- `modules/flake/`에서 처리하는 flake 구성과 호스트 설정 생성
- `modules/aspects/`에서 자동으로 불러오는 Darwin/Home Manager aspect
- `hosts/`에서 자동으로 불러오는 여러 호스트 선언
- `secrets/`와 `.sops.yaml`을 이용해 SOPS로 암호화한 시크릿
- 사용자 `poby`의 에디터, 브라우저, 터미널, 쉘, 데스크톱, SSH, CLI 도구
  설정

## 사전 요구사항

- Apple Silicon macOS (`aarch64-darwin`)
- flake 기능이 활성화된 Nix (`nix-command` + `flakes`)
- `just` (명령 실행기)
- `nh` (시스템 적용, 업데이트, 디버그, 정리 명령에서 사용)
- 다음 경로에 저장한 SOPS age 키:

```bash
~/.config/sops/age/keys.txt
```

## 저장소 구조

- `flake.nix`: `flake-parts` 진입점과 flake input 선언
- `Justfile`: 자주 쓰는 명령(`dry-run`, `switch`, `update`, `debug`, `fmt`,
  `up`, `upp`, `repl`, `history`, `clean`, `gcroot`)
- `modules/flake/`: 저장소 옵션, Darwin 구성, 공용 context 모듈
- `modules/aspects/`: 자동으로 불러오는 공개 aspect 진입 모듈. `base`,
  `homebrew`, `shell`, `hammerspoon`, `editor`, `browser`, `discord`,
  `desktop` 등을 정의합니다.
- `modules/aspects/_*/`: 자동 로딩에서 제외되는 내부 구현 트리. 공개 aspect가
  이 경로의 모듈을 직접 불러옵니다.
- `modules/aspects/_hammerspoon/`: `$HOME/.hammerspoon`으로 연결할
  Hammerspoon 설정
- `modules/aspects/_editor/`: NVF와 Zed 설정
- `modules/aspects/_browser/`: Zen Browser 정책, 프로필, 확장, 컨테이너,
  스페이스, 고정 탭 설정
- `modules/aspects/_secrets/`: `sops-nix` 시크릿 선언, age 키 경로, Home
  Manager `SOPS_AGE_KEY_FILE` 세션 변수 설정
- `hosts/`: 자동으로 불러오는 호스트 선언. 각 호스트에 `system`과 중첩 없는
  `features` 목록을 등록합니다.
- `dotfiles/`: 애플리케이션 설정 내보내기 파일. Nix 모듈 그래프에는 포함되지
  않습니다.
- `secrets/`: 용도별 암호화 시크릿 파일(`github.yaml`, `ssh.yaml`)

## 자주 쓰는 명령

```bash
# 사용 가능한 작업 보기
just

# 현재 컴퓨터의 hostname으로 빌드한 뒤 적용
just switch $(hostname)

# 상세 로그를 출력하며 빌드하고 적용
just debug $(hostname)

# 실제 빌드 없이 의존성 그래프 검증
just dry-run fenrir

# 저장소 루트에서 Nix 파일 포맷팅
just fmt .

# 모든 flake input을 업데이트한 뒤 적용
just update fenrir

# 특정 input 하나만 업데이트한 뒤 적용
just update fenrir nixpkgs

# 시스템을 적용하지 않고 모든 flake input 업데이트
just up

# 시스템을 적용하지 않고 특정 input 하나만 업데이트
just upp nixpkgs

# 시스템을 적용하지 않고 빌드 검증(예시 호스트: fenrir)
nix build .#darwinConfigurations.fenrir.system \
  --accept-flake-config \
  --extra-experimental-features 'nix-command flakes'

# 같은 검증을 Nix 명령으로 직접 실행
nix build .#darwinConfigurations.fenrir.system \
  --dry-run \
  --accept-flake-config \
  --extra-experimental-features 'nix-command flakes'

# 시스템 프로필 이력 확인 / 오래된 generation과 store 경로 정리 / GC root 확인
just history
just clean
just gcroot
```

## 설정 노트

- `flake.nix`는 `flake-parts`를 사용합니다. `./modules/flake`는 직접 불러오고
  `./modules/aspects`와 `./hosts`는 `import-tree`로 자동 로딩합니다.
- `hosts/fenrir.nix`와 `hosts/huginn.nix`는 사용할 수 있는 macOS 호스트를
  선언하고 각 호스트에 중첩 없는 feature 목록 하나를 연결합니다.
- `modules/flake/darwin-configurations.nix`는 각 호스트의
  `darwinConfigurations.<host>`를 생성하며 사용자 `poby`의 Home Manager를
  nix-darwin에 통합합니다.
- `modules/aspects/`가 호스트에서 선택할 feature를 정의합니다. 현재 목록은
  `base`, `nix-core`, `system-packages`, `homebrew`, `macos-defaults`,
  `activation`, `fonts`, `sudo-auth`, `shell`, `cli-tools`, `git`, `ssh`,
  `secrets`, `terminal`, `hammerspoon`, `editor`, `browser`, `discord`,
  `desktop`, `fenrir`, `huginn`입니다.
- `cli-tools` aspect는 `marp-cli`와 `zoxide`를 포함한 CLI 사용자 도구를
  관리합니다.
- `editor` aspect는 NVF와 Zed를 함께 불러옵니다. Zed는 Home Manager로
  관리하며 사용자 설정, keymap, task, debug 설정에는 mutable 옵션을
  적용합니다. `nix` 확장을 사용하고 Nix language server는 `nixd`,
  Nix formatter는 Alejandra로 설정합니다.
- `browser` aspect는 Home Manager로 Zen Browser를 관리합니다. 브라우저
  정책과 프로필 모듈은 `modules/aspects/_browser/`에 있습니다.
- Hammerspoon 앱은 `homebrew` cask 목록으로 설치하고 `hammerspoon` aspect는
  Home Manager를 통해 `modules/aspects/_hammerspoon/`을
  `$HOME/.hammerspoon`에 연결합니다.
- `modules/aspects/_*/`는 자동 로딩에서 제외된 내부 구현 경로입니다.
  `import-tree`는 경로에 `/_`가 들어가면 건너뛰므로 NVF 같은 내부 서브트리를
  따로 관리할 수 있습니다.
- Home Manager는 nix-darwin에 통합해 사용하며 별도의
  `homeConfigurations` 출력은 만들지 않습니다.

## 호스트 추가 방법

- `hosts/<hostname>.nix` 파일을 만듭니다.
- `repo.hosts.<hostname>.system`을 설정합니다.
- `repo.hosts.<hostname>.features`에 사용할 aspect 이름을 나열합니다.
- 호스트 전용 동작은 공유 feature를 수정하는 대신 `modules/aspects/`에 새
  aspect로 추가합니다.

## 시크릿

- 시크릿은 `secrets/*.yaml`에 암호화해 보관합니다.
- `.sops.yaml`은 `secrets/.*\.yaml`에 암호화 규칙을 적용합니다.
- Home Manager는 `secrets` aspect를 통해 용도별 SOPS 파일을 읽습니다.
  - `secrets/github.yaml`: `github_ssh_key`, `github_cli_token`
  - `secrets/ssh.yaml`: `kmeat_mac_mini_ssh_key`

## 트러블슈팅

- 자세한 평가 및 빌드 로그는 `just debug <hostname>`으로 확인합니다.
- 특정 호스트의 평가가 실패하면 해당 호스트가 `darwinConfigurations`에
  정의됐는지 확인합니다.
- 전체 시스템을 적용하기 전에 평가와 의존성 해결만 확인하려면
  `just dry-run <hostname>`을 실행합니다.
- 빌드는 성공했지만 설정이 제대로 반영되지 않았다면
  `just switch <hostname>`을 다시 실행한 뒤 활성 hostname과 설정값을
  확인합니다.
