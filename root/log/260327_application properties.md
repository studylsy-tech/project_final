## application.properties 설정 파일 충돌 방지 가이드

팀 프로젝트 진행 시 각자의 로컬 DB 환경(비밀번호 등) 차이로 발생하는 pull/push 충돌을 방지하기 위한 설정입니다. 아래 절차를 따라 터미널에 명령어를 입력해 주세요.

---

### ⚠️ 사전 주의사항
**현재 application.properties 파일을 수정 중인 내용이 있다면, 명령어를 입력하기 전에 반드시 내용을 별도로 백업하거나 커밋(Commit)을 완료해 주시기 바랍니다.**

---

### 🚀 설정 방법

1. **프로젝트 폴더 진입**
   * IDE의 서버 또는 프로젝트 명에서 마우스 오른쪽 버튼 클릭
   * **Show In System Explorer** (또는 Reveal in Finder/Explorer) 클릭
   * 해당 프로젝트 폴더로 진입합니다.

2. **터미널 실행**
   * 프로젝트 루트 경로에서 터미널 또는 Git Bash를 엽니다.

3. **명령어 입력**
   * 아래 명령어를 복사하여 입력하세요.

```bash
git update-index --assume-unchanged target/m2e-wtp/web-resources/META-INF/maven/com.final/fin_project/pom.properties
```

---

### 💡 설정 결과

이 명령어를 입력한 후에는 로컬에서 본인의 DB 계정 및 비밀번호에 맞춰 파일을 수정하더라도, **Git이 변경 사항을 추적하지 않습니다.**

* **장점**: pull 또는 push 시 설정 파일로 인한 **충돌(Conflict) 에러**가 발생하지 않습니다.
* **유연성**: 각자의 로컬 환경에 맞게 자유롭게 수정하여 사용할 수 있습니다.

---

추가적으로 다른 경로의 설정 파일(예: src/main/resources/application.properties)도 동일한 처리가 필요하신가요? 혹은 이 설정을 다시 해제하는 방법이 궁금하시다면 말씀해 주세요.
