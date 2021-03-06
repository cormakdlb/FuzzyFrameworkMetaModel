/*
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl.validation

import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.fuzzyLanguage.Affectation
import org.xtext.example.mydsl.fuzzyLanguage.FuzzyLanguagePackage.Literals
import org.xtext.example.mydsl.fuzzyLanguage.impl.TypeSetImpl
import org.xtext.example.mydsl.fuzzyLanguage.Expression
import org.xtext.example.mydsl.fuzzyLanguage.Output

/**
 * This class contains custom validation rules. 
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class FuzzyLanguageValidator extends AbstractFuzzyLanguageValidator {
	var String type;

	@Check
	def checkTypeImpl(TypeSetImpl impl) {
		type = impl.typeName
	}

	@Check
	def checkAffectation(Affectation a) {
		if (a.value !== null) {
			if (a.value.equals("Gaussian")) {
				if (a.params.size !== 2) {
					error('''Gaussian function requires 2 parameters : center:�type� and stddev:�type�''',
						Literals.AFFECTATION__VALUE);
					return;
				}
			}
			if (a.value.equals("Ramp")) {
				if (a.params.size !== 3) {
					error('''Ramp function requires 3 parameters : min:�type�, max:�type� and direction''',
						Literals.AFFECTATION__VALUE);
					return;
				}
				if (!a.params.get(2).value.equals("Up") && !a.params.get(2).value.equals("Down")) {
					error("The 3rd parameter has to be a direction : Up or Down", Literals.AFFECTATION__VALUE);
					return;
				}
			}
			if (a.value.equals("Triangle")) {
				if (a.params.size !== 3) {
					error('''Triangle function requires 3 parameters : min:�type� , mid:�type�  and max:�type� ''',
						Literals.AFFECTATION__VALUE);
					return;
				}
			}
			if (a.value.equals("Trapeze")) {
				if (a.params.size !== 5) {
					error('''Trapeze function requires 5 parameters : min:�type� , left:�type� , right:�type� , max:�type�  and concavity''',
						Literals.AFFECTATION__VALUE);
					return;
				}
				if (!a.params.get(4).value.equals("CONCAVE") && !a.params.get(4).value.equals("CONVEXE")) {
					error("The 5th parameter has to be a concavity : CONCAVE or CONVEXE", Literals.AFFECTATION__VALUE);
					return;
				}
			}
		}
		for (var i = 0; i < a.eContainer.eAllContents.filter(Affectation).toList.size(); i++) {
			if (a.eContainer.eAllContents.filter(Affectation).toList.get(i).name.equals(a.name)) {
				if (a.eContainer.eAllContents.filter(Affectation).toList.get(i) !== a) {
					warning("Be careful, \"" + a.name + "\" has already been defined", Literals.AFFECTATION__NAME);
				}
			}
		}
	}

	@Check
	def checkExpression(Expression e) {
		if (e.name.equals("AND") || e.name.equals("NOT") || e.name.equals("OR") || e.name.equals("DEFUZZ") ||
			e.name.equals("THEN") || e.name.equals("AGG")) {
			if (e.exps.size !== 2) {
				error("This operator requires 2 expressions", Literals.EXPRESSION__NAME);
				return;
			}
		} else {
			if (!IsNameDefine(e)) {
				error("You can't use this name because it has not been define yet", Literals.EXPRESSION__NAME);
				return;
			}
		}
	}

	def IsNameDefine(Expression e) {
		var parent = e.eContainer;
		while (!parent.class.toString.equals(
			"class org.xtext.example.mydsl.fuzzyLanguage.impl.FuzzySystemBuildingImpl")) {
			parent = parent.eContainer;
		}
		for (var i = 0; i < parent.eAllContents.filter(Affectation).toList.size(); i++) {
			if (parent.eAllContents.filter(Affectation).toList.get(i).name.equals(e.name)) {
				return true;
			}
		}
		return false;
	}

	@Check
	def checkOutput(Output o) {
		if (o.path !== null) {
			var str1 = '"';
			var str2 = "'";
			if (o.path.toString.charAt(0) !== str1.charAt(0) && o.path.toString.charAt(0) !== str2.charAt(0)) {
				error('You have to indicate a path like : "folder/file.extension"', Literals.OUTPUT__PATH);
				return;
			}
			if (!o.path.toString.contains("/")) {
				warning(
					"Your path doesn't contain any \"/\" character, ensure you are indicating a real path like \"folder/file.extension\"",
					Literals.OUTPUT__PATH);
			}
			if (!o.path.toString.contains(".")) {
				warning(
					"Your path doesn't contain a \".\" character, ensure you are indicating a real path like \"folder/file.extension\"",
					Literals.OUTPUT__PATH);
			}
		}
	}
}