/**
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl.fuzzyLanguage;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Fuzzy System Building</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link org.xtext.example.mydsl.fuzzyLanguage.FuzzySystemBuilding#getAffectations <em>Affectations</em>}</li>
 * </ul>
 *
 * @see org.xtext.example.mydsl.fuzzyLanguage.FuzzyLanguagePackage#getFuzzySystemBuilding()
 * @model
 * @generated
 */
public interface FuzzySystemBuilding extends EObject
{
  /**
   * Returns the value of the '<em><b>Affectations</b></em>' containment reference list.
   * The list contents are of type {@link org.xtext.example.mydsl.fuzzyLanguage.Affectation}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Affectations</em>' containment reference list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Affectations</em>' containment reference list.
   * @see org.xtext.example.mydsl.fuzzyLanguage.FuzzyLanguagePackage#getFuzzySystemBuilding_Affectations()
   * @model containment="true"
   * @generated
   */
  EList<Affectation> getAffectations();

} // FuzzySystemBuilding
