package eu.lifewatchgreece.metacatalogue.helpers;

import java.sql.Timestamp;

/**
 * A class to carry system setting information
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class SystemSetting {
    
    private String sname;
    private String svalue;
    private Timestamp lastModified;
    private String about;

    /**
     * @return the sname
     */
    public String getSname() {
        return sname;
    }

    /**
     * @param sname the sname to set
     */
    public void setSname(String sname) {
        this.sname = sname;
    }

    /**
     * @return the svalue
     */
    public String getSvalue() {
        return svalue;
    }

    /**
     * @param svalue the svalue to set
     */
    public void setSvalue(String svalue) {
        this.svalue = svalue;
    }

    /**
     * @return the lastModified
     */
    public Timestamp getLastModified() {
        return lastModified;
    }

    /**
     * @param lastModified the lastModified to set
     */
    public void setLastModified(Timestamp lastModified) {
        this.lastModified = lastModified;
    }

    /**
     * @return the about
     */
    public String getAbout() {
        return about;
    }

    /**
     * @param about the about to set
     */
    public void setAbout(String about) {
        this.about = about;
    }
    
}
