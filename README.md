# Bubble project

## 운영

/admin 페이지로 접속합니다. 먼저 로그인 한 뒤에 접속해야 합니다. 운영자가 아니거나 로그인 하지 않으면 첫 페이지로 이동합니다.

## 실환경 구축 방법

[reCAPTCHA API key](https://www.google.com/recaptcha)를 얻어서 /data/bubble/shared/config/env.yml에 등록합니다.

```
production:
  ....
  RECAPTCHA_PUBLIC_KEY: 'xxx'
  RECAPTCHA_PRIVATE_KEY: 'yyy'
```

페이스북, 트위터, 네이버를 연결합니다. 각 키는 /data/bubble/shared/config/env.yml에 등록합니다. 트위터는 사용자 email을 얻어오기 위해 twitter에 따로 요청해야합니다.

```
production:
  ...
  FACEBOOK_APP_ID: xx
  FACEBOOK_APP_SECRET: xx
  TWITTER_APP_ID: xx
  TWITTER_APP_SECRET: xx
  NAVER_KEY: xx
  NAVER_SECRET: xx
  SLACK_WEBHOOK_URL: xx
```

## 로컬 개발 환경 구축 방법

기본적인 Rail 개발 환경에 rbenv, pow/powder를 이용합니다.

```
$ rbenv install 2.2.3
$ bundle install
$ bundle exec rake db:migrate
```

### 소스관리 설정

반드시 https://github.com/awslabs/git-secrets를 설치하도록 합니다. 설치 후에 반드시 https://github.com/awslabs/git-secrets#installing-git-secrets 이 부분을 참고하여 로컬 레포지토리에 모두 설정 합니다.

```
$ git secrets --install
$ git secrets --register-aws
```

그리고 데이터베이스는 각 레포지토리마다 다릅니다. 아래 git hook 을 설정합니다

```
$ echo $'#!/bin/sh\nif [ "1" == "$3" ]; then spring stop && powder restart; fi' > .git/hooks/post-checkout
$ chmod +x .git/hooks/post-checkout
```

### 데이터베이스 준비

#### mysql 설정
mysql을 구동해야합니다. mysql의 encoding은 utf8mb4를 사용합니다. mysql은 버전 5.6 이상을 사용합니다.

encoding세팅은 my.cnf에 아래 설정을 넣고 반드시 재구동합니다. 참고로 맥에선 /usr/local/Cellar/mysql/(설치하신 mysql버전 번호)/my.cnf입니다.

```
[mysqld]
innodb_file_format=Barracuda
innodb_large_prefix = ON
```

#### 연결 정보

프로젝트 최상위 폴더에 local_env.yml이라는 파일을 만듭니다. 데이터베이스 연결 정보를 아래와 예시를 보고 적당히 입력합니다.

```
development:
  database:
    username: 사용자이름
    password: 암호
```


#### 스키마

db:create와 db:migrate로 생성합니다.

#### 초기 데이터 추가

[mbleigh/seed-fu](https://github.com/mbleigh/seed-fu) 을 이용하여 설정된 초기 데이터를 로딩합니다.

```
$ source .powenv
$ bundle exec rake db:seed_fu
```
