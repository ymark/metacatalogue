/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eu.lifewatchgreece.metacatalogue.tags;

import java.io.IOException;
import java.io.StringWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author Alexandros
 */
public class DateTimeTag extends SimpleTagSupport {
    
    private Integer dLen;
    private Integer fLen;
    private Integer lLen;
    private String fType;
    private String fName;
    private String fTitle;    
    private boolean fReq;
    private String fDefault;

    /**
     * @param dLen the dLen to set
     */
    public void setdLen(Integer dLen) {
        this.dLen = dLen;
    }
    
    /**
     * @param fLen the fLen to set
     */
    public void setfLen(Integer fLen) {
        this.fLen = fLen;
    }
    
    /**
     * @param lLen the lLen to set
     */
    public void setlLen(Integer lLen) {
        this.lLen = lLen;
    }

    /**
     * @param fType the fType to set
     */
    public void setfType(String fType) {
        this.fType = fType;
    }

    /**
     * @param fName the fName to set
     */
    public void setfName(String fName) {
        this.fName = fName;
    }
    
    /**
     * @param fTitle the fTitle to set
     */
    public void setfTitle(String fTitle) {
        this.fTitle = fTitle;
    }
    
    /**
     * @param fReq the fReq to set
     */
    public void setfReq(boolean fReq) {
        this.fReq = fReq;
    }
    
    /**
     * @param fDefault the fDefault to set
     */
    public void setfDefault(String fDefault) {
        this.fDefault = fDefault;
    }
    
    public void doTag() throws IOException, JspException{
        
        String required;
        if(this.fReq) 
            required = " <ast>*</ast>";
        else
            required = "";
        
        String defaultDate;
        if(this.fDefault == null)             
            defaultDate = "";
        else
            defaultDate = ",defaultDate: new Date(\" (new Date(\""+this.fDefault+"\")) \")";            
        
        String html = "<div class='col-md-"+this.dLen+"'>"
                        + "<label for='"+this.fName+"' class='col-sm-"+this.lLen+" control-label'>"+this.fTitle+required+"</label>"
                        + "<div class='col-sm-"+this.fLen+"'>"
                        + "<div class='input-group date' id='"+this.fName+"'>"
                        + " <input type='text' class='form-control' name='"+this.fName+"' />"
                        + "<span class='input-group-addon'>"
                        + "<span class='glyphicon glyphicon-calendar'></span>"
                        + "</span>"
                        + "</div>"
                        + "</div>"
                        + "</div>"
                        + "<script type='text/javascript'>"
                        + "$('#"+this.fName+"').datetimepicker({"
                        + "viewMode: 'years'," 
                        + "format: 'DD/MM/YYYY'"
                        + defaultDate
                        + "});"
                        + "</script>";
        
        JspWriter out = getJspContext().getOut();
        out.print(html);
    }
    
}
