-- 1. 영어영문학과, 학번, 이름, 입학년도
SELECT STUDENT_NO "학번", STUDENT_NAME "이름", ENTRANCE_DATE "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 이름 ASC;

-- 2. 이름 세글자 아닌 교수 이름, 주민번호 출력

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(professor_name) != 3;





-- 3. 남자교수의 이름 나이 출력, 나이가 적은 사람 순으로 출력
SELECT PROFESSOR_NAME "교수 이름", 
        --  1. 교수 주민번호로 출생년도 추출, 하지만 49년도의 경우, RR로 걸러낼 수 없고, 2049로 설정됨, 조건 설정 해줌
        CASE WHEN EXTRACT(YEAR FROM (TO_DATE(SUBSTR(PROFESSOR_SSN,1,2), 'RRRR'))) > 2000 
        --  2. 조건에 걸렸을 때, 100살 빼주면 해결!
        THEN TO_CHAR(SYSDATE, 'YYYY') - (EXTRACT(YEAR FROM (TO_DATE(SUBSTR(PROFESSOR_SSN,1,2), 'RRRR'))) - 100)
        --  3. 그렇지 않으면, 그대로 빼주면됨.
        ELSE TO_CHAR(SYSDATE, 'YYYY') - (EXTRACT(YEAR FROM (TO_DATE(SUBSTR(PROFESSOR_SSN,1,2), 'RRRR')))) 
        END
        "나이"
        

FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY "나이" ASC;


SELECT  PROFESSOR_NAME,
        CASE WHEN FLOOR((SYSDATE - (TO_DATE(SUBSTR(PROFESSOR_SSN,1,6), 'RRMMDD')))/365) < 0
        THEN FLOOR((SYSDATE - (TO_DATE(SUBSTR(PROFESSOR_SSN,1,6), 'RRMMDD')))/365) + 100
        ELSE FLOOR((SYSDATE - (TO_DATE(SUBSTR(PROFESSOR_SSN,1,6), 'RRMMDD')))/365)
        END "나이"
        
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY "나이" ASC;


-- 4. 교수이름을 성 제외하고 출력

SELECT SUBSTR(PROFESSOR_NAME, 2,2) "이름"
FROM TB_PROFESSOR;

-- 5. 춘대학 재수생 (20살에 입학하면 재수생) 출력
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
--       입학년도에서 년도 추출              -  학생 주민번호에서 년도 추출           = 나이 계산   
WHERE (EXTRACT(YEAR FROM ENTRANCE_DATE)) - (EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6)))) = 20;


-- 6. 2020년 크리스마스는 무슨 요일?
SELECT TO_CHAR(TO_DATE('20201225'), 'DAY') "2020년 크리스마스" FROM DUAL;

-- 7. 각각 몇년 몇월 몇일 인가?

-- YY는 이번 세기
SELECT TO_DATE('99/10/11', 'YY/MM/DD') FROM DUAL; -- 2099년 10월 11일
SELECT TO_DATE('49/10/11', 'YY/MM/DD') FROM DUAL; -- 2049년 10월 11일

-- RR > 50 이번 세기, RR <= 50 지난 세기
SELECT TO_DATE('99/10/11', 'RR/MM/DD') FROM DUAL; -- 1999년 10월 11일
SELECT TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL; -- 2049년 10월 11일

-- 8. 2000년도 이전 학번을 받은 학생들의 학번과 이름 출력

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 1, 1) != 'A';

