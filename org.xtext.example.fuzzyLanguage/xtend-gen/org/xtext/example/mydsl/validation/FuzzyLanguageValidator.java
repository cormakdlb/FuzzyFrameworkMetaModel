/**
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl.validation;

import com.google.common.collect.Iterators;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.validation.Check;
import org.eclipse.xtext.xbase.lib.IteratorExtensions;
import org.xtext.example.mydsl.fuzzyLanguage.Affectation;
import org.xtext.example.mydsl.fuzzyLanguage.Expression;
import org.xtext.example.mydsl.fuzzyLanguage.FuzzyLanguagePackage;
import org.xtext.example.mydsl.fuzzyLanguage.Output;
import org.xtext.example.mydsl.fuzzyLanguage.impl.TypeSetImpl;
import org.xtext.example.mydsl.validation.AbstractFuzzyLanguageValidator;

/**
 * This class contains custom validation rules.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
@SuppressWarnings("all")
public class FuzzyLanguageValidator extends AbstractFuzzyLanguageValidator {
  private String type;
  
  @Check
  public String checkTypeImpl(final TypeSetImpl impl) {
    return this.type = impl.getTypeName();
  }
  
  @Check
  public void checkAffectation(final Affectation a) {
    String _value = a.getValue();
    boolean _tripleNotEquals = (_value != null);
    if (_tripleNotEquals) {
      boolean _equals = a.getValue().equals("Gaussian");
      if (_equals) {
        int _size = a.getParams().size();
        boolean _tripleNotEquals_1 = (_size != 2);
        if (_tripleNotEquals_1) {
          StringConcatenation _builder = new StringConcatenation();
          _builder.append("Gaussian function requires 2 parameters : center:");
          _builder.append(this.type);
          _builder.append(" and stddev:");
          _builder.append(this.type);
          this.error(_builder.toString(), 
            FuzzyLanguagePackage.Literals.AFFECTATION__VALUE);
          return;
        }
      }
      boolean _equals_1 = a.getValue().equals("Ramp");
      if (_equals_1) {
        int _size_1 = a.getParams().size();
        boolean _tripleNotEquals_2 = (_size_1 != 3);
        if (_tripleNotEquals_2) {
          StringConcatenation _builder_1 = new StringConcatenation();
          _builder_1.append("Ramp function requires 3 parameters : min:");
          _builder_1.append(this.type);
          _builder_1.append(", max:");
          _builder_1.append(this.type);
          _builder_1.append(" and direction");
          this.error(_builder_1.toString(), 
            FuzzyLanguagePackage.Literals.AFFECTATION__VALUE);
          return;
        }
        if (((!a.getParams().get(2).getValue().equals("Up")) && (!a.getParams().get(2).getValue().equals("Down")))) {
          this.error("The 3rd parameter has to be a direction : Up or Down", FuzzyLanguagePackage.Literals.AFFECTATION__VALUE);
          return;
        }
      }
      boolean _equals_2 = a.getValue().equals("Triangle");
      if (_equals_2) {
        int _size_2 = a.getParams().size();
        boolean _tripleNotEquals_3 = (_size_2 != 3);
        if (_tripleNotEquals_3) {
          StringConcatenation _builder_2 = new StringConcatenation();
          _builder_2.append("Triangle function requires 3 parameters : min:");
          _builder_2.append(this.type);
          _builder_2.append(" , mid:");
          _builder_2.append(this.type);
          _builder_2.append("  and max:");
          _builder_2.append(this.type);
          _builder_2.append(" ");
          this.error(_builder_2.toString(), 
            FuzzyLanguagePackage.Literals.AFFECTATION__VALUE);
          return;
        }
      }
      boolean _equals_3 = a.getValue().equals("Trapeze");
      if (_equals_3) {
        int _size_3 = a.getParams().size();
        boolean _tripleNotEquals_4 = (_size_3 != 5);
        if (_tripleNotEquals_4) {
          StringConcatenation _builder_3 = new StringConcatenation();
          _builder_3.append("Trapeze function requires 5 parameters : min:");
          _builder_3.append(this.type);
          _builder_3.append(" , left:");
          _builder_3.append(this.type);
          _builder_3.append(" , right:");
          _builder_3.append(this.type);
          _builder_3.append(" , max:");
          _builder_3.append(this.type);
          _builder_3.append("  and concavity");
          this.error(_builder_3.toString(), 
            FuzzyLanguagePackage.Literals.AFFECTATION__VALUE);
          return;
        }
        if (((!a.getParams().get(4).getValue().equals("CONCAVE")) && (!a.getParams().get(4).getValue().equals("CONVEXE")))) {
          this.error("The 5th parameter has to be a concavity : CONCAVE or CONVEXE", FuzzyLanguagePackage.Literals.AFFECTATION__VALUE);
          return;
        }
      }
    }
    for (int i = 0; (i < IteratorExtensions.<Affectation>toList(Iterators.<Affectation>filter(a.eContainer().eAllContents(), Affectation.class)).size()); i++) {
      boolean _equals_4 = IteratorExtensions.<Affectation>toList(Iterators.<Affectation>filter(a.eContainer().eAllContents(), Affectation.class)).get(i).getName().equals(a.getName());
      if (_equals_4) {
        Affectation _get = IteratorExtensions.<Affectation>toList(Iterators.<Affectation>filter(a.eContainer().eAllContents(), Affectation.class)).get(i);
        boolean _tripleNotEquals_5 = (_get != a);
        if (_tripleNotEquals_5) {
          String _name = a.getName();
          String _plus = ("Be carefull, \"" + _name);
          String _plus_1 = (_plus + "\" has already been defined");
          this.warning(_plus_1, FuzzyLanguagePackage.Literals.AFFECTATION__NAME);
        }
      }
    }
  }
  
  @Check
  public void checkExpression(final Expression e) {
    if ((((((e.getName().equals("AND") || e.getName().equals("NOT")) || e.getName().equals("OR")) || e.getName().equals("DEFUZZ")) || 
      e.getName().equals("THEN")) || e.getName().equals("AGG"))) {
      int _size = e.getExps().size();
      boolean _tripleNotEquals = (_size != 2);
      if (_tripleNotEquals) {
        this.error("This operator requires 2 expressions", FuzzyLanguagePackage.Literals.EXPRESSION__NAME);
        return;
      }
    } else {
      boolean _IsNameDefine = this.IsNameDefine(e);
      boolean _not = (!_IsNameDefine);
      if (_not) {
        this.error("You can\'t use this name because it has not been define yet", FuzzyLanguagePackage.Literals.EXPRESSION__NAME);
        return;
      }
    }
  }
  
  public boolean IsNameDefine(final Expression e) {
    EObject parent = e.eContainer();
    while ((!parent.getClass().toString().equals(
      "class org.xtext.example.mydsl.fuzzyLanguage.impl.FuzzySystemBuildingImpl"))) {
      parent = parent.eContainer();
    }
    for (int i = 0; (i < IteratorExtensions.<Affectation>toList(Iterators.<Affectation>filter(parent.eAllContents(), Affectation.class)).size()); i++) {
      boolean _equals = IteratorExtensions.<Affectation>toList(Iterators.<Affectation>filter(parent.eAllContents(), Affectation.class)).get(i).getName().equals(e.getName());
      if (_equals) {
        return true;
      }
    }
    return false;
  }
  
  @Check
  public void checkOutput(final Output o) {
    String _path = o.getPath();
    boolean _tripleNotEquals = (_path != null);
    if (_tripleNotEquals) {
      String str1 = "\"";
      String str2 = "\'";
      if (((o.getPath().toString().charAt(0) != str1.charAt(0)) && (o.getPath().toString().charAt(0) != str2.charAt(0)))) {
        this.error("You have to indicate a path like : \"folder/file.extension\"", FuzzyLanguagePackage.Literals.OUTPUT__PATH);
        return;
      }
      boolean _contains = o.getPath().toString().contains("/");
      boolean _not = (!_contains);
      if (_not) {
        this.warning(
          "Your path doesn\'t contain any \"/\" character, ensure you are indicating a real path like \"folder/file.extension\"", 
          FuzzyLanguagePackage.Literals.OUTPUT__PATH);
      }
      boolean _contains_1 = o.getPath().toString().contains(".");
      boolean _not_1 = (!_contains_1);
      if (_not_1) {
        this.warning(
          "Your path doesn\'t contain a \".\" character, ensure you are indicating a real path like \"folder/file.extension\"", 
          FuzzyLanguagePackage.Literals.OUTPUT__PATH);
      }
    }
  }
}
