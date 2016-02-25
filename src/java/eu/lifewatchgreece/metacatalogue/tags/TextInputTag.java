/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eu.lifewatchgreece.metacatalogue.tags;

import java.io.IOException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author Alexandros
 */
public class TextInputTag extends SimpleTagSupport {
    
    private Integer dLen;
    private Integer fLen;
    private Integer lLen;
    private String fType;
    private String fName;
    private String fTitle;   
    private boolean fReq;
    private boolean fDisable;
    private boolean fReadonly;

    /**
     * @param dLen the fLength to set
     */
    public void setdLen(Integer dLen) {
        this.dLen = dLen;
    }
    
    /**
     * @param fLen the fLength to set
     */
    public void setfLen(Integer fLen) {
        this.fLen = fLen;
    }
    
    /**
     * @param lLen the fLength to set
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
     * @param fDisable the fDisable to set
     */
    public void setfDisable(boolean fDisable) {
        this.fDisable = fDisable;
    }
    
    /**
     * @param fReadonly the fReadonly to set
     */
    public void setfReadonly(boolean fReadonly) {
        this.fReadonly = fReadonly;
    }
    
    public void doTag() throws IOException{
        
        String required;
        String disabled;
        String readonly;
        
        if(this.fReq) 
            required = " <ast>*</ast>";
        else
            required = "";
        
        if(this.fDisable) 
            disabled = " disabled";
        else
            disabled = "";
        
        if(this.fReadonly) 
            readonly = " readonly";
        else
            readonly = "";
        
        String html = "<div class='col-md-"+this.dLen+"'>"
                        + "<label for=\""+this.fName+"\" class=\"col-sm-"+this.lLen+" control-label\">"+this.fTitle+required+"</label>"
                        + "<div class='col-sm-"+this.fLen+"'>"
                        + "<input type='text' class='form-control' id='"+this.fName+"' name='"+this.fName+"' value='' "+disabled+" "+readonly+"> "
                        + "</div>"
                        + "</div>";
        
        JspWriter out = getJspContext().getOut();
        out.print(html);
    }
    
}
