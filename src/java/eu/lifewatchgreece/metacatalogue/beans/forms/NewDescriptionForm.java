package eu.lifewatchgreece.metacatalogue.beans.forms;

import java.lang.reflect.Field;
import net.gougousis.gvalidator.base.BaseForm;
import net.gougousis.gvalidator.base.FormBean;
import net.gougousis.gvalidator.constraints.IsDate;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.URL;

/**
 *
 * @author Alexandros
 */
public class NewDescriptionForm extends BaseForm implements FormBean {
    
    protected String datasetId;
    
    @NotBlank
    protected String datasetName;
    
    protected String parentDatasetName;
    
    protected String description;
    
    protected String publicationDate;
    
    protected String creationDate;
    
    protected String datasetType;
    
    @NotBlank
    protected String accessMethod;
    
    @NotBlank
    protected String owner;
    
    protected String creator;
    
    @NotBlank
    protected String curator;
    
    @NotBlank
    protected String curatorEmail;
    
    protected String contributors;
    
    protected String publisher;
    
    protected String keeper;
    
    @URL
    protected String locatedAt;
    
    protected String rights;
    
    protected String rightsHolder;
    
    @IsDate(dateFormat="dd-MM-yyyy")
    protected String embargoFrom;
    
    @IsDate(dateFormat="dd-MM-yyyy")
    protected String embargoTo;
    
    protected String embargoState;
    
    protected String imageURL;
    
    /**
     * @return the datasetId
     */
    public String getDatasetId() {
        return datasetId;
    }

    /**
     * @param datasetId the datasetId to set
     */
    public void setDatasetId(String datasetId) {
        this.datasetId = datasetId;
    }

    /**
     * @return the datasetName
     */
    public String getDatasetName() {
        return datasetName;
    }

    /**
     * @param datasetName the datasetName to set
     */
    public void setDatasetName(String datasetName) {
        this.datasetName = datasetName;
    }

    /**
     * @return the parentDatasetName
     */
    public String getParentDatasetName() {
        return parentDatasetName;
    }

    /**
     * @param parentDatasetName the parentDatasetName to set
     */
    public void setParentDatasetName(String parentDatasetName) {
        this.parentDatasetName = parentDatasetName;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the publicationDate
     */
    public String getPublicationDate() {
        return publicationDate;
    }

    /**
     * @param publicationDate the publicationDate to set
     */
    public void setPublicationDate(String publicationDate) {
        this.publicationDate = publicationDate;
    }

    /**
     * @return the creationDate
     */
    public String getCreationDate() {
        return creationDate;
    }

    /**
     * @param creationDate the creationDate to set
     */
    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    /**
     * @return the datasetType
     */
    public String getDatasetType() {
        return datasetType;
    }

    /**
     * @param datasetType the datasetType to set
     */
    public void setDatasetType(String datasetType) {
        this.datasetType = datasetType;
    }

    /**
     * @return the accessMethod
     */
    public String getAccessMethod() {
        return accessMethod;
    }

    /**
     * @param accessMethod the accessMethod to set
     */
    public void setAccessMethod(String accessMethod) {
        this.accessMethod = accessMethod;
    }

    /**
     * @return the owner
     */
    public String getOwner() {
        return owner;
    }

    /**
     * @param owner the owner to set
     */
    public void setOwner(String owner) {
        this.owner = owner;
    }

    /**
     * @return the creator
     */
    public String getCreator() {
        return creator;
    }

    /**
     * @param creator the creator to set
     */
    public void setCreator(String creator) {
        this.creator = creator;
    }

    /**
     * @return the curator
     */
    public String getCurator() {
        return curator;
    }

    /**
     * @param curator the curator to set
     */
    public void setCurator(String curator) {
        this.curator = curator;
    }

    /**
     * @return the curatorEmail
     */
    public String getCuratorEmail() {
        return curatorEmail;
    }

    /**
     * @param curatorEmail the curatorEmail to set
     */
    public void setCuratorEmail(String curatorEmail) {
        this.curatorEmail = curatorEmail;
    }

    /**
     * @return the contributors
     */
    public String getContributors() {
        return contributors;
    }

    /**
     * @param contributors the contributors to set
     */
    public void setContributors(String contributors) {
        this.contributors = contributors;
    }

    /**
     * @return the publisher
     */
    public String getPublisher() {
        return publisher;
    }

    /**
     * @param publisher the publisher to set
     */
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    /**
     * @return the keeper
     */
    public String getKeeper() {
        return keeper;
    }

    /**
     * @param keeper the keeper to set
     */
    public void setKeeper(String keeper) {
        this.keeper = keeper;
    }

    /**
     * @return the locatedAt
     */
    public String getLocatedAt() {
        return locatedAt;
    }

    /**
     * @param locatedAt the locatedAt to set
     */
    public void setLocatedAt(String locatedAt) {
        this.locatedAt = locatedAt;
    }

    /**
     * @return the rights
     */
    public String getRights() {
        return rights;
    }

    /**
     * @param rights the rights to set
     */
    public void setRights(String rights) {
        this.rights = rights;
    }

    /**
     * @return the rightsHolder
     */
    public String getRightsHolder() {
        return rightsHolder;
    }

    /**
     * @param rightsHolder the rightsHolder to set
     */
    public void setRightsHolder(String rightsHolder) {
        this.rightsHolder = rightsHolder;
    }

    /**
     * @return the embargoFrom
     */
    public String getEmbargoFrom() {
        return embargoFrom;
    }

    /**
     * @param embargoFrom the embargoFrom to set
     */
    public void setEmbargoFrom(String embargoFrom) {
        this.embargoFrom = embargoFrom;
    }

    /**
     * @return the embargoTo
     */
    public String getEmbargoTo() {
        return embargoTo;
    }

    /**
     * @param embargoTo the embargoTo to set
     */
    public void setEmbargoTo(String embargoTo) {
        this.embargoTo = embargoTo;
    }

    /**
     * @return the embargoState
     */
    public String getEmbargoState() {
        return embargoState;
    }

    /**
     * @param embargoState the embargoState to set
     */
    public void setEmbargoState(String embargoState) {
        this.embargoState = embargoState;
    }

    /**
     * @return the imageURL
     */
    public String getImageURL() {
        return imageURL;
    }

    /**
     * @param imageURL the imageURL to set
     */
    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
    
}
