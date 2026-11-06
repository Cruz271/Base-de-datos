USE ejemplos_tipos_join;
select * from alumnos join matriculas using(id_alumno) join cursos using(id_curso);
SELECT * FROM alumnos a  LEFT JOIN matriculas m on a.id_alumno = m.id_alumno; -- aquí estoy usando solo la tabla de la izquierda y entonces sale toda la tabla de la izquierda aunque haya huecos
SELECT * FROM alumnos a  right JOIN matriculas m on a.id_alumno = m.id_alumno;
SELECT * FROM matriculas m right join alumnos a on m.id_alumno = a.id_alumno;
-- vamos con 3 tablas 
SELECT * FROM matriculas m left join alumnos a on m.id_alumno = a.id_alumno join cursos c on c.id_curso = m.id_curso;

-- saca el numero de matriculas en cursos inexistentes

select * from matriculas m left join cursos using(id_curso) where cursos.id_curso is null;

-- listado de cursos sin matrículas 

select * from matriculas m right join cursos using(id_curso) where id_matricula is null;

-- alumnos matriculados en cursos inexistentes

SELECT * FROM alumnos left JOIN matriculas USING(id_alumno) left join cursos USING(id_curso) where id_curso is null;

-- matrículas de alumnos inexistentes

SELECT * FROM alumnos right join matriculas using(id_alumno) where nombre is null;