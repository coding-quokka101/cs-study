# 📌 Git 명령어 정리

| 분류 | 명령어 | 내용 설명 |
|------|---------|------------|
| 새로운 저장소 생성 | `git init` | `.git` 하위 디렉토리 생성 (폴더 생성 후, 그 안에서 실행) |
| 저장소 복제/다운로드 | `git clone <https://URL>` | 원격 저장소 복제/다운로드 |
|  | `git clone /로컬/저장소/경로` | 로컬 저장소 복제 |
|  | `git clone 사용자명@호스트:/원격/저장소/경로` | 원격 서버 저장소 복제 |
| add 및 commit | `git add <파일명>` | 특정 파일 변경 사항 추가 (Staging Area에 등록) |
|  | `git add *` | 모든 파일 변경 사항 추가 |
|  | `git add -A` | 변경된 모든 파일을 한 번에 추가 |
|  | `git commit -m "메시지"` | 커밋 생성 (변경사항 확정) |
| branch 작업 | `git branch` | 브랜치 목록 확인 |
|  | `git branch <브랜치 이름>` | 새 브랜치 생성 (local) |
|  | `git checkout -b <브랜치 이름>` | 브랜치 생성 + 이동 |
|  | `git checkout master` | master 브랜치로 이동 |
|  | `git branch -d <브랜치 이름>` | 브랜치 삭제 |
|  | `git push origin <브랜치 이름>` | 브랜치를 원격 서버에 전송 |
|  | `git push -u <remote> <브랜치 이름>` | 새 브랜치를 원격 저장소로 push |
|  | `git pull <remote> <브랜치 이름>` | 원격 저장소 변경 사항 다운로드 + 병합 |
| 변경 사항 발행 (push) | `git push origin master` | master 브랜치 변경사항 업로드 |
|  | `git push <remote> <브랜치 이름>` | 특정 브랜치 commit 업로드 |
|  | `git remote add origin <주소>` | 원격 저장소 주소 등록 |
|  | `git remote remove <주소>` | 원격 저장소 주소 삭제 |
| 갱신 및 병합 (merge) | `git pull` | 원격 저장소 변경 내용 가져와 병합 |
|  | `git merge <브랜치>` | 다른 브랜치의 수정 사항 병합 |
|  | `git add <파일명>` | 병합 충돌 해결 후 수정된 파일 스테이징 |
|  | `git diff <브랜치1> <브랜치2>` | 브랜치 간 변경 내용 비교 |
| 태그(tag) 작업 | `git log` | 커밋 기록 확인 및 식별자 부여 |
| 로컬 변경사항 되돌리기 | `git checkout -- <파일명>` | 로컬 변경사항을 이전 상태로 되돌림 |
|  | `git fetch origin` | 원격 저장소 상태만 가져오기(fetch) |
| reset 작업 | `git reset --soft <commit ID>` | 지정한 커밋으로 되돌아가되, 이후 변경사항(Working Directory + Staging Area)은 유지 |
|  | `git reset --hard <commit ID>` | 지정한 커밋 이후 변경사항을 모두 삭제 (완전히 초기화) |
|  | `git reset -merge` | 직전 merge 작업 취소 |
|  | `git reset --mixed <commit ID>` | 이후 변경사항은 유지하지만 Staging Area는 초기화 → 다시 `git add` 필요 |
| revert 작업 | `git revert <commit ID>` | 특정 커밋의 변경사항만 되돌리고, 결과를 새 커밋으로 생성 |
|  | `git revert <commit ID1>..<commit ID2>` | 여러 개의 커밋을 한꺼번에 revert (충돌 최소화) |
|  | `git revert --no-commit <commit ID>` | revert 실행하되 자동 커밋은 하지 않음 (Staging Area에만 올림) |
