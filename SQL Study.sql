1 SELECT 보고싶은 칼럼 (다보고싶은면 *)
2 FROM 테이블 (다보고싶으면 *)
3 WHERE 로우 대이터 행 필터링 (다조건시 and or)
4 GROUPE BY 그루핑 칼럼으로 집계
5 HAVING 집계된 데이터를 필터링
6 ORDER BY 정렬 dsc 내림차순 
7 delete 지우기 
8 distinct 중복제거
9 union 집합연산 중복제거, union all 중복제거 안됨
10 like 
11 between

add 테이블에 새로운 컬럼을 추가시 사용
예) alter table emp add (addr varchar2(50)) = varchar2의 데이터 형을 가지는 addr 컬럼이 emp 테이블에 추가됨

modify 테이블에 컬럼을 수정 하거나 not null 컬럼으로 변경
예) alter table emp modify (ename Varchar2(50)not null)

drop 테이블의 특정 컬럼을 삭제시 사용
예) alter table table_name drop column column_name

rename 기존 컬럼의 이름을 변경
예) alter table 테이블명 rename column '변경해야 할 컬럼명' to '새로운 컬럼명'





select *
from emp
;

select empno, ename, sal, mgr, job
from emp
where sal >=2000
or job = 'MANAGER' ;

select empno, ename, sal, mgr, job
from emp
where sal >=2000 엑셀에서 필터링하는 조건 
or job = 'MANAGER' 
and empno >=7500; 이럴경우에는 and 연산을 먼저 한다 ;


select empno, ename, sal, mgr, job
from emp
where ename like 'A%' 이름에 A로 시작하는 놈 출력
;

select empno, ename, sal, mgr, job
from emp
where ename like '%AR%'; 이름에 A가 들어간 놈 출력
;


select empno, ename, sal, mgr, job
from emp
where job in ('CLERK', 'SALESMAN', 'MANAGER');


select empno, ename, sal, mgr, job
from emp
where job = 'CLERK' OR JOB= 'SALESMAN' OR JOB= 'MANAGER'; 위에 sql 값이랑 출력값이 동일 



SELECT EMPNO, ENAME, SAL, MGR, JOB
FROM EMP
WHERE JOB IN ('CLERK', 'SALESMAN', 'MANAGER');



SELECT EMPNO, ENAME, SAL, MGR, JOB
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000; 2000에서 3000이하 값 출력; AND 조건을 먼저 계산한다 

SELECT   DEPTNO
    ,  COUNT(*)               "부서원 수"
    ,  MIN(EMPNO)  AS         "사번"
    ,  SUM(SAL)                합계
    ,  ROUND(AVG(SAL), 1)      평균
    ,  MAX(SAL)                맥스

    
FROM     EMP

GROUP BY DEPTNO;
--HAVING COUNT(*) > 3
ORDER BY DEPTNO DESC;
WHERE    SAL > 2500

SELECT DEPTNO
    ,  COUNT(*)               "부서원 수"
    ,  ROUND(AVG(SAL), 1)      평균
    ,  MAX(SAL)                맥스
FROM   EMP
WHERE SAL >2500
GROUP BY DEPTNO
-- HAVING   COUNT(*) > 3
ORDER BY DEPTNO DESC


alter table emp
add constrant pk_emp primary key (empno);

alter table dept
add constrant pk_emp primary key (empno);

alter table emp
modify ename varchard2(50) not null; 


select * from dept;

insert into deptn (deptno, dname,   loc)
values            (50,     '교육부', '상암동' );

select * from emp;

insert into emp
            (empno, ename, job, mgr, sal, deptno)
values( 8001, '홍길동', '과장', null, 5000, 10);
commit;
rollback;
select * from emp;

select * from dept;

insert into deptn (deptno, dname,   loc)
values            (50,     '교육부', '상암동' );

select * from emp;

insert into emp
            (empno, ename, job, mgr, sal, deptno)
values( 8002, '이순신', '통제사', null, 5000, 10);
commit;
rollback;
select * from emp;



insert into emp
values (8003, '김유신', '장군', null, null, 10000, 
        null,
        30);
commit;

select empno, ename, sal
     , to_char(hiredate, 'yyyy-mm-dd hh24:mi:ss') hiredate
from   emp;

insert into emp (empno, ename, sal, hiredate, deptno)
values          (8005, '임꺽정', 1000
               , to_date('2020.05.21 134800', 'yyyy.mm.dd hh24miss')
               , 20);
select * from emp order by empno;
               
-- empno => 8005               
update emp
set    hiredate=to_date('20100101', 'yyyymmdd')
    ,  comm    = 300
    ,  sal     = 80000, ename ='구병진'
where empno = 8005;

select * from emp;

delete from emp 
where sal >= 3000;
rollback;

문제) emp 테이블을 아래의 조건을 만족하는 것을 삭제하세요.

sal 칼럼이 2000 이상이며, comm이 not null 또는 deptno 칼럼이 20인건;

select * 
from        emp
where       sal  >  2000 
and         comm     is not null
or          deptno = 20; 

rollback;

select distinct job, deptno
from emp
order by job, deptno;

select job, deptno
from emp
union 
select job, deptno
from emp;

select e.empno, e.ename, e.sal, e.comm
     , d.deptno, d.dname, d.loc
from   emp  e
     , dept d
where  e.sal >= 2000
and    d.deptno = e.deptno
and    d.loc  = 'NEW YORK';

EMP 테이블에서
ENAME, SAL, COMM, HIREDATE
DEPT 테이블에서 
DEPTNO, DNAME, LOC
조회조건
SAL>2000
HIREDATE 19810101 - 20001231
;

select e.ename, e.sal, e.comm
     , to_char(e.hiredate, 'yyyy.mm.dd' )
     , d.deptno, d.dname, d.loc
from   emp e, dept d
where  e.sal > 2000
and    e.hiredate between to_date('19810101', 'yyyymmdd')
                  and     to_date('20001231', 'yyyymmdd')
and    d.deptno = e.deptno;