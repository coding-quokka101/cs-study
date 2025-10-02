#!/bin/sh

# 입력값 (디렉토리 이름)
DIR_NAME=$1
# 스크립트가 있는 폴더 기준 경로
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

if [ -z "$DIR_NAME" ]; then
  echo "사용법: '$0 [디렉토리명]'을 입력하면 신규 폴더가 생성됩니다."
  exit 1
fi

mkdir -p "$DIR_NAME/image"
cp "$SCRIPT_DIR/작성-가이드/template/README.md" "$DIR_NAME/README.md"

echo "✅ <$DIR_NAME> 디렉토리 생성 완료!"