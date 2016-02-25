package eu.lifewatchgreece.metacatalogue.helpers;

/**
 * A class to carry validation error information for form fields
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class FieldErrorInfo {
    
    private String fieldName;
    private String oldValue;
    private String errorMessage;
    
    public FieldErrorInfo(String fieldName,String errorMessage,String oldValue){
        this.fieldName = fieldName;
        this.errorMessage = errorMessage;
        this.oldValue = oldValue;        
    }

    /**
     * @return the fieldName
     */
    public String getFieldName() {
        return fieldName;
    }

    /**
     * @param fieldName the fieldName to set
     */
    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    /**
     * @return the oldValue
     */
    public String getOldValue() {
        return oldValue;
    }

    /**
     * @param oldValue the oldValue to set
     */
    public void setOldValue(String oldValue) {
        this.oldValue = oldValue;
    }

    /**
     * @return the errorMessage
     */
    public String getErrorMessage() {
        return errorMessage;
    }

    /**
     * @param errorMessage the errorMessage to set
     */
    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
    
}
