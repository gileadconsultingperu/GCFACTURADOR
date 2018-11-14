/** 
    Compañia            : Gilead Consulting S.A.C.
    Sistema             : GC-Business
    Módulo              : DAO
    Nombre              : DaoAccion.java
    Versión             : 1.0
    Fecha Creación      : 21-08-2018
    Autor Creación      : Pablo Jimenez Aguado
    Uso                 : Interface con declaracion de metodos que acceden a la BD
*/
package gilead.gcfacturador.dao;

import java.util.List;

public interface DaoAccion {
    public String accionCrear(Object obj);
    public Object accionObtener(Integer id);
    public String accionActualizar(Object obj);
    public String accionEliminar(Integer id);
    public List<?> accionListar();
    public String accionActivar(Integer id);
}
