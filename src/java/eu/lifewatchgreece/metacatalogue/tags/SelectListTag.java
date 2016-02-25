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
public class SelectListTag extends SimpleTagSupport {
    
    private Integer dLen;
    private Integer fLen;
    private Integer lLen;
    private String fType;
    private String fName;
    private String fTitle;    
    private boolean fReq;

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
    
    public void doTag() throws IOException, JspException{
        
        final StringWriter stringWriter = new StringWriter();
        getJspBody().invoke(stringWriter);
        String tagBody = stringWriter.getBuffer().toString();
        String options = "";
        if(tagBody.length() >0) {
            String[] parts = tagBody.split(",");
            for(String option: parts){
                options = options+"<li><a data-value='"+option.trim()+"'>"+option.trim()+"</a></li>";
            }
        } 
        
        String required;
        if(this.fReq) 
            required = " <ast>*</ast>";
        else
            required = "";
        
        String html = "<div class='col-md-"+this.dLen+"'>"
                        + "<label for=\""+this.fName+"\" class=\"col-sm-"+this.lLen+" control-label\">"+this.fTitle+required+"</label>"
                        + "<div class='col-sm-"+this.fLen+"'>"
                        + "<div class=\"input-group\">"
                        + "<input type='text' class='form-control' id='"+this.fName+"' name='"+this.fName+"' value=''>"
                        + "<div class='input-group-btn'>"
                        + "<button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown' aria-expanded='false'>Use List <span class='caret'></span></button>"
                        + "<ul class='dropdown-menu dropdown-menu-right' role='menu' id='"+this.fName+"List'>"
                        + options
                        + "</ul>"
                        + "</div>"
                        + "</div>"
                        + "</div>"
                        + "</div>"
                        + "<script type='text/javascript'>"
                        + "$('#"+this.fName+"List li a').click(function(event){"
                        + "$('#"+this.fName+"').val($(this).attr('data-value')).change();"
                        + "});"
                        + "</script>";
        
        JspWriter out = getJspContext().getOut();
        out.print(html);
    }
    
}
